From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 27 Sep 2009 07:19:51 +0100
Subject: [PATCH v2 4/5] Add suspend/resume support for rx1950
In-Reply-To: <4abe82e7.0405560a.5ebe.4296@mx.google.com>
References: <4abe82e7.0405560a.5ebe.4296@mx.google.com>
Message-ID: <20090927061951.GM31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 12:04:57AM +0300, Vasily Khoruzhick wrote:
> 

> From d80afd66257a726995981c5376ab2d4854e8b120 Mon Sep 17 00:00:00 2001
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Date: Tue, 22 Sep 2009 20:59:04 +0300
> Subject: [PATCH v2 4/5] Add suspend/resume support for rx1950
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/pm.c |   23 +++++++++++++++++++++--
>  arch/arm/mm/mmu.c          |    5 +++--
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/pm.c b/arch/arm/mach-s3c2410/pm.c
> index 966119c..f2f3235 100644
> --- a/arch/arm/mach-s3c2410/pm.c
> +++ b/arch/arm/mach-s3c2410/pm.c
> @@ -60,10 +60,10 @@ static void s3c2410_pm_prepare(void)
>  		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
>  	}
>  
> -	/* the RX3715 uses similar code and the same H1940 and the
> +	/* RX3715 and RX1950 use similar to H1940 code and the
>  	 * same offsets for resume and checksum pointers */
>  
> -	if (machine_is_rx3715()) {
> +	if (machine_is_rx3715() || machine_is_rx1950()) {
>  		void *base = phys_to_virt(H1940_SUSPEND_CHECK);
>  		unsigned long ptr;
>  		unsigned long calc = 0;
> @@ -74,6 +74,19 @@ static void s3c2410_pm_prepare(void)
>  			calc += __raw_readl(base+ptr);
>  
>  		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
> +		if (machine_is_rx1950()) {
> +			/* According to S3C2442 user's manual, page 7-17,
> +			 * when the system is operating in NAND boot mode,
> +			 * the hardware pin configuration - EINT[23:21] ???
> +			 * must be set as input for starting up after
> +			 * wakeup from sleep mode */

given this is generic to the s3c2442, why put this here? it also holds
for the s3c2440 too... think about an implementation for the cpu's
sysdev for all nand-booting systems.

> +			s3c2410_gpio_cfgpin(S3C2410_GPG(15),
> +				S3C2410_GPIO_INPUT);
> +			s3c2410_gpio_cfgpin(S3C2410_GPG(14),
> +				S3C2410_GPIO_INPUT);
> +			s3c2410_gpio_cfgpin(S3C2410_GPG(13),
> +				S3C2410_GPIO_INPUT);
> +		}
>  	}
>  
>  	if ( machine_is_aml_m5900() )
> @@ -94,6 +107,12 @@ static int s3c2410_pm_resume(struct sys_device *dev)
>  	if ( machine_is_aml_m5900() )
>  		s3c2410_gpio_setpin(S3C2410_GPF(2), 0);
>  
> +	if (machine_is_rx1950()) {
> +		s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_EINT23);
> +		s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_EINT22);
> +		s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_EINT21);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4426ee6..a13923e 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -827,9 +827,10 @@ void __init reserve_node_zero(pg_data_t *pgdat)
>  	if (machine_is_p720t())
>  		res_size = 0x00014000;
>  
> -	/* H1940 and RX3715 need to reserve this for suspend */
> +	/* H1940, RX3715 and RX1950 need to reserve this for suspend */
>  
> -	if (machine_is_h1940() || machine_is_rx3715()) {
> +	if (machine_is_h1940() || machine_is_rx3715()
> +		|| machine_is_rx1950()) {
>  		reserve_bootmem_node(pgdat, 0x30003000, 0x1000,
>  				BOOTMEM_DEFAULT);
>  		reserve_bootmem_node(pgdat, 0x30081000, 0x1000,
> -- 
> 1.6.5.rc1
> 

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
