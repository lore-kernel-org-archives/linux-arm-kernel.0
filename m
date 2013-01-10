From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Jan 2013 16:32:42 -0800
Subject: [PATCH] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <00ab01cdeeca$02a75e60$07f61b20$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> As per the Exynos5250 User Manual:
> 
> When there are pending interrupt events, WFI/WFE instruction are
> ignored. To cancel the power-down sequence follow these steps:
> 1) Disable system power-down through CENTRAL_SEQ_CONFIGURATION
> and CENTRAL_SEQ_CONFIGURATION_DMC registers
> 2) Clear WAKEUP_STAT register
> 3) Enable interrupt service routine for CPU
> 
> Code for early wakeup for exynos already exists; remove the panic
> on suspend failure, clear the wakeup state register and return
> error from cpu_suspend to indicate a failed suspend (to a user
> daemon).
> 
> Older Samsung SoCs have similar panics and I have removed them all.
> Haven't touched the S3C2410 sleep code.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c          |    6 ++++--
>  arch/arm/mach-s3c24xx/pm-s3c2412.c |    3 ++-
>  arch/arm/mach-s3c24xx/pm-s3c2416.c |    3 ++-
>  arch/arm/mach-s3c64xx/pm.c         |    3 ++-
>  arch/arm/mach-s5p64x0/pm.c         |    4 ++--
>  arch/arm/mach-s5pv210/pm.c         |    4 ++--
>  arch/arm/plat-samsung/pm.c         |    5 ++++-
>  7 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index f459afd..55df38cd 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -92,8 +92,8 @@ static int exynos_cpu_suspend(unsigned long arg)
>  	/* issue the standby signal into the pm unit. */
>  	cpu_do_idle();
> 
> -	/* we should never get past here */
> -	panic("sleep resumed to originator?");
> +	pr_err("Failed to suspend the system\n");
> +	return -EBUSY;

This can be happened under non-error situation, so this should be:

+	pr_info("sleep resumed to originator?");
+	return 1; /* abort suspend */

[...]

- Kukjin
