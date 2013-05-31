From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 31 May 2013 16:52:13 +0200 (CEST)
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1305311611460.7395@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

Thanks for the patches. How about this fix:

http://thread.gmane.org/gmane.linux.kernel.mmc/20619

I think it's a better fix. SHDMA users cannot use other DMA drivers, so, I 
don't think we need to pass the filter via the platform data.

Thanks
Guennadi

On Fri, 31 May 2013, Arnd Bergmann wrote:

> Since eec95ee2261 "mmc: sdhi/tmio: switch to using
> dmaengine_slave_config()", we are getting a link error with
> a number of shmobile configurations that turn on the sdhi
> driver but the not the SH_DMAE_BASE driver.
> 
> The reason is that the driver now incorrectly refers to
> a global filter function that should be referenced only
> by platform code:
> 
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> drivers/mmc/host/sh_mobile_sdhi.c:202: undefined reference to `shdma_chan_filter'
> drivers/mmc/host/sh_mobile_sdhi.c:202: undefined reference to `shdma_chan_filter'
> 
> The fix is to move the pointer to the filter function out
> of the driver, similar to how we do it for most other
> platforms. This makes the driver almost independent
> of the underlying dma engine, besides the fact that
> it tries to pass the same number both into the filter
> function and into slave config, which only works on
> some DMA engine drivers.
> 
> Since the bug is only present on the mmc tree, I think
> the fix should be applied there as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-ag5evm.c          |  4 ++++
>  arch/arm/mach-shmobile/board-ap4evb.c          |  7 +++++++
>  arch/arm/mach-shmobile/board-armadillo800eva.c |  7 +++++++
>  arch/arm/mach-shmobile/board-kzm9g.c           |  7 +++++++
>  arch/arm/mach-shmobile/board-mackerel.c        | 10 ++++++++++
>  drivers/mmc/host/sh_mobile_sdhi.c              |  9 ++++++++-
>  include/linux/mmc/sh_mobile_sdhi.h             |  1 +
>  7 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
> index c754071..ad01651 100644
> --- a/arch/arm/mach-shmobile/board-ag5evm.c
> +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> @@ -42,6 +42,7 @@
>  #include <linux/mmc/sh_mobile_sdhi.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/sh_clk.h>
> +#include <linux/sh_dma.h>
>  #include <linux/irqchip/arm-gic.h>
>  #include <video/sh_mobile_lcdc.h>
>  #include <video/sh_mipi_dsi.h>
> @@ -403,8 +404,11 @@ static struct regulator_consumer_supply fixed2v8_power_consumers[] =
>  
>  /* SDHI0 */
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
>  	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 297bf5e..c900e24 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -38,6 +38,7 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/smsc911x.h>
> +#include <linux/sh_dma.h>
>  #include <linux/sh_intc.h>
>  #include <linux/sh_clk.h>
>  #include <linux/gpio.h>
> @@ -355,8 +356,11 @@ static struct platform_device sh_mmcif_device = {
>  
>  /* SDHI0 */
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_caps	= MMC_CAP_SDIO_IRQ,
>  };
>  
> @@ -393,8 +397,11 @@ static struct platform_device sdhi0_device = {
>  
>  /* SDHI1 */
>  static struct sh_mobile_sdhi_info sdhi1_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_ocr_mask	= MMC_VDD_165_195,
>  	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
>  	.tmio_caps	= MMC_CAP_NEEDS_POLL | MMC_CAP_SDIO_IRQ,
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 44a6215..e95e5dc 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -34,6 +34,7 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/gpio-regulator.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/sh_dma.h>
>  #include <linux/sh_eth.h>
>  #include <linux/videodev2.h>
>  #include <linux/usb/renesas_usbhs.h>
> @@ -688,8 +689,11 @@ static struct platform_device vcc_sdhi1 = {
>   */
>  #define IRQ31	irq_pin(31)
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
> @@ -730,8 +734,11 @@ static struct platform_device sdhi0_device = {
>  
>  /* SDHI1 */
>  static struct sh_mobile_sdhi_info sdhi1_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 165483c..0434b36 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -37,6 +37,7 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/smsc911x.h>
> +#include <linux/sh_dma.h>
>  #include <linux/usb/r8a66597.h>
>  #include <linux/usb/renesas_usbhs.h>
>  #include <linux/videodev2.h>
> @@ -442,8 +443,11 @@ static struct platform_device vcc_sdhi2 = {
>  
>  /* SDHI */
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> @@ -484,8 +488,11 @@ static struct platform_device sdhi0_device = {
>  
>  /* Micro SD */
>  static struct sh_mobile_sdhi_info sdhi2_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
>  			  TMIO_MMC_USE_GPIO_CD |
>  			  TMIO_MMC_WRPROTECT_DISABLE,
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 85f51a8..49755ff 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -45,6 +45,7 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/smsc911x.h>
> +#include <linux/sh_dma.h>
>  #include <linux/sh_intc.h>
>  #include <linux/tca6416_keypad.h>
>  #include <linux/usb/renesas_usbhs.h>
> @@ -971,8 +972,11 @@ static struct platform_device nand_flash_device = {
>  
>  /* SDHI0 */
>  static struct sh_mobile_sdhi_info sdhi0_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  	.cd_gpio	= 172,
> @@ -1010,8 +1014,11 @@ static struct platform_device sdhi0_device = {
>  
>  /* GPIO 41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
>  static struct sh_mobile_sdhi_info sdhi1_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_NEEDS_POLL,
> @@ -1053,8 +1060,11 @@ static struct platform_device sdhi1_device = {
>   * connected to GPIO SCIFB_SCK of SH7372 (GPIO 162).
>   */
>  static struct sh_mobile_sdhi_info sdhi2_info = {
> +#ifdef CONFIG_SH_DMAE_BASE
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_NEEDS_POLL,
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index cc4c872..efe3386 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -193,13 +193,20 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  			 */
>  			dma_priv->chan_priv_tx = (void *)p->dma_slave_tx;
>  			dma_priv->chan_priv_rx = (void *)p->dma_slave_rx;
> +			/*
> +			 * This is a layering violation: the slave driver
> +			 * should not be aware that the chan_priv_* is the
> +			 * slave id.
> +			 * We should not really need to set the slave id
> +			 * here anyway. -arnd
> +			 */
>  			dma_priv->slave_id_tx = p->dma_slave_tx;
>  			dma_priv->slave_id_rx = p->dma_slave_rx;
> +			dma_priv->filter = p->dma_filter;
>  		}
>  	}
>  
>  	dma_priv->alignment_shift = 1; /* 2-byte alignment */
> -	dma_priv->filter = shdma_chan_filter;
>  
>  	mmc_data->dma = dma_priv;
>  
> diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> index b76bcf0..342f07b 100644
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -20,6 +20,7 @@ struct sh_mobile_sdhi_ops {
>  struct sh_mobile_sdhi_info {
>  	int dma_slave_tx;
>  	int dma_slave_rx;
> +	dma_filter_fn dma_filter;
>  	unsigned long tmio_flags;
>  	unsigned long tmio_caps;
>  	unsigned long tmio_caps2;
> -- 
> 1.8.1.2
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
