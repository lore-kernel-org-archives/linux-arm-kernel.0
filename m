From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 16 Aug 2011 08:46:22 +0200
Subject: [PATCH] ARM: s3c24xx: ensure cpu_reset is only called when memory
	is flat-mapped
In-Reply-To: <1313429662-3145-1-git-send-email-will.deacon@arm.com>
References: <1313429662-3145-1-git-send-email-will.deacon@arm.com>
Message-ID: <201108160846.25150.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 15. August 2011, 19:34:22 schrieb Will Deacon:
> s3c24xx_pm_restart makes a direct call to arch_reset, without first
> establishing a 1:1 memory mapping. arch_reset will then call
> cpu_reset(0), which is designed to be called only with an identity map
> in place.
> 
> Following the discussion here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/057281.html
> 
> This patch ensures that arch_reset is only called via arm_machine_restart
> so that we have a consistent flat mapping requirement for the MMU-off
> code.
I'm not 100% sure, but you might want to include Kukjin Kim 
<kgene.kim@samsung.com> who seems to be handling the Samsung-stuff most of the 
time.

> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/plat-s3c24xx/cpu.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
> index c1fc6c6..528930c 100644
> --- a/arch/arm/plat-s3c24xx/cpu.c
> +++ b/arch/arm/plat-s3c24xx/cpu.c
> @@ -198,18 +198,6 @@ static unsigned long s3c24xx_read_idcode_v4(void)
>   */
>  static void s3c24xx_pm_restart(char mode, const char *cmd)
>  {
> -	if (mode != 's') {
> -		unsigned long flags;
> -
> -		local_irq_save(flags);
> -		__cpuc_flush_kern_all();
> -		__cpuc_flush_user_all();
> -
> -		arch_reset(mode, cmd);
> -		local_irq_restore(flags);
> -	}
> -
> -	/* fallback, or unhandled */
>  	arm_machine_restart(mode, cmd);
>  }
