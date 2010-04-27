From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Tue, 27 Apr 2010 13:07:21 +0300
Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
In-Reply-To: <20100427075012.GB30801@buzzloop.caiaq.de>
References: <20100427075012.GB30801@buzzloop.caiaq.de>
Message-ID: <4BD6B759.1010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2010 10:50 AM, Daniel Mack wrote:
> The patch below is a result of more MMC/SDIO tests on MX31 hardware.
>
>  From 1b01327ff9c50980c31d7afa3fb6b314eb152fea Mon Sep 17 00:00:00 2001
> From: Volker Ernst<volker.ernst@txtr.com>
> Date: Mon, 26 Apr 2010 22:51:07 +0200
> Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
>
> This fixes a race condition regarding interrupt bits in the SDHC
> controller driver code.
>
> In case of PIO-transfer it does not clear SDHC-status bit#11/12
> in the INT-handler anymore. INT-handler might be called during
> an ongoing PIO-data-transfer (with some other INT-flag set) and
> PIO-transfer depends on these bits being set to detect the end
> of the data-transfer. This also means that at the end of PIO-
> transfer that PIO-software has to clear these bits itself.
>
> However in case of DMA-transfer these bits have to be cleared
> in the INT-handler, because they are used to generate INTs then.
>
> Works solid, no more problems here, can transfer big files.
>
> Signed-off-by: Volker Ernst<volker.ernst@txtr.com>
> Acked-by: Daniel Mack<daniel@caiaq.de>
> Cc: Andy Green<andy@warmcat.com>
> ---
>   drivers/mmc/host/mxcmmc.c |   10 +++++++++-
>   1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 2c53024..d625702 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -489,6 +489,8 @@ static void mxcmci_datawork(struct work_struct *work)
>   	struct mxcmci_host *host = container_of(work, struct mxcmci_host,
>   						  datawork);
>   	int datastat = mxcmci_transfer_data(host);
> +        writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE, host->base + MMC_REG_STATUS);

Use TAB for indentation.

> +
>   	mxcmci_finish_data(host, datastat);
>
>   	if (host->req->stop) {
> @@ -553,7 +555,8 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>   	u32 stat;
>
>   	stat = readl(host->base + MMC_REG_STATUS);
> -	writel(stat&  ~STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
> +	writel(stat&  ~(STATUS_SDIO_INT_ACTIVE | STATUS_DATA_TRANS_DONE |
> +			STATUS_WRITE_OP_DONE), host->base + MMC_REG_STATUS);
>
>   	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>
> @@ -561,6 +564,11 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>   	sdio_irq = (stat&  STATUS_SDIO_INT_ACTIVE)&&  host->use_sdio;
>   	spin_unlock_irqrestore(&host->lock, flags);
>
> +#ifdef HAS_DMA
> +	if (mxcmci_use_dma(host)&&  (stat&  (STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE)))
> +		writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE, host->base + MMC_REG_STATUS);
> +#endif
> +
>   	if (sdio_irq) {
>   		writel(STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
>   		mmc_signal_sdio_irq(host->mmc);
