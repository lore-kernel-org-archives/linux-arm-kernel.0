From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 May 2012 16:18:48 +0900
Subject: [PATCH v2 2/6] spi: s3c64xx: move controller information into
 driver data
In-Reply-To: <1337333613-6216-3-git-send-email-thomas.abraham@linaro.org>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <005a01cd397d$77f39600$67dac200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> Platform data is used to specify controller hardware specific information
> such as the tx/rx fifo level mask and bit offset of rx fifo level. Such
> information is not suitable to be supplied from device tree. Instead,
> it can be moved into the driver data and removed from platform data.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
> ---
>  arch/arm/mach-exynos/clock-exynos4.c             |   18 +-
>  arch/arm/mach-exynos/setup-spi.c                 |   25 ---
>  arch/arm/mach-s3c24xx/clock-s3c2416.c            |    2 +-
>  arch/arm/mach-s3c24xx/clock-s3c2443.c            |    2 +-
>  arch/arm/mach-s3c24xx/common-s3c2443.c           |    4 +-
>  arch/arm/mach-s3c24xx/setup-spi.c                |    8 -
>  arch/arm/mach-s3c64xx/clock.c                    |   20 ++--
>  arch/arm/mach-s3c64xx/setup-spi.c                |   13 --
>  arch/arm/mach-s5p64x0/clock-s5p6440.c            |   12 +-
>  arch/arm/mach-s5p64x0/clock-s5p6450.c            |   12 +-
>  arch/arm/mach-s5p64x0/setup-spi.c                |   16 --
>  arch/arm/mach-s5pc100/clock.c                    |   30 ++--
>  arch/arm/mach-s5pc100/setup-spi.c                |   22 ---
>  arch/arm/mach-s5pv210/clock.c                    |   14 +-
>  arch/arm/mach-s5pv210/setup-spi.c                |   15 --
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   15 --
>  drivers/spi/spi-s3c64xx.c                        |  180
++++++++++++++++++----
>  17 files changed, 210 insertions(+), 198 deletions(-)
> 
Basically, looks ok to me and there are small comments.

> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-
> exynos/clock-exynos4.c
> index bcb7db4..10a46a9 100644
> --- a/arch/arm/mach-exynos/clock-exynos4.c
> +++ b/arch/arm/mach-exynos/clock-exynos4.c
> @@ -586,17 +586,17 @@ static struct clk exynos4_init_clocks_off[] = {
>  		.ctrlbit	= (1 << 13),
>  	}, {
>  		.name		= "spi",
> -		.devname	= "s3c64xx-spi.0",
> +		.devname	= "exynos4210-spi.0",

Please consider that this can be used only for exynos4210 or all of exynos4
Socs. We need to keep the consistency for the naming.

[...]

> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-
> s3c24xx/clock-s3c2416.c
> index 8702ecf..a582ba1 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
> @@ -144,7 +144,7 @@ static struct clk_lookup s3c2416_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
>  	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
>  	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &hsspi_mux.clk),
> +	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &hsspi_mux.clk),

I think, in this case, some comment helps to know that 's3c2443-spi' can
support s3c2416/s3c2450 together.

[...]

> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
> s5p64x0/clock-s5p6440.c
> index ee1e8e7..55ea3ab 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c

[...]

