From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 09:06:25 +0900
Subject: [PATCH 2/2] ARM: EXYNOS5: Add support SPI for EXYNOS5250
In-Reply-To: <001d01cce24b$2bf19920$83d4cb60$%kim@samsung.com>
References: <001d01cce24b$2bf19920$83d4cb60$%kim@samsung.com>
Message-ID: <4FAEFB01.6070603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/12 17:09, ??? wrote:
> This patch adds clocks, gpio configs and platform devices for EXYNOS5 SPI.
> And also the spi clock and gpio setup are added in the smdk5250_machine_init.
> 
> Signed-off-by: Kyoungil Kim<ki0351.kim@samsung.com>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c             |   89 +++++++++++++++
>   arch/arm/mach-exynos/include/mach/map.h          |   13 ++-
>   arch/arm/mach-exynos/include/mach/regs-clock.h   |    4 +
>   arch/arm/mach-exynos/mach-smdk5250.c             |  108 ++++++++++++++++++-
>   arch/arm/mach-exynos/setup-spi.c                 |  129 ++++++++++++++++++++--
>   arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    4 +
>   6 files changed, 330 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index b43161b..d6fa729 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -83,6 +83,11 @@ static int exynos5_clksrc_mask_peric0_ctrl(struct clk *clk, int enable)
>   	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC0, clk, enable);
>   }
> 
> +static int exynos5_clksrc_mask_peric1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC1, clk, enable);
> +}
> +
>   static int exynos5_clk_ip_acp_ctrl(struct clk *clk, int enable)
>   {
>   	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_ACP, clk, enable);
> @@ -641,6 +646,21 @@ static struct clk exynos5_init_clocks_off[] = {
>   		.parent		=&exynos5_clk_aclk_66.clk,
>   		.enable		= exynos5_clk_ip_peric_ctrl,
>   		.ctrlbit	= (1<<  14),
> +	}, {
> +		.name		= "spi",
> +		.devname	= "s3c64xx-spi.0",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  16),
> +	}, {
> +		.name		= "spi",
> +		.devname	= "s3c64xx-spi.1",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  17),
> +	}, {
> +		.name		= "spi",
> +		.devname	= "s3c64xx-spi.2",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  18),
>   	}
>   };
> 
> @@ -865,6 +885,66 @@ static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
>   	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 24, .size = 8 },
>   };
> 
> +static struct clksrc_clk exynos5_clk_dout_spi0 = {
> +	.clk		= {
> +		.name		= "dout_spi0",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 16, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_spi1 = {
> +	.clk		= {
> +		.name		= "dout_spi1",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 20, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 16, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_spi2 = {
> +	.clk		= {
> +		.name		= "dout_spi2",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 24, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_spi0 = {
> +	.clk	= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.0",
> +		.parent		=&exynos5_clk_dout_spi0.clk,
> +		.enable		= exynos5_clksrc_mask_peric1_ctrl,
> +		.ctrlbit	= (1<<  16),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 8, .size = 8 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_spi1 = {
> +	.clk	= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.1",
> +		.parent		=&exynos5_clk_dout_spi1.clk,
> +		.enable		= exynos5_clksrc_mask_peric1_ctrl,
> +		.ctrlbit	= (1<<  20),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 24, .size = 8 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_spi2 = {
> +	.clk	= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.2",
> +		.parent		=&exynos5_clk_dout_spi2.clk,
> +		.enable		= exynos5_clksrc_mask_peric1_ctrl,
> +		.ctrlbit	= (1<<  24),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 8, .size = 8 },
> +};
> +
>   static struct clksrc_clk exynos5_clksrcs[] = {
>   	{
>   		.clk	= {
> @@ -977,6 +1057,9 @@ static struct clksrc_clk *exynos5_sysclks[] = {
>   	&exynos5_clk_dout_mmc4,
>   	&exynos5_clk_aclk_acp,
>   	&exynos5_clk_pclk_acp,
> +	&exynos5_clk_dout_spi0,
> +	&exynos5_clk_dout_spi1,
> +	&exynos5_clk_dout_spi2,
>   };
> 
>   static struct clk *exynos5_clk_cdev[] = {
> @@ -994,6 +1077,9 @@ static struct clksrc_clk *exynos5_clksrc_cdev[] = {
>   	&exynos5_clk_sclk_mmc1,
>   	&exynos5_clk_sclk_mmc2,
>   	&exynos5_clk_sclk_mmc3,
> +	&exynos5_clk_sclk_spi0,
> +	&exynos5_clk_sclk_spi1,
> +	&exynos5_clk_sclk_spi2,
>   };
> 
>   static struct clk_lookup exynos5_clk_lookup[] = {
> @@ -1008,6 +1094,9 @@ static struct clk_lookup exynos5_clk_lookup[] = {
>   	CLKDEV_INIT("dma-pl330.0", "apb_pclk",&exynos5_clk_pdma0),
>   	CLKDEV_INIT("dma-pl330.1", "apb_pclk",&exynos5_clk_pdma1),
>   	CLKDEV_INIT("dma-pl330.2", "apb_pclk",&exynos5_clk_mdma),
> +	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0",&exynos5_clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0",&exynos5_clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0",&exynos5_clk_sclk_spi2.clk),
>   };
> 
>   static unsigned long exynos5_epll_get_rate(struct clk *clk)
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 7cdeae0..1c25dc9 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -108,6 +108,9 @@
>   #define EXYNOS4_PA_SPI0			0x13920000
>   #define EXYNOS4_PA_SPI1			0x13930000
>   #define EXYNOS4_PA_SPI2			0x13940000
> +#define EXYNOS5_PA_SPI0			0x12D20000
> +#define EXYNOS5_PA_SPI1			0x12D30000
> +#define EXYNOS5_PA_SPI2			0x12D40000
> 
>   #define EXYNOS4_PA_GPIO1		0x11400000
>   #define EXYNOS4_PA_GPIO2		0x11000000
> @@ -177,10 +180,6 @@
>   #define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
>   #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
> 
> -#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
> -#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
> -#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
> -
>   #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
>   #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
>   #define S5P_PA_FIMC1			EXYNOS4_PA_FIMC1
> @@ -210,6 +209,9 @@
>   #define EXYNOS_PA_PDMA0			EXYNOS4_PA_PDMA0
>   #define EXYNOS_PA_PDMA1			EXYNOS4_PA_PDMA1
>   #define EXYNOS_PA_MDMA1			EXYNOS4_PA_MDMA1
> +#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
> +#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
> +#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
>   #endif
> 
>   #ifdef CONFIG_ARCH_EXYNOS5
> @@ -219,6 +221,9 @@
>   #define EXYNOS_PA_PDMA0			EXYNOS5_PA_PDMA0
>   #define EXYNOS_PA_PDMA1			EXYNOS5_PA_PDMA1
>   #define EXYNOS_PA_MDMA1			EXYNOS5_PA_MDMA1
> +#define S3C_PA_SPI0			EXYNOS5_PA_SPI0
> +#define S3C_PA_SPI1			EXYNOS5_PA_SPI1
> +#define S3C_PA_SPI2			EXYNOS5_PA_SPI2
>   #endif
> 
>   /* Compatibility UART */
> diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
> index 113836b..b994633 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-clock.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
> @@ -226,12 +226,14 @@
>   #define EXYNOS5_CLKSRC_DISP1_0			EXYNOS_CLKREG(0x1022C)
>   #define EXYNOS5_CLKSRC_FSYS			EXYNOS_CLKREG(0x10244)
>   #define EXYNOS5_CLKSRC_PERIC0			EXYNOS_CLKREG(0x10250)
> +#define EXYNOS5_CLKSRC_PERIC1			EXYNOS_CLKREG(0x10254)
> 
>   #define EXYNOS5_CLKSRC_MASK_TOP			EXYNOS_CLKREG(0x10310)
>   #define EXYNOS5_CLKSRC_MASK_GSCL		EXYNOS_CLKREG(0x10320)
>   #define EXYNOS5_CLKSRC_MASK_DISP1_0		EXYNOS_CLKREG(0x1032C)
>   #define EXYNOS5_CLKSRC_MASK_FSYS		EXYNOS_CLKREG(0x10340)
>   #define EXYNOS5_CLKSRC_MASK_PERIC0		EXYNOS_CLKREG(0x10350)
> +#define EXYNOS5_CLKSRC_MASK_PERIC1		EXYNOS_CLKREG(0x10354)
> 
>   #define EXYNOS5_CLKDIV_TOP0			EXYNOS_CLKREG(0x10510)
>   #define EXYNOS5_CLKDIV_TOP1			EXYNOS_CLKREG(0x10514)
> @@ -243,6 +245,8 @@
>   #define EXYNOS5_CLKDIV_FSYS2			EXYNOS_CLKREG(0x10550)
>   #define EXYNOS5_CLKDIV_FSYS3			EXYNOS_CLKREG(0x10554)
>   #define EXYNOS5_CLKDIV_PERIC0			EXYNOS_CLKREG(0x10558)
> +#define EXYNOS5_CLKDIV_PERIC1			EXYNOS_CLKREG(0x1055C)
> +#define EXYNOS5_CLKDIV_PERIC2			EXYNOS_CLKREG(0x10560)
> 
>   #define EXYNOS5_CLKGATE_IP_ACP			EXYNOS_CLKREG(0x08800)
>   #define EXYNOS5_CLKGATE_IP_GSCL			EXYNOS_CLKREG(0x10920)
> diff --git a/arch/arm/mach-exynos/mach-smdk5250.c b/arch/arm/mach-exynos/mach-smdk5250.c
> index 0fe4a0b..0c55bfa 100644
> --- a/arch/arm/mach-exynos/mach-smdk5250.c
> +++ b/arch/arm/mach-exynos/mach-smdk5250.c
> @@ -11,6 +11,9 @@
> 
>   #include<linux/platform_device.h>
>   #include<linux/serial_core.h>
> +#include<linux/clk.h>
> +#include<linux/gpio.h>
> +#include<linux/spi/spi.h>
> 
>   #include<asm/mach/arch.h>
>   #include<asm/hardware/gic.h>
> @@ -18,9 +21,13 @@
> 
>   #include<plat/clock.h>
>   #include<plat/cpu.h>
> +#include<plat/devs.h>
> +#include<plat/gpio-cfg.h>
>   #include<plat/regs-serial.h>
> +#include<plat/s3c64xx-spi.h>
> 
>   #include<mach/map.h>
> +#include<mach/spi-clocks.h>
> 
>   #include "common.h"
> 
> @@ -69,6 +76,72 @@ static struct s3c2410_uartcfg smdk5250_uartcfgs[] __initdata = {
>   	},
>   };
> 
> +static struct s3c64xx_spi_csinfo spi0_csi[] = {
> +	[0] = {
> +		.line		= EXYNOS5_GPA2(1),
> +		.set_level	= gpio_set_value,
> +		.fb_delay	= 0x2,
> +	},
> +};
> +
> +static struct spi_board_info spi0_board_info[] __initdata = {
> +	{
> +		.modalias		= "spidev",
> +		.platform_data		= NULL,
> +		.max_speed_hz		= 10*1000*1000,
> +		.bus_num		= 0,
> +		.chip_select		= 0,
> +		.mode			= SPI_MODE_0,
> +		.controller_data	=&spi0_csi[0],
> +	}
> +};
> +
> +static struct s3c64xx_spi_csinfo spi1_csi[] = {
> +	[0] = {
> +		.line		= EXYNOS5_GPA2(5),
> +		.set_level	= gpio_set_value,
> +		.fb_delay	= 0x2,
> +	},
> +};
> +
> +static struct spi_board_info spi1_board_info[] __initdata = {
> +	{
> +		.modalias		= "spidev",
> +		.platform_data		= NULL,
> +		.max_speed_hz		= 10*1000*1000,
> +		.bus_num		= 1,
> +		.chip_select		= 0,
> +		.mode			= SPI_MODE_0,
> +		.controller_data	=&spi1_csi[0],
> +	}
> +};
> +
> +static struct s3c64xx_spi_csinfo spi2_csi[] = {
> +	[0] = {
> +		.line		= EXYNOS5_GPB1(2),
> +		.set_level	= gpio_set_value,
> +		.fb_delay	= 0x2,
> +	},
> +};
> +
> +static struct spi_board_info spi2_board_info[] __initdata = {
> +	{
> +		.modalias		= "spidev",
> +		.platform_data		= NULL,
> +		.max_speed_hz		= 10*1000*1000,
> +		.bus_num		= 2,
> +		.chip_select		= 0,
> +		.mode			= SPI_MODE_0,
> +		.controller_data	=&spi2_csi[0],
> +	}
> +};
> +
> +static struct platform_device *smdk5250_devices[] __initdata = {
> +	&s3c64xx_device_spi0,
> +	&s3c64xx_device_spi1,
> +	&s3c64xx_device_spi2,
> +};
> +
>   static void __init smdk5250_map_io(void)
>   {
>   	clk_xusbxti.rate = 24000000;
> @@ -80,7 +153,40 @@ static void __init smdk5250_map_io(void)
> 
>   static void __init smdk5250_machine_init(void)
>   {
> -	/* nothing here yet */
> +	platform_add_devices(smdk5250_devices, ARRAY_SIZE(smdk5250_devices));
> +
> +	exynos_spi_clock_setup(&s3c64xx_device_spi0.dev, 0);
> +	exynos_spi_clock_setup(&s3c64xx_device_spi1.dev, 1);
> +	exynos_spi_clock_setup(&s3c64xx_device_spi2.dev, 2);
> +
> +	if (!exynos_spi_cfg_cs(spi0_csi[0].line, 0)) {
> +		s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata,
> +				EXYNOS_SPI_SRCCLK_SCLK, ARRAY_SIZE(spi0_csi));
> +
> +		spi_register_board_info(spi0_board_info,
> +				ARRAY_SIZE(spi0_board_info));
> +	} else
> +		printk(KERN_ERR "Error requesting gpio for SPI-CH0 CS\n");
> +
> +
> +	if (!exynos_spi_cfg_cs(spi1_csi[0].line, 1)) {
> +		s3c64xx_spi1_set_platdata(&s3c64xx_spi1_pdata,
> +				EXYNOS_SPI_SRCCLK_SCLK, ARRAY_SIZE(spi1_csi));
> +
> +		spi_register_board_info(spi1_board_info,
> +				ARRAY_SIZE(spi1_board_info));
> +	} else
> +		printk(KERN_ERR "Error requesting gpio for SPI-CH1 CS\n");
> +
> +
> +	if (!exynos_spi_cfg_cs(spi2_csi[0].line, 2)) {
> +		s3c64xx_spi2_set_platdata(&s3c64xx_spi2_pdata,
> +				EXYNOS_SPI_SRCCLK_SCLK, ARRAY_SIZE(spi2_csi));
> +
> +		spi_register_board_info(spi2_board_info,
> +				ARRAY_SIZE(spi2_board_info));
> +	} else
> +		printk(KERN_ERR "Error requesting gpio for SPI-CH2 CS\n");
>   }
> 
>   MACHINE_START(SMDK5250, "SMDK5250")
> diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
> index 833ff40..60c8037 100644
> --- a/arch/arm/mach-exynos/setup-spi.c
> +++ b/arch/arm/mach-exynos/setup-spi.c
> @@ -8,12 +8,71 @@
>    * published by the Free Software Foundation.
>    */
> 
> +#include<linux/clk.h>
> +#include<linux/err.h>
>   #include<linux/gpio.h>
>   #include<linux/platform_device.h>
> 
> +#include<plat/clock.h>
> +#include<plat/cpu.h>
>   #include<plat/gpio-cfg.h>
>   #include<plat/s3c64xx-spi.h>
> 
> +int exynos_spi_cfg_cs(int gpio, int ch_num)
> +{
> +	char cs_name[16];
> +
> +	sprintf(cs_name, "dout_spi%d", ch_num);
> +
> +	if (!gpio_request(gpio, cs_name)) {
> +		gpio_direction_output(gpio, 1);
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(1));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> +		gpio_free(gpio);
> +
> +		return 0;
> +	}
> +
> +	return -EIO;
> +}
> +
> +void exynos_spi_clock_setup(struct device *spi_dev, int ch_num)
> +{
> +	struct clk *child_clk = NULL;
> +	struct clk *parent_clk = NULL;
> +	char clk_name[16];
> +
> +	sprintf(clk_name, "dout_spi%d", ch_num);
> +	child_clk = clk_get(spi_dev, clk_name);
> +
> +	if (IS_ERR(child_clk)) {
> +		printk(KERN_ERR "Failed to get %s clk\n", clk_name);
> +		return;
> +	}
> +
> +	parent_clk = clk_get(spi_dev, "mout_mpll_user");
> +
> +	if (IS_ERR(parent_clk)) {
> +		printk(KERN_ERR "Failed to get mout_mpll_user clk\n");
> +		goto err1;
> +	}
> +
> +	if (clk_set_parent(child_clk, parent_clk)) {
> +		printk(KERN_ERR "Unable to set parent %s of clock %s\n",
> +				parent_clk->name, child_clk->name);
> +		goto err2;
> +	}
> +
> +	if (clk_set_rate(child_clk, 800 * 1000 * 1000))
> +		printk(KERN_ERR "Unable to set rate of clock %s\n",
> +				child_clk->name);
> +
> +err2:
> +	clk_put(parent_clk);
> +err1:
> +	clk_put(child_clk);
> +}
> +
>   #ifdef CONFIG_S3C64XX_DEV_SPI0
>   struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
>   	.fifo_lvl_mask	= 0x1ff,
> @@ -25,10 +84,26 @@ struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
> 
>   int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
>   {
> -	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
> -	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
> -	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
> -			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +	int gpio;
> +
> +	if (soc_is_exynos5250()) {
> +		s3c_gpio_cfgpin(EXYNOS5_GPA2(0), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS5_GPA2(0), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS5_GPA2(2), 2,
> +				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS5_GPA2(0); gpio<  EXYNOS5_GPA2(4); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	} else {
> +		s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
> +				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS4_GPB(0); gpio<  EXYNOS4_GPB(4); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	}
> +
>   	return 0;
>   }
>   #endif
> @@ -44,10 +119,25 @@ struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
> 
>   int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
>   {
> -	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
> -	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
> -	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
> -			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +	int gpio;
> +
> +	if (soc_is_exynos5250()) {
> +		s3c_gpio_cfgpin(EXYNOS5_GPA2(4), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS5_GPA2(4), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS5_GPA2(6), 2,
> +				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS5_GPA2(4); gpio<  EXYNOS5_GPA2(8); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	} else {
> +		s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
> +				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS4_GPB(4); gpio<  EXYNOS4_GPB(8); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	}
>   	return 0;
>   }
>   #endif
> @@ -63,10 +153,25 @@ struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
> 
>   int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
>   {
> -	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
> -	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
> -	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
> -			      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
> +	int gpio;
> +
> +	if (soc_is_exynos5250()) {
> +		s3c_gpio_cfgpin(EXYNOS5_GPB1(1), S3C_GPIO_SFN(5));
> +		s3c_gpio_setpull(EXYNOS5_GPB1(1), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS5_GPB1(3), 2,
> +				      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS5_GPB1(1); gpio<  EXYNOS5_GPB1(5); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	} else {
> +		s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
> +		s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
> +				      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
> +
> +		for (gpio = EXYNOS4_GPC1(1); gpio<  EXYNOS4_GPC1(5); gpio++)
> +			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV3);
> +	}
>   	return 0;
>   }
>   #endif
> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> index fa95e9a..ff4c301 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> @@ -74,6 +74,10 @@ extern void s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
>   extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
>   				      int src_clk_nr, int num_cs);
> 
> +/* defined to setup chip select GPIO and clock of SPI */
> +extern int exynos_spi_cfg_cs(int gpio, int ch_num);
> +extern void exynos_spi_clock_setup(struct device *spi_dev, int ch_num);
> +
>   /* defined by architecture to configure gpio */
>   extern int s3c64xx_spi0_cfg_gpio(struct platform_device *dev);
>   extern int s3c64xx_spi1_cfg_gpio(struct platform_device *dev);

Hi,

There is no board file, mach-smdk5250.c for EXYNOS5 so this should be
updated.
Please re-submit this for exynos5250 SPI with dt.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
