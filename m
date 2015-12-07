From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 10:19:14 +0000
Subject: [PATCH CFT] ARM: orion: implement ARM delay timer
In-Reply-To: <E1ZoD3b-0006UD-Rp@rmk-PC.arm.linux.org.uk>
References: <E1ZoD3b-0006UD-Rp@rmk-PC.arm.linux.org.uk>
Message-ID: <20151207101914.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 05:13:07PM +0100, Russell King wrote:
> Implement an ARM delay timer to be used for udelay() on orion legacy
> platforms.  This allows us to skip the delay loop calibration at boot.
> 
> It also means that udelay() will be unaffected by CPU frequency changes
> when cpufreq is enabled on these platforms.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This needs to be tested beyond build testing...

So what's happening with this change?  I see no progress on it.

> 
>  arch/arm/plat-orion/time.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
> index 8085a8aac812..ffb93db68e9c 100644
> --- a/arch/arm/plat-orion/time.c
> +++ b/arch/arm/plat-orion/time.c
> @@ -18,6 +18,7 @@
>  #include <linux/irq.h>
>  #include <linux/sched_clock.h>
>  #include <plat/time.h>
> +#include <asm/delay.h>
>  
>  /*
>   * MBus bridge block registers.
> @@ -188,6 +189,15 @@ orion_time_set_base(void __iomem *_timer_base)
>  	timer_base = _timer_base;
>  }
>  
> +static unsigned long orion_delay_timer_read(void)
> +{
> +	return ~readl(timer_base + TIMER0_VAL_OFF);
> +}
> +
> +static struct delay_timer orion_delay_timer = {
> +	.read_current_timer = orion_delay_timer_read,
> +};
> +
>  void __init
>  orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
>  		unsigned int irq, unsigned int tclk)
> @@ -202,6 +212,9 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
>  
>  	ticks_per_jiffy = (tclk + HZ/2) / HZ;
>  
> +	orion_delay_timer.freq = tclk;
> +	register_current_timer_delay(&orion_delay_timer);
> +
>  	/*
>  	 * Set scale and timer for sched_clock.
>  	 */
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
