From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 9 Jul 2011 03:52:52 +0100
Subject: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <1310140790-2132-3-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
Message-ID: <20110709025252.GC26900@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Again, *always* CC maintainers on patches.

> +static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> +			int clk_id, unsigned int freq, int dir)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	switch (clk_id) {
> +	case MXS_SAIF_SYS_CLK:
> +		clk_set_rate(saif->clk, freq);
> +		clk_enable(saif->clk);

How would one turn this clock off?

> + * SAIF Clock dividers
> + * Should only be called when port is inactive.
> + */
> +static int mxs_saif_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> +				  int div_id, int div)
> +{
> +	u32 scr;
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	scr = __raw_readl(saif->base + SAIF_CTRL);
> +	scr &= ~BM_SAIF_CTRL_BITCLK_MULT_RATE;
> +	scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> +
> +	switch (div_id) {
> +	case MXS_SAIF_MCLK:
> +		switch (div) {
> +		case 32:

No, this stuff should all be figured out automatically by the driver -
the user shouldn't have to manually set the ratio, especially if they've
already set the master clock.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		/* data frame low 1clk before data */
> +		scr |= BM_SAIF_CTRL_DELAY;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		/* data frame high with data */
> +		scr &= ~BM_SAIF_CTRL_DELAY;
> +		scr &= ~BM_SAIF_CTRL_LRCLK_POLARITY;
> +		scr &= ~BM_SAIF_CTRL_JUSTIFY;
> +		break;
> +	}

This should return an error if the parameters are invalid.  The rest of
the code has many other instances of this missing check.

> +	/*
> +	 * Note: We simply just support master mode since SAIF TX only supports
> +	 * master mode.
> +	 */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		scr &= ~BM_SAIF_CTRL_SLAVE_MODE;
> +		__raw_writel(scr | scr0, saif->base + SAIF_CTRL);
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		break;

This is clearly wrong, you're doing exactly the same thing for two
different inputs.

> +static int mxs_saif_startup(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *cpu_dai)
> +{
> +	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
> +	snd_soc_dai_set_dma_data(cpu_dai, substream, &saif->dma_param);
> +
> +	return 0;
> +}

Remove empty functions.

> +/*
> + * Should only be called when port is inactive.
> + * although can be called multiple times by upper layers.
> + */
> +static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *cpu_dai)

The requirement for the port to be inactive is totally unreasonable,
especially given that the params are configured by applications and you
support simultaneous playback and record.

> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
> +{
> +	struct mxs_saif *saif = dev_id;
> +
> +	if (saif->fifo_err_counter++ % 100 == 0)

The rate limit looks awfully suspicious...

> +		printk(KERN_ERR "saif_irq SAIF_STAT %x SAIF_CTRL %x \
> +			fifo_errs=%d \n",
> +		       __raw_readl(saif->base + SAIF_STAT),
> +		       __raw_readl(saif->base + SAIF_CTRL),
> +		       saif->fifo_err_counter);

dev_err()

> +	__raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
> +			BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
> +			saif->base + SAIF_STAT + MXS_CLR_ADDR);
> +
> +	return IRQ_HANDLED;

You're not actually checking that the relevant interrupt fired...

> +	saif->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(saif->clk)) {
> +		ret = PTR_ERR(saif->clk);
> +		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
> +			ret);
> +		goto failed_clk;
> +	}
> +	clk_set_rate(saif->clk, 12000000);
> +	clk_enable(saif->clk);

How did you pick this clock rate and why does it need to be set?  It's
not an obvious audio rate...
