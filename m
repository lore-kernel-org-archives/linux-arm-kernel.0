From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Mar 2014 16:34:04 +0100
Subject: [PATCH v4 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <1394462512-11620-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394462512-11620-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <2475487.axlvKsBQ0c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 15:41:51 Maxime Ripard wrote:

> +/*
> + * Hardware representation of the LLI
> + *
> + * The hardware will be fed the physical address of this structure,
> + * and read its content in order to start the transfer.
> + */
> +struct sun6i_dma_lli {
> +	u32			cfg;
> +	u32			src;
> +	u32			dst;
> +	u32			len;
> +	u32			para;
> +	u32			p_lli_next;
> +	struct sun6i_dma_lli	*v_lli_next;
> +} __packed;

It looks strange to have a pointer in a hardware structure, since
the pointer doesn't make sense to the device.

Also, the '__packed' attribute seems strange. Are you sure
you want to reduce the alignment from 4 bytes to 1 byte?

> +static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
> +{
> +	struct sun6i_dma_dev *sdev = dev_id;
> +	struct sun6i_vchan *vchan;
> +	struct sun6i_pchan *pchan;
> +	int i, j, ret = IRQ_NONE;
> +	u32 status;
> +
> +	for (i = 0; i < 2; i++) {
> +		status = readl(sdev->base + DMA_IRQ_STAT(i));
> +		if (!status)
> +			continue;
> +
> +		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
> +			i ? "high" : "low", status);
> +
> +		writel(status, sdev->base + DMA_IRQ_STAT(i));
> +
> +		for (j = 0; (j < 8) && status; j++) {
> +			if (status & DMA_IRQ_QUEUE) {
> +				pchan = sdev->pchans + j;
> +				vchan = pchan->vchan;
> +
> +				if (vchan) {
> +					unsigned long flags;
> +
> +					spin_lock_irqsave(&vchan->vc.lock,
> +							  flags);

Interrupts are already disabled here.

> +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sdc->clk)) {
> +		dev_err(&pdev->dev, "No clock specified\n");
> +		return PTR_ERR(sdc->clk);
> +	}
> +
> +	mux = devm_clk_get(&pdev->dev, "ahb1_mux");
> +	if (IS_ERR(mux)) {
> +		dev_err(&pdev->dev, "Couldn't get AHB1 Mux\n");
> +		return PTR_ERR(mux);
> +	}
> +
> +	pll6 = devm_clk_get(&pdev->dev, "pll6");
> +	if (IS_ERR(pll6)) {
> +		dev_err(&pdev->dev, "Couldn't get PLL6\n");
> +		return PTR_ERR(pll6);
> +	}
> +
> +	ret = clk_set_parent(mux, pll6);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't reparent AHB1 on PLL6\n");
> +		return ret;
> +	}

Neither "pll6" nor "ahb1_mux" are listed in the DT binding. Also, why
is it the driver's business to set the parent?

	Arnd
