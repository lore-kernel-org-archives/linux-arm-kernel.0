From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 Nov 2010 12:36:39 +0100
Subject: [PATCH v2 1/2] ARM: mx5: introduce SOC_IMX51
In-Reply-To: <1290724946-23516-1-git-send-email-user@fabio-desktop>
References: <1290724946-23516-1-git-send-email-user@fabio-desktop>
Message-ID: <20101126113639.GD27637@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 08:42:25PM -0200, Fabio Estevam wrote:
> Introduce SOC_IMX51 to keep consistency with the other i.MX devices.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> applies on Sascha's for-next tree
> 
>  arch/arm/mach-mx5/Kconfig                          |   10 +++++++++-
>  arch/arm/plat-mxc/devices/Kconfig                  |    4 ++--
>  arch/arm/plat-mxc/devices/platform-fec.c           |    2 +-
>  arch/arm/plat-mxc/devices/platform-imx-dma.c       |    6 +++---
>  arch/arm/plat-mxc/devices/platform-imx-i2c.c       |    4 ++--
>  arch/arm/plat-mxc/devices/platform-imx-ssi.c       |    4 ++--
>  arch/arm/plat-mxc/devices/platform-imx-uart.c      |    4 ++--
>  arch/arm/plat-mxc/devices/platform-mxc_nand.c      |    2 +-
>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    4 ++--
>  arch/arm/plat-mxc/devices/platform-spi_imx.c       |    4 ++--
>  arch/arm/plat-mxc/ehci.c                           |    2 +-
>  11 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 88f0c66..be5d9bd 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -2,16 +2,20 @@ if ARCH_MX5
>  
Maybe add a comment here similar to the one I added to ARCH_MX31?

Other than that looks OK.

Uwe

