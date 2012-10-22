From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 15:07:22 +0300
Subject: [PATCH] arm: sched: stop sched_clock() during suspend
In-Reply-To: <1350906877-19410-1-git-send-email-balbi@ti.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
Message-ID: <20121022120722.GV14033@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 22, 2012 at 02:54:37PM +0300, Felipe Balbi wrote:
> The scheduler imposes a requirement to sched_clock()
> which is to stop the clock during suspend, if we don't
> do that IRQ threads will be rescheduled in the future
> which might cause transfers to timeout depending on
> how driver is written.
> 
> This became an issue on OMAP when we converted omap-i2c.c
> to use threaded IRQs, it turned out that depending on how
> much time we spent on suspend, the I2C IRQ thread would
> end up being rescheduled so far in the future that I2C
> transfers would timeout and, because omap_hsmmc depends
> on an I2C-connected device to detect if an MMC card is
> inserted in the slot, our rootfs would just vanish.
> 
> arch/arm/kernel/sched_clock.c already had an optional
> implementation (sched_clock_needs_suspend()) which would
> handle scheduler's requirement properly, what this patch
> does is simply to make that implementation non-optional.
> 
> This has been tested with beagleboard XM (OMAP3630) and
> pandaboard rev A3 (OMAP4430). Suspend to RAM is now working
> after this patch.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

just adding more guys to Cc. Please add more if I have missed someone.

> ---
>  arch/arm/include/asm/sched_clock.h |  2 --
>  arch/arm/kernel/sched_clock.c      | 18 ++++--------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
> index 05b8e82..e3f7572 100644
> --- a/arch/arm/include/asm/sched_clock.h
> +++ b/arch/arm/include/asm/sched_clock.h
> @@ -10,7 +10,5 @@
>  
>  extern void sched_clock_postinit(void);
>  extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
> -extern void setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
> -		unsigned long rate);
>  
>  #endif
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index e21bac2..fc6692e 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -107,13 +107,6 @@ static void sched_clock_poll(unsigned long wrap_ticks)
>  	update_sched_clock();
>  }
>  
> -void __init setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
> -		unsigned long rate)
> -{
> -	setup_sched_clock(read, bits, rate);
> -	cd.needs_suspend = true;
> -}
> -
>  void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
>  {
>  	unsigned long r, w;
> @@ -189,18 +182,15 @@ void __init sched_clock_postinit(void)
>  static int sched_clock_suspend(void)
>  {
>  	sched_clock_poll(sched_clock_timer.data);
> -	if (cd.needs_suspend)
> -		cd.suspended = true;
> +	cd.suspended = true;
>  	return 0;
>  }
>  
>  static void sched_clock_resume(void)
>  {
> -	if (cd.needs_suspend) {
> -		cd.epoch_cyc = read_sched_clock();
> -		cd.epoch_cyc_copy = cd.epoch_cyc;
> -		cd.suspended = false;
> -	}
> +	cd.epoch_cyc = read_sched_clock();
> +	cd.epoch_cyc_copy = cd.epoch_cyc;
> +	cd.suspended = false;
>  }
>  
>  static struct syscore_ops sched_clock_ops = {
> -- 
> 1.8.0.rc0
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/01b6c272/attachment.sig>
