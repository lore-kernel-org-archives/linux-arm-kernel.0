From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Oct 2012 20:26:10 +0900
Subject: [PATCH] ARM: Exynos5: Remove unused static uart resource
 information
In-Reply-To: <1351516455-344-1-git-send-email-thomas.abraham@linaro.org>
References: <1351516455-344-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <508E67D2.8040402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/12 22:14, Thomas Abraham wrote:
> All supported Exynos5 platforms are device tree enabled and hence the
> unused static uart resource information is removed.
>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/common.c            |    6 +-----
>   arch/arm/mach-exynos/dev-uart.c          |   24 ------------------------
>   arch/arm/mach-exynos/include/mach/irqs.h |    5 -----
>   arch/arm/mach-exynos/include/mach/map.h  |    1 -
>   4 files changed, 1 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 1947be8..5a305f0 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -96,7 +96,6 @@ static struct cpu_table cpu_ids[] __initdata = {
>   		.idmask		= EXYNOS5_SOC_MASK,
>   		.map_io		= exynos5_map_io,
>   		.init_clocks	= exynos5_init_clocks,
> -		.init_uarts	= exynos_init_uarts,
>   		.init		= exynos_init,
>   		.name		= name_exynos5250,
>   	},
> @@ -735,10 +734,7 @@ static void __init exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no)
>   	for (ucnt = 0; ucnt<  no; ucnt++, tcfg++)
>   		tcfg->has_fracval = 1;
>
> -	if (soc_is_exynos5250())
> -		s3c24xx_init_uartdevs("exynos4210-uart", exynos5_uart_resources, cfg, no);
> -	else
> -		s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
> +	s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
>   }
>
>   static void __iomem *exynos_eint_base;
> diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
> index 2e85c02..7c42f4b 100644
> --- a/arch/arm/mach-exynos/dev-uart.c
> +++ b/arch/arm/mach-exynos/dev-uart.c
> @@ -52,27 +52,3 @@ struct s3c24xx_uart_resources exynos4_uart_resources[] __initdata = {
>   		.nr_resources	= ARRAY_SIZE(exynos4_uart3_resource),
>   	},
>   };
> -
> -EXYNOS_UART_RESOURCE(5, 0)
> -EXYNOS_UART_RESOURCE(5, 1)
> -EXYNOS_UART_RESOURCE(5, 2)
> -EXYNOS_UART_RESOURCE(5, 3)
> -
> -struct s3c24xx_uart_resources exynos5_uart_resources[] __initdata = {
> -	[0] = {
> -		.resources	= exynos5_uart0_resource,
> -		.nr_resources	= ARRAY_SIZE(exynos5_uart0_resource),
> -	},
> -	[1] = {
> -		.resources	= exynos5_uart1_resource,
> -		.nr_resources	= ARRAY_SIZE(exynos5_uart0_resource),
> -	},
> -	[2] = {
> -		.resources	= exynos5_uart2_resource,
> -		.nr_resources	= ARRAY_SIZE(exynos5_uart2_resource),
> -	},
> -	[3] = {
> -		.resources	= exynos5_uart3_resource,
> -		.nr_resources	= ARRAY_SIZE(exynos5_uart3_resource),
> -	},
> -};
> diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
> index 35bced6..6da3115 100644
> --- a/arch/arm/mach-exynos/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> @@ -259,11 +259,6 @@
>   #define EXYNOS5_IRQ_IEM_IEC		IRQ_SPI(48)
>   #define EXYNOS5_IRQ_IEM_APC		IRQ_SPI(49)
>   #define EXYNOS5_IRQ_GPIO_C2C		IRQ_SPI(50)
> -#define EXYNOS5_IRQ_UART0		IRQ_SPI(51)
> -#define EXYNOS5_IRQ_UART1		IRQ_SPI(52)
> -#define EXYNOS5_IRQ_UART2		IRQ_SPI(53)
> -#define EXYNOS5_IRQ_UART3		IRQ_SPI(54)
> -#define EXYNOS5_IRQ_UART4		IRQ_SPI(55)
>   #define EXYNOS5_IRQ_IIC			IRQ_SPI(56)
>   #define EXYNOS5_IRQ_IIC1		IRQ_SPI(57)
>   #define EXYNOS5_IRQ_IIC2		IRQ_SPI(58)
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 8480849..e737331 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -279,7 +279,6 @@
>   #define EXYNOS5_PA_UART1		0x12C10000
>   #define EXYNOS5_PA_UART2		0x12C20000
>   #define EXYNOS5_PA_UART3		0x12C30000
> -#define EXYNOS5_SZ_UART			SZ_256
>
>   #define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
>

Yes, right. And I think, the function name, exynos_init_uarts() can be 
changed to exynos4_init_uarts() clearly with this...so I did when I 
applied this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
