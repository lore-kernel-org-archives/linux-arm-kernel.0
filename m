From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 28 May 2014 12:50:36 +0200
Subject: [PATCH V4] mmc: mmci: Enforce DMA configuration through DT
In-Reply-To: <1400561154-17846-1-git-send-email-ulf.hansson@linaro.org>
References: <1400561154-17846-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFrRP-0EZzzyfxinYDp+aPca-t0Gmw3i2tdjM=dX-DXT4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2014 06:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Remove the option to provide DMA configuration as platform data,
> enforce it through DT.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Roland Stigge <stigge@antcom.de>

Hi Roland,

Just a kind reminder.

If you don't have any objections I intend to queue this patch through
the below git tree.

Kind regards
Ulf Hansson

> ---
>
> Note, this patch is based upon the next branch from the following git
> git://git.linaro.org/people/ulf.hansson/mmc.git
>
> Changes in v4:
>         Removed the NULL pointer assignment of ->dma_filter cb for mach-lpc32xx.
>
> ---
>  arch/arm/mach-lpc32xx/phy3250.c |    3 ---
>  drivers/mmc/host/mmci.c         |   24 +-----------------------
>  include/linux/amba/mmci.h       |   17 -----------------
>  3 files changed, 1 insertion(+), 43 deletions(-)
>
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index 34932e0..7858d5b 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -202,9 +202,6 @@ static struct mmci_platform_data lpc32xx_mmci_data = {
>         .ocr_mask       = MMC_VDD_30_31 | MMC_VDD_31_32 |
>                           MMC_VDD_32_33 | MMC_VDD_33_34,
>         .ios_handler    = mmc_handle_ios,
> -       .dma_filter     = NULL,
> -       /* No DMA for now since AMBA PL080 dmaengine driver only does scatter
> -        * gather, and the MMCI driver doesn't do it this way */
>  };
>
>  static struct lpc32xx_slc_platform_data lpc32xx_slc_data = {
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 758efea..a084edd 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -366,7 +366,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>  #ifdef CONFIG_DMA_ENGINE
>  static void mmci_dma_setup(struct mmci_host *host)
>  {
> -       struct mmci_platform_data *plat = host->plat;
>         const char *rxname, *txname;
>         dma_cap_mask_t mask;
>
> @@ -380,25 +379,6 @@ static void mmci_dma_setup(struct mmci_host *host)
>         dma_cap_zero(mask);
>         dma_cap_set(DMA_SLAVE, mask);
>
> -       if (plat && plat->dma_filter) {
> -               if (!host->dma_rx_channel && plat->dma_rx_param) {
> -                       host->dma_rx_channel = dma_request_channel(mask,
> -                                                          plat->dma_filter,
> -                                                          plat->dma_rx_param);
> -                       /* E.g if no DMA hardware is present */
> -                       if (!host->dma_rx_channel)
> -                               dev_err(mmc_dev(host->mmc), "no RX DMA channel\n");
> -               }
> -
> -               if (!host->dma_tx_channel && plat->dma_tx_param) {
> -                       host->dma_tx_channel = dma_request_channel(mask,
> -                                                          plat->dma_filter,
> -                                                          plat->dma_tx_param);
> -                       if (!host->dma_tx_channel)
> -                               dev_warn(mmc_dev(host->mmc), "no TX DMA channel\n");
> -               }
> -       }
> -
>         /*
>          * If only an RX channel is specified, the driver will
>          * attempt to use it bidirectionally, however if it is
> @@ -446,11 +426,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>   */
>  static inline void mmci_dma_release(struct mmci_host *host)
>  {
> -       struct mmci_platform_data *plat = host->plat;
> -
>         if (host->dma_rx_channel)
>                 dma_release_channel(host->dma_rx_channel);
> -       if (host->dma_tx_channel && plat->dma_tx_param)
> +       if (host->dma_tx_channel)
>                 dma_release_channel(host->dma_tx_channel);
>         host->dma_rx_channel = host->dma_tx_channel = NULL;
>  }
> diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
> index 3f95d32..8c98113 100644
> --- a/include/linux/amba/mmci.h
> +++ b/include/linux/amba/mmci.h
> @@ -6,9 +6,6 @@
>
>  #include <linux/mmc/host.h>
>
> -/* Just some dummy forwarding */
> -struct dma_chan;
> -
>  /**
>   * struct mmci_platform_data - platform configuration for the MMCI
>   * (also known as PL180) block.
> @@ -26,17 +23,6 @@ struct dma_chan;
>   * @gpio_wp: read this GPIO pin to see if the card is write protected
>   * @gpio_cd: read this GPIO pin to detect card insertion
>   * @cd_invert: true if the gpio_cd pin value is active low
> - * @dma_filter: function used to select an appropriate RX and TX
> - * DMA channel to be used for DMA, if and only if you're deploying the
> - * generic DMA engine
> - * @dma_rx_param: parameter passed to the DMA allocation
> - * filter in order to select an appropriate RX channel. If
> - * there is a bidirectional RX+TX channel, then just specify
> - * this and leave dma_tx_param set to NULL
> - * @dma_tx_param: parameter passed to the DMA allocation
> - * filter in order to select an appropriate TX channel. If this
> - * is NULL the driver will attempt to use the RX channel as a
> - * bidirectional channel
>   */
>  struct mmci_platform_data {
>         unsigned int ocr_mask;
> @@ -45,9 +31,6 @@ struct mmci_platform_data {
>         int     gpio_wp;
>         int     gpio_cd;
>         bool    cd_invert;
> -       bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
> -       void *dma_rx_param;
> -       void *dma_tx_param;
>  };
>
>  #endif
> --
> 1.7.9.5
>
