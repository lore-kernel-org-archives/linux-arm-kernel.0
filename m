From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 27 Apr 2010 14:14:03 +0400
Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
In-Reply-To: <20100427075012.GB30801@buzzloop.caiaq.de>
References: <20100427075012.GB30801@buzzloop.caiaq.de>
Message-ID: <4BD6B8EB.8090408@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Daniel Mack wrote:
> The patch below is a result of more MMC/SDIO tests on MX31 hardware.
>
> From 1b01327ff9c50980c31d7afa3fb6b314eb152fea Mon Sep 17 00:00:00 2001
> From: Volker Ernst <volker.ernst@txtr.com>
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
> Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> Acked-by: Daniel Mack <daniel@caiaq.de>
> Cc: Andy Green <andy@warmcat.com>
> ---
>  drivers/mmc/host/mxcmmc.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 2c53024..d625702 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -489,6 +489,8 @@ static void mxcmci_datawork(struct work_struct *work)
>  	struct mxcmci_host *host = container_of(work, struct mxcmci_host,
>  						  datawork);
>  	int datastat = mxcmci_transfer_data(host);
> +        writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE, host->base + MMC_REG_STATUS);

   Spaces instead of tab here...

WBR, Sergei