> @@ -519,8 +519,8 @@ static struct clk_lookup s5p6440_clk_lookup[] = {
>  	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
>  	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
>  	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
> -	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
> -	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
> +	CLKDEV_INIT("s5p64x0.0", "spi_busclk1", &clk_sclk_spi0.clk),
> +	CLKDEV_INIT("s5p64x0.1", "spi_busclk1", &clk_sclk_spi1.clk),

Should be s5p64x0-spi.0 and s5p64x0-spi.1 ?

[...]

> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> index fa95e9a..4e9b9c3 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h

[...]

> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6a3d51a..f6bc0e3 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -31,6 +31,8 @@
>  #include <mach/dma.h>
>  #include <plat/s3c64xx-spi.h>
> 
> +#define MAX_SPI_PORTS		3

As you know, if spi_isp is used, this can be 5 for latest SoCs later. Just
note.

[...]

>  /**
> + * struct s3c64xx_spi_info - SPI Controller hardware info
> + * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS
> register.
> + * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
> + * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> + * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
> + * @clk_from_cmu: True, if the controller does not include a clock mux
> and
> + *	prescaler unit.
> + *
> + * The Samsung s3c64xx SPI controller are used on various Samsung SoC's
> but
> + * differ in some aspects such as the size of the fifo and spi bus clock
> + * setup. Such differences are specified to the driver using this
> structure
> + * which is provided as driver data to the driver.
> + */
> +struct s3c64xx_spi_port_config {
> +	int	fifo_lvl_mask[MAX_SPI_PORTS];
> +	int	rx_lvl_offset;
> +	int	tx_st_done;
> +	bool	high_speed;
> +	bool	clk_from_cmu;
> +};

When I saw this, I thought this will be used for each SPI port. But I know,
above structure is used for each SoC not each SPI port. So I think, how
about to change the structure name to avoid confusion?

[...]

> @@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  	platform_set_drvdata(pdev, master);
> 
>  	sdd = spi_master_get_devdata(master);
> +	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
>  	sdd->master = master;
>  	sdd->cntrlr_info = sci;
>  	sdd->pdev = pdev;
> @@ -1008,10 +1038,11 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
>  	sdd->rx_dma.dmach = dmarx_res->start;
>  	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
> +	sdd->port_id = pdev->id;
> 
>  	sdd->cur_bpw = 8;
> 
> -	master->bus_num = pdev->id;
> +	master->bus_num = sdd->port_id;

[...]

> @@ -1071,7 +1102,7 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
>  	}
> 
>  	/* Setup Deufult Mode */
> -	s3c64xx_spi_hwinit(sdd, pdev->id);
> +	s3c64xx_spi_hwinit(sdd, sdd->port_id);

Do we need this change?

> 
>  	spin_lock_init(&sdd->lock);
>  	init_completion(&sdd->xfer_completion);
> @@ -1096,7 +1127,7 @@ static int __init s3c64xx_spi_probe(struct
> platform_device *pdev)
> 
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
>  					"with %d Slaves attached\n",
> -					pdev->id, master->num_chipselect);
> +					sdd->port_id,
master->num_chipselect);

Same as above.

>  	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
>  					mem_res->end, mem_res->start,
>  					sdd->rx_dma.dmach,
sdd->tx_dma.dmach);
> @@ -1189,7 +1220,7 @@ static int s3c64xx_spi_resume(struct device *dev)
>  	clk_enable(sdd->src_clk);
>  	clk_enable(sdd->clk);
> 
> -	s3c64xx_spi_hwinit(sdd, pdev->id);
> +	s3c64xx_spi_hwinit(sdd, sdd->port_id);

Same as above.

[...]

> +#ifdef CONFIG_ARCH_EXYNOS4
> +struct s3c64xx_spi_port_config exynos4_spi_port_config = {

Is this available on exynos4212/exynos4412? If not, this should be
'exynos4210_spi_port_config' and ifdef CONFIG_CPU_EXYNOS4210.

> +	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
> +	.rx_lvl_offset	= 15,
> +	.tx_st_done	= 25,
> +	.high_speed	= 1,
> +	.clk_from_cmu	= true,
> +};
> +#define EXYNOS4_SPI_PORT_CONFIG
((kernel_ulong_t)&exynos4_spi_port_config)
> +#else
> +#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
> +#endif /* CONFIG_ARCH_EXYNOS4 */

And let's think the name of ..._SPI_PORT_CONFIG again. How about just
..._SPI_CONFIG?

> +
> +static struct platform_device_id s3c64xx_spi_driver_ids[] = {
> +	{
> +		.name		= "s3c2443-spi",
> +		.driver_data	= S3C2443_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s3c6410-spi",
> +		.driver_data	= S3C6410_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5p64x0-spi",
> +		.driver_data	= S5P64X0_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5pc100-spi",
> +		.driver_data	= S5PC100_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "s5pv210-spi",
> +		.driver_data	= S5PV210_SPI_PORT_CONFIG,
> +	}, {
> +		.name		= "exynos4210-spi",
> +		.driver_data	= EXYNOS4_SPI_PORT_CONFIG,

As I commented, if this is only for exynos4210, EXYNOS4210_SPI_CONFIG should
be used here not EXYNOS4_SPI_.

[...]

And I think, it's time to change the name of spi driver to spi-samsung.c and
samsung_spi as a prefix even though we have another s3c24xx spi driver now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
