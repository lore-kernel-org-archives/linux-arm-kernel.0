From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Oct 2013 11:11:41 -0500
Subject: [PATCH v3 2/4] mmc: omap_hsmmc: Enable SDIO IRQ.
In-Reply-To: <1380971830-21492-3-git-send-email-afenkart@gmail.com>
References: <1380971830-21492-1-git-send-email-afenkart@gmail.com>
 <1380971830-21492-3-git-send-email-afenkart@gmail.com>
Message-ID: <20131008161131.GD13128@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 05, 2013 at 01:17:08PM +0200, Andreas Fenkart wrote:
> For now, only support SDIO interrupt if we are booted with
> DT. This is because some platforms need special quirks. And
> we don't want to add new legacy mux platform init code
> callbacks any longer as we are moving to DT based booting
> anyways.
> 
> Broken hardware, missing the swakueup line, should fallback
> to polling, by setting 'ti,quirk-swakup-missing' in the
> device tree. Otherwise pending SDIO IRQ are not detected
> while in suspend. This affects am33xx processors.
> 
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

I still think this patch needs to be splitted, see below.

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 94d6dc8..53beac4 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -130,6 +130,7 @@ static void apply_clk_hack(struct device *dev)
>  #define TC_EN			(1 << 1)
>  #define BWR_EN			(1 << 4)
>  #define BRR_EN			(1 << 5)
> +#define CIRQ_EN			(1 << 8)
>  #define ERR_EN			(1 << 15)
>  #define CTO_EN			(1 << 16)
>  #define CCRC_EN			(1 << 17)
> @@ -210,6 +211,10 @@ struct omap_hsmmc_host {
>  	int			reqs_blocked;
>  	int			use_reg;
>  	int			req_in_progress;
> +	int                     flags;
> +#define HSMMC_RUNTIME_SUSPENDED	(1 << 0)        /* Runtime suspended */
> +#define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
> +
>  	struct omap_hsmmc_next	next_data;
>  	struct	omap_mmc_platform_data	*pdata;
>  };
> @@ -490,27 +495,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
>  static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>  				  struct mmc_command *cmd)
>  {
> -	unsigned int irq_mask;
> +	u32 irq_mask = INT_EN_MASK;
> +	unsigned long flags;
>  
>  	if (host->use_dma)
> -		irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
> -	else
> -		irq_mask = INT_EN_MASK;
> +		irq_mask &= ~(BRR_EN | BWR_EN);

is this a bugfix ? should it be sent as a separate patch ?

>  
>  	/* Disable timeout for erases */
>  	if (cmd->opcode == MMC_ERASE)
>  		irq_mask &= ~DTO_EN;
>  
> +	spin_lock_irqsave(&host->irq_lock, flags);

why do you need this new locking here ? register acesses are atomic,
right ? If you really do need the locking, should it be a separate patch
as well ?

>  	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>  	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> +
> +	/* latch pending CIRQ, but don't signal */
> +	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
> +		irq_mask |= CIRQ_EN;

why do you need this ? Looks like it should be yet another patch.
>  
>  static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>  {
> -	OMAP_HSMMC_WRITE(host->base, ISE, 0);
> -	OMAP_HSMMC_WRITE(host->base, IE, 0);
> +	u32 irq_mask = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +	/* no transfer running, need to signal cirq if */

if... ?

> +	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
> +		irq_mask |= CIRQ_EN;
> +	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);

the whole fiddling with STAT and ISE registers look very bogus to me
(even on current state before this patch). We shouldn't be clearing
pending IRQ events here, right ? We could miss IRQs due to that.

> @@ -1067,8 +1085,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>  	int status;
>  
>  	status = OMAP_HSMMC_READ(host->base, STAT);
> -	while (status & INT_EN_MASK && host->req_in_progress) {
> -		omap_hsmmc_do_irq(host, status);
> +	while (status & (INT_EN_MASK | CIRQ_EN)) {

why don't enable CIRQ_EN in INT_EN_MASK directly ?

> +		if (host->req_in_progress)
> +			omap_hsmmc_do_irq(host, status);
> +
> +		if (status & CIRQ_EN)
> +			mmc_signal_sdio_irq(host->mmc);
>  
>  		/* Flush posted write */
>  		status = OMAP_HSMMC_READ(host->base, STAT);
> @@ -1583,6 +1605,42 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  		mmc_slot(host).init_card(card);
>  }
>  
> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
> +	u32 irq_mask;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +
> +	if (enable)
> +		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
> +	else
> +		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
> +
> +	/* if statement here with followup patch */
> +	{
> +		irq_mask = OMAP_HSMMC_READ(host->base, ISE);
> +		if (enable)
> +			irq_mask |= CIRQ_EN;
> +		else
> +			irq_mask &= ~CIRQ_EN;

perhaps combine this branch with previous one ?

> +		OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> +
> +		/*
> +		 * if enable, piggy back on current request
> +		 * but always disable
> +		 */
> +		if (!host->req_in_progress || !enable)
> +			OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> +
> +		/* flush posted write */
> +		OMAP_HSMMC_READ(host->base, IE);
> +	}
> +
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +}
> +
>  static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>  {
>  	u32 hctl, capa, value;
> @@ -1635,7 +1693,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>  	.get_cd = omap_hsmmc_get_cd,
>  	.get_ro = omap_hsmmc_get_ro,
>  	.init_card = omap_hsmmc_init_card,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -1833,6 +1891,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	host->dma_ch	= -1;
>  	host->irq	= irq;
>  	host->slot_id	= 0;
> +	host->flags	= 0;

why do you need to zero-initialize flags here ? another bug ?

> @@ -2023,6 +2082,22 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev,
>  			"pins are not configured from the driver\n");
>  
> +	/*
> +	 * For now, only support SDIO interrupt if we are booted with
> +	 * DT. This is because some platforms need special quirks. And
> +	 * we don't want to add new legacy mux platform init code
> +	 * callbacks any longer as we are moving to DT based booting
> +	 * anyways.
> +	 */
> +	if (match) {

isn't if (dev->of.node) a better check here ?

> +		mmc->caps |= MMC_CAP_SDIO_IRQ;
> +		if (of_find_property(host->dev->of_node,
> +				     "ti,quirk-swakeup-missing", NULL)) {

looks like a SW configuration to me. Can't you figure this out by
reading the revision register ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/0f7da3d9/attachment.sig>
