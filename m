From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 31 Mar 2010 19:34:14 +0200
Subject: [PATCH] ARM: MXC: mxcmmc: Teach the driver SDIO operations
In-Reply-To: <1270055079-30998-1-git-send-email-daniel@caiaq.de>
References: <m2ke2d7436a1003310941t18aeab59qb41f96bc58618960@mail.gmail.com>
	<1270055079-30998-1-git-send-email-daniel@caiaq.de>
Message-ID: <w2me2d7436a1003311034td3af4a49pdb1ac003a7d31c7d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/31 Daniel Mack <daniel@caiaq.de>:
> Successfully tested on MX31 hardware using libertas SDIO peripherals.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Volker Ernst <volker.ernst@txtr.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
> ?drivers/mmc/host/mxcmmc.c | ? 62 +++++++++++++++++++++++++++++++++++++-------
> ?1 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 44a53ee..f91a2c3 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -119,6 +119,7 @@ struct mxcmci_host {
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? detect_irq;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? dma;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? do_dma;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? use_sdio;
> ? ? ? ?unsigned int ? ? ? ? ? ?power_mode;
> ? ? ? ?struct imxmmc_platform_data *pdata;
>

This field should be protected by the same spinlock as it is used to
set the reg's value.

> @@ -138,6 +139,7 @@ struct mxcmci_host {
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? clock;
>
> ? ? ? ?struct work_struct ? ? ?datawork;
> + ? ? ? spinlock_t ? ? ? ? ? ? ?lock;
> ?};
>
> ?static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
> @@ -226,6 +228,9 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
> ?static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
> ? ? ? ? ? ? ? ?unsigned int cmdat)
> ?{
> + ? ? ? u32 int_cntr;
> + ? ? ? unsigned long flags;
> +
> ? ? ? ?WARN_ON(host->cmd != NULL);
> ? ? ? ?host->cmd = cmd;
>
> @@ -249,12 +254,17 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?}
>
> + ? ? ? int_cntr = INT_END_CMD_RES_EN;
> +
> ? ? ? ?if (mxcmci_use_dma(host))
> - ? ? ? ? ? ? ? writel(INT_READ_OP_EN | INT_WRITE_OP_DONE_EN |
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? INT_END_CMD_RES_EN,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? host->base + MMC_REG_INT_CNTR);
> - ? ? ? else
> - ? ? ? ? ? ? ? writel(INT_END_CMD_RES_EN, host->base + MMC_REG_INT_CNTR);
> + ? ? ? ? ? ? ? int_cntr |= INT_READ_OP_EN | INT_WRITE_OP_DONE_EN;
> +
> + ? ? ? if (host->use_sdio)
> + ? ? ? ? ? ? ? int_cntr |= INT_SDIO_IRQ_EN;
> +
> + ? ? ? spin_lock_irqsave(&host->lock, flags);
> + ? ? ? writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> + ? ? ? spin_unlock_irqrestore(&host->lock, flags);

Here.

>
> ? ? ? ?writew(cmd->opcode, host->base + MMC_REG_CMD);
> ? ? ? ?writel(cmd->arg, host->base + MMC_REG_ARG);
> @@ -266,7 +276,15 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
> ?static void mxcmci_finish_request(struct mxcmci_host *host,
> ? ? ? ? ? ? ? ?struct mmc_request *req)
> ?{
> - ? ? ? writel(0, host->base + MMC_REG_INT_CNTR);
> + ? ? ? u32 int_cntr = 0;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? if (host->use_sdio)
> + ? ? ? ? ? ? ? int_cntr |= INT_SDIO_IRQ_EN;
> +
> + ? ? ? spin_lock_irqsave(&host->lock, flags);
> + ? ? ? writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> + ? ? ? spin_unlock_irqrestore(&host->lock, flags);

And here.

>
> ? ? ? ?host->req = NULL;
> ? ? ? ?host->cmd = NULL;
> @@ -539,8 +557,12 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>
> ? ? ? ?dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>
> + ? ? ? if ((stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio)
> + ? ? ? ? ? ? ? mmc_signal_sdio_irq(host->mmc);
> +

And here.

> ? ? ? ?if (stat & STATUS_END_CMD_RESP)
> ? ? ? ? ? ? ? ?mxcmci_cmd_done(host, stat);
> +
> ?#ifdef HAS_DMA
> ? ? ? ?if (mxcmci_use_dma(host) &&
> ? ? ? ? ? ? ? ? ?(stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
> @@ -677,11 +699,30 @@ static int mxcmci_get_ro(struct mmc_host *mmc)
> ? ? ? ?return -ENOSYS;
> ?}
>
> +static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> + ? ? ? struct mxcmci_host *host = mmc_priv(mmc);
> + ? ? ? unsigned long flags;
> + ? ? ? u32 int_cntr;
> +
> + ? ? ? spin_lock_irqsave(&host->lock, flags);
> + ? ? ? host->use_sdio = enable;
> + ? ? ? int_cntr = readl(host->base + MMC_REG_INT_CNTR);
> +
> + ? ? ? if (enable)
> + ? ? ? ? ? ? ? int_cntr |= INT_SDIO_IRQ_EN;
> + ? ? ? else
> + ? ? ? ? ? ? ? int_cntr &= ~INT_SDIO_IRQ_EN;
> +
> + ? ? ? writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> + ? ? ? spin_unlock_irqrestore(&host->lock, flags);
> +}

This one is good.

[...]


Best Regards,
Micha? Miros?aw