>  config ARCH_MX51
>  	bool
> -	default y
> +
> +config	SOC_IMX51
> +	bool
>  	select MXC_TZIC
>  	select ARCH_MXC_IOMUX_V3
>  	select ARCH_MXC_AUDMUX_V2
>  	select ARCH_HAS_CPUFREQ
> +	select ARCH_MX51
>  
>  comment "MX5 platforms:"
>  
>  config MACH_MX51_BABBAGE
>  	bool "Support MX51 BABBAGE platforms"
> +	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> @@ -23,6 +27,7 @@ config MACH_MX51_BABBAGE
>  
>  config MACH_MX51_3DS
>  	bool "Support MX51PDK (3DS)"
> +	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_ESDHC
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> @@ -33,6 +38,7 @@ config MACH_MX51_3DS
>  
>  config MACH_EUKREA_CPUIMX51
>  	bool "Support Eukrea CPUIMX51 module"
> +	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MXC_NAND
> @@ -58,6 +64,7 @@ endchoice
>  
>  config MACH_EUKREA_CPUIMX51SD
>  	bool "Support Eukrea CPUIMX51SD module"
> +	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_SPI_IMX
>  	select IMX_HAVE_PLATFORM_IMX_UART
> @@ -83,6 +90,7 @@ endchoice
>  
>  config MACH_MX51_EFIKAMX
>  	bool "Support MX51 Genesi Efika MX nettop"
> +	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_ESDHC
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index b391f4d..2537166 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -1,6 +1,6 @@
>  config IMX_HAVE_PLATFORM_FEC
>  	bool
> -	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || ARCH_MX51
> +	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51
>  
>  config IMX_HAVE_PLATFORM_FLEXCAN
>  	select HAVE_CAN_FLEXCAN if CAN
> @@ -11,7 +11,7 @@ config IMX_HAVE_PLATFORM_FSL_USB2_UDC
>  
>  config IMX_HAVE_PLATFORM_GPIO_KEYS
>  	bool
> -	default y if ARCH_MX51
> +	default y if SOC_IMX51
>  
>  config IMX_HAVE_PLATFORM_IMX21_HCD
>  	bool
> diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
> index 8d78aed..269ec78 100644
> --- a/arch/arm/plat-mxc/devices/platform-fec.c
> +++ b/arch/arm/plat-mxc/devices/platform-fec.c
> @@ -31,7 +31,7 @@ const struct imx_fec_data imx35_fec_data __initconst =
>  	imx_fec_data_entry_single(MX35);
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_fec_data imx51_fec_data __initconst =
>  	imx_fec_data_entry_single(MX51);
>  #endif
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> index 89ec637..33530d2 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> @@ -46,10 +46,10 @@ struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
>  	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 0);
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
>  	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 0);
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
>  		const struct imx_imx_sdma_data *data)
> @@ -138,7 +138,7 @@ static struct sdma_script_start_addrs addr_imx35_to2 = {
>  };
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  static struct sdma_script_start_addrs addr_imx51_to1 = {
>  	.ap_2_ap_addr = 642,
>  	.uart_2_mcu_addr = 817,
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> index 075bd8e..72ba880 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
> @@ -69,14 +69,14 @@ const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
>  #define imx51_imx_i2c_data_entry(_id, _hwid)				\
>  	imx_imx_i2c_data_entry(MX51, _id, _hwid, SZ_4K)
>  	imx51_imx_i2c_data_entry(0, 1),
>  	imx51_imx_i2c_data_entry(1, 2),
>  };
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  struct platform_device *__init imx_add_imx_i2c(
>  		const struct imx_imx_i2c_data *data,
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
> index 02002fc..ac3d572 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
> @@ -66,14 +66,14 @@ const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
>  #define imx51_imx_ssi_data_entry(_id, _hwid)				\
>  	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_4K)
>  	imx51_imx_ssi_data_entry(0, 1),
>  	imx51_imx_ssi_data_entry(1, 2),
>  };
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  struct platform_device *__init imx_add_imx_ssi(
>  		const struct imx_imx_ssi_data *data,
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> index 08bbd65..7b45b78 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> @@ -94,7 +94,7 @@ const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
>  #define imx51_imx_uart_data_entry(_id, _hwid)				\
>  	imx_imx_uart_1irq_data_entry(MX51, _id, _hwid, SZ_4K)
> @@ -102,7 +102,7 @@ const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
>  	imx51_imx_uart_data_entry(1, 2),
>  	imx51_imx_uart_data_entry(2, 3),
>  };
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  struct platform_device *__init imx_add_imx_uart_3irq(
>  		const struct imx_imx_uart_3irq_data *data,
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
> index f5beac0..1568f39 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
> @@ -51,7 +51,7 @@ const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
>  	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst =
>  	imx_mxc_nandv3_data_entry_single(MX51, SZ_16K);
>  #endif
> diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> index 167cce8..b352564 100644
> --- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
> @@ -41,7 +41,7 @@ imx35_sdhci_esdhc_imx_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_sdhci_esdhc_imx_data
>  imx51_sdhci_esdhc_imx_data[] __initconst = {
>  #define imx51_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
> @@ -51,7 +51,7 @@ imx51_sdhci_esdhc_imx_data[] __initconst = {
>  	imx51_sdhci_esdhc_imx_data_entry(2, 3),
>  	imx51_sdhci_esdhc_imx_data_entry(3, 4),
>  };
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  struct platform_device *__init imx_add_sdhci_esdhc_imx(
>  		const struct imx_sdhci_esdhc_imx_data *data,
> diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> index 6893c8b..8ea49ad 100644
> --- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> @@ -69,7 +69,7 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX35 */
>  
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  const struct imx_spi_imx_data imx51_cspi_data __initconst =
>  	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 0, , SZ_4K);
>  
> @@ -79,7 +79,7 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
>  	imx51_ecspi_data_entry(0, 1),
>  	imx51_ecspi_data_entry(1, 2),
>  };
> -#endif /* ifdef CONFIG_ARCH_MX51 */
> +#endif /* ifdef CONFIG_SOC_IMX51 */
>  
>  struct platform_device *__init imx_add_spi_imx(
>  		const struct imx_spi_imx_data *data,
> diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> index 4bac3d5..1c7ecd9 100644
> --- a/arch/arm/plat-mxc/ehci.c
> +++ b/arch/arm/plat-mxc/ehci.c
> @@ -246,7 +246,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
>  		return 0;
>  	}
>  #endif /* CONFIG_MACH_MX27 */
> -#ifdef CONFIG_ARCH_MX51
> +#ifdef CONFIG_SOC_IMX51
>  	if (cpu_is_mx51()) {
>  		void __iomem *usb_base;
>  		void __iomem *usbotg_base;
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
