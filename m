From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 7 Jun 2013 12:25:11 +0200 (CEST)
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1306071222250.11277@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

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

Right, that's the problem, I think. Don't think we want these #ifdefs in 
all shdma users - under arch/arm and arch/sh. That's why I think we need 
my fix in the first place to fix the compile breakage. After that we can 
think about improving DMA slave driver decoupling from specific DMAC 
drivers - if at all needed.

>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.dma_filter	= shdma_chan_filter,
> +#endif
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
>  	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,

[snip]

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
