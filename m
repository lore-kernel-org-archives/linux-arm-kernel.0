From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 22 Oct 2011 04:46:10 +0900
Subject: [PATCH v2] Fix s3c24xx build errors if !CONFIG_PM
In-Reply-To: <20111021135023.GA30167@glitch>
References: <20111018105215.GA10230@glitch>
	<016f01cc8fd5$0dbe40c0$293ac240$%kim@samsung.com>
	<20111021135023.GA30167@glitch>
Message-ID: <4EA1CC02.3080201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/21/11 22:50, Domenico Andreoli wrote:
> From: Domenico Andreoli<cavokz@gmail.com>
>
> v2:
> - register_syscore_ops(&s3c24xx_irq_syscore_ops) does not need to be
>    conditionally compiled out, it is already optimized out on !CONFIG_PM
> - fix also s3c2412 and s3c2416 affected by the same build issue
>
> v1:
> s3c2440.c fails to build if !CONFIG_PM because in such case
> s3c2410_pm_syscore_ops is not defined. Same error should happen also
> in s3c2410.c and s3c2442.c
>
> Signed-off-by: Domenico Andreoli<cavokz@gmail.com>
>
> ---
>   arch/arm/mach-s3c2410/s3c2410.c |    2 ++
>   arch/arm/mach-s3c2412/s3c2412.c |    2 ++
>   arch/arm/mach-s3c2416/s3c2416.c |    2 ++
>   arch/arm/mach-s3c2440/s3c2440.c |    2 ++
>   arch/arm/mach-s3c2440/s3c2442.c |    2 ++
>   5 files changed, 10 insertions(+)
>
> Index: b/arch/arm/mach-s3c2410/s3c2410.c
> ===================================================================
> --- a/arch/arm/mach-s3c2410/s3c2410.c
> +++ b/arch/arm/mach-s3c2410/s3c2410.c
> @@ -170,7 +170,9 @@ int __init s3c2410_init(void)
>   {
>   	printk("S3C2410: Initialising architecture\n");
>
> +#ifdef CONFIG_PM
>   	register_syscore_ops(&s3c2410_pm_syscore_ops);
> +#endif
>   	register_syscore_ops(&s3c24xx_irq_syscore_ops);
>
>   	return sysdev_register(&s3c2410_sysdev);
> Index: b/arch/arm/mach-s3c2412/s3c2412.c
> ===================================================================
> --- a/arch/arm/mach-s3c2412/s3c2412.c
> +++ b/arch/arm/mach-s3c2412/s3c2412.c
> @@ -245,7 +245,9 @@ int __init s3c2412_init(void)
>   {
>   	printk("S3C2412: Initialising architecture\n");
>
> +#ifdef CONFIG_PM
>   	register_syscore_ops(&s3c2412_pm_syscore_ops);
> +#endif
>   	register_syscore_ops(&s3c24xx_irq_syscore_ops);
>
>   	return sysdev_register(&s3c2412_sysdev);
> Index: b/arch/arm/mach-s3c2416/s3c2416.c
> ===================================================================
> --- a/arch/arm/mach-s3c2416/s3c2416.c
> +++ b/arch/arm/mach-s3c2416/s3c2416.c
> @@ -97,7 +97,9 @@ int __init s3c2416_init(void)
>
>   	s3c_fb_setname("s3c2443-fb");
>
> +#ifdef CONFIG_PM
>   	register_syscore_ops(&s3c2416_pm_syscore_ops);
> +#endif
>   	register_syscore_ops(&s3c24xx_irq_syscore_ops);
>
>   	return sysdev_register(&s3c2416_sysdev);
> Index: b/arch/arm/mach-s3c2440/s3c2440.c
> ===================================================================
> --- a/arch/arm/mach-s3c2440/s3c2440.c
> +++ b/arch/arm/mach-s3c2440/s3c2440.c
> @@ -55,7 +55,9 @@ int __init s3c2440_init(void)
>
>   	/* register suspend/resume handlers */
>
> +#ifdef CONFIG_PM
>   	register_syscore_ops(&s3c2410_pm_syscore_ops);
> +#endif
>   	register_syscore_ops(&s3c244x_pm_syscore_ops);
>   	register_syscore_ops(&s3c24xx_irq_syscore_ops);
>
> Index: b/arch/arm/mach-s3c2440/s3c2442.c
> ===================================================================
> --- a/arch/arm/mach-s3c2440/s3c2442.c
> +++ b/arch/arm/mach-s3c2440/s3c2442.c
> @@ -169,7 +169,9 @@ int __init s3c2442_init(void)
>   {
>   	printk("S3C2442: Initialising architecture\n");
>
> +#ifdef CONFIG_PM
>   	register_syscore_ops(&s3c2410_pm_syscore_ops);
> +#endif
>   	register_syscore_ops(&s3c244x_pm_syscore_ops);
>   	register_syscore_ops(&s3c24xx_irq_syscore_ops);
>
> --

Looks good to me, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
