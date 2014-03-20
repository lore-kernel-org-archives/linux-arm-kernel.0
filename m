From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 12:59:33 +0900
Subject: [PATCH 49/62] ARM: s5p64x0: fix building with only one soc type
In-Reply-To: <1395257399-359545-50-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-50-git-send-email-arnd@arndb.de>
Message-ID: <020201cf43f0$cd3701e0$67a505a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> The s5p64x0 platform supports two distinct SoCs, s5p6440 and s5p6450,
> and in the normal configuration, both are enabled. However if we build
> a kernel that only enables one of the two, the #ifdef logic in common.c
> breaks down, as some of the functions declared in the header are defined
> to NULL using the preprocessor but then defined anyway.
> 
> This patch cleans up the mess and ensures that each function has either
> exactly one C declaration and one matching C definition, or we have
> a NULL defined function pointer but no C definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Yes you're right, we need to sort them(6440 and 6450) out later though.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s5p64x0/common.c | 18 ++++++++++++++++--
>  arch/arm/mach-s5p64x0/common.h |  5 +----
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-
> s5p64x0/common.c
> index eb2ad14..9a43be0 100644
> --- a/arch/arm/mach-s5p64x0/common.c
> +++ b/arch/arm/mach-s5p64x0/common.c
> @@ -205,6 +205,7 @@ void __init s5p64x0_init_io(struct map_desc
*mach_desc,
> int size)
>  	samsung_pwm_set_platdata(&s5p64x0_pwm_variant);
>  }
> 
> +#ifdef CONFIG_CPU_S5P6440
>  void __init s5p6440_map_io(void)
>  {
>  	/* initialize any device information early */
> @@ -218,7 +219,9 @@ void __init s5p6440_map_io(void)
> 
>  	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
>  }
> +#endif
> 
> +#ifdef CONFIG_CPU_S5P6450
>  void __init s5p6450_map_io(void)
>  {
>  	/* initialize any device information early */
> @@ -232,13 +235,14 @@ void __init s5p6450_map_io(void)
> 
>  	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
>  }
> +#endif
> 
>  /*
>   * s5p64x0_init_clocks
>   *
>   * register and setup the CPU clocks
>   */
> -
> +#ifdef CONFIG_CPU_S5P6440
>  void __init s5p6440_init_clocks(int xtal)
>  {
>  	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> @@ -248,7 +252,9 @@ void __init s5p6440_init_clocks(int xtal)
>  	s5p6440_register_clocks();
>  	s5p6440_setup_clocks();
>  }
> +#endif
> 
> +#ifdef CONFIG_CPU_S5P6450
>  void __init s5p6450_init_clocks(int xtal)
>  {
>  	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> @@ -258,13 +264,14 @@ void __init s5p6450_init_clocks(int xtal)
>  	s5p6450_register_clocks();
>  	s5p6450_setup_clocks();
>  }
> +#endif
> 
>  /*
>   * s5p64x0_init_irq
>   *
>   * register the CPU interrupts
>   */
> -
> +#ifdef CONFIG_CPU_S5P6440
>  void __init s5p6440_init_irq(void)
>  {
>  	/* S5P6440 supports 2 VIC */
> @@ -279,7 +286,9 @@ void __init s5p6440_init_irq(void)
> 
>  	s5p_init_irq(vic, ARRAY_SIZE(vic));
>  }
> +#endif
> 
> +#ifdef CONFIG_CPU_S5P6450
>  void __init s5p6450_init_irq(void)
>  {
>  	/* S5P6450 supports only 2 VIC */
> @@ -294,6 +303,7 @@ void __init s5p6450_init_irq(void)
> 
>  	s5p_init_irq(vic, ARRAY_SIZE(vic));
>  }
> +#endif
> 
>  struct bus_type s5p64x0_subsys = {
>  	.name		= "s5p64x0-core",
> @@ -321,6 +331,7 @@ int __init s5p64x0_init(void)
>  }
> 
>  /* uart registration process */
> +#ifdef CONFIG_CPU_S5P6440
>  void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
>  {
>  	int uart;
> @@ -332,11 +343,14 @@ void __init s5p6440_init_uarts(struct
> s3c2410_uartcfg *cfg, int no)
> 
>  	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
>  }
> +#endif
> 
> +#ifdef CONFIG_CPU_S5P6450
>  void __init s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no)
>  {
>  	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
>  }
> +#endif
> 
>  #define eint_offset(irq)	((irq) - IRQ_EINT(0))
> 
> diff --git a/arch/arm/mach-s5p64x0/common.h b/arch/arm/mach-
> s5p64x0/common.h
> index f3a9b43..cbe7f3d 100644
> --- a/arch/arm/mach-s5p64x0/common.h
> +++ b/arch/arm/mach-s5p64x0/common.h
> @@ -25,10 +25,10 @@ void s5p6450_register_clocks(void);
>  void s5p6450_setup_clocks(void);
> 
>  void s5p64x0_restart(enum reboot_mode mode, const char *cmd);
> +extern  int s5p64x0_init(void);
> 
>  #ifdef CONFIG_CPU_S5P6440
> 
> -extern  int s5p64x0_init(void);
>  extern void s5p6440_map_io(void);
>  extern void s5p6440_init_clocks(int xtal);
> 
> @@ -38,12 +38,10 @@ extern void s5p6440_init_uarts(struct s3c2410_uartcfg
> *cfg, int no);
>  #define s5p6440_init_clocks NULL
>  #define s5p6440_init_uarts NULL
>  #define s5p6440_map_io NULL
> -#define s5p64x0_init NULL
>  #endif
> 
>  #ifdef CONFIG_CPU_S5P6450
> 
> -extern  int s5p64x0_init(void);
>  extern void s5p6450_map_io(void);
>  extern void s5p6450_init_clocks(int xtal);
> 
> @@ -53,7 +51,6 @@ extern void s5p6450_init_uarts(struct s3c2410_uartcfg
> *cfg, int no);
>  #define s5p6450_init_clocks NULL
>  #define s5p6450_init_uarts NULL
>  #define s5p6450_map_io NULL
> -#define s5p64x0_init NULL
>  #endif
> 
>  #endif /* __ARCH_ARM_MACH_S5P64X0_COMMON_H */
> --
> 1.8.3.2
