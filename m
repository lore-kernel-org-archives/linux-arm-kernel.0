From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 20 Mar 2010 17:18:11 +0000
Subject: [PATCH 4/6] ASoC: support pxa168 ssp in ASoC
In-Reply-To: <771cded01003190854i57f54842g3b5dd0a521e14b1c@mail.gmail.com>
References: <771cded01003190854i57f54842g3b5dd0a521e14b1c@mail.gmail.com>
Message-ID: <20100320171811.GC1549@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 11:54:02AM -0400, Haojian Zhuang wrote:

> +static const struct ssp_mclk mclk_conf[] = {
> +       /* rate, fmt, chn, mclk,   den, num, bclk, den, num */
> +       {96000, 16, 2, 12288000,  63, 1625, 3072000,  1,  2},
> +       {96000, 16, 1, 12288000,  63, 1625, 3072000,  1,  8},

Since the mclk_conf table isn't exported outside the SSP driver it
definitely seems worth refactoring the way the configuration is looked
up so machine drivers needn't get so involved like I suggested when
reviewing the machine driver.

> +	if ((clk_id != PXA168_ASYSCLK_MASTER)
> +		&& (clk_id != PXA168_ASYSCLK_SLAVE)) {
> +		dev_warn(&ssp->pdev->dev, "Wrong clk_id(%d) is specified\n",
> +			clk_id);
> +		return -EINVAL;
> +	}

Use a switch statement here.

> +	/* generate correct DMA params */
> +	if (cpu_dai->dma_data)
> +		kfree(cpu_dai->dma_data);

It should be possible to call kfree() directly, it should take a NULL
happily.

> +	if ((width == 16) && (params_channels(params) == 1))
> +		dma_16b = 1;
> +	stream_out = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ? 1 : 0;

Please don't use the ternery operator like this, it's not wonderfully
legible.

> +	/* data_size should only be 16-bit or 32-bit because of DMA */
> +	data_size = width * channels;

It'd be good to add a note about how 24 bit data comes out here - it's
not immediately obvious to the reader.

> +	switch (data_size) {
> +	case 16:
> +		sscr0 |= SSCR0_DataSize(16);
> +		break;
> +	case 32:
> +		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
> +		break;
> +	}

Add a default: case in case something goes wrong (eg, someone updating
the driver for new hardware doesn't notice this bit).

> +	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		/*
> +		 * The polarity of frame sync should be inverted at here.
> +		 *
> +		 * In I2S format, frame sync is always inactive while
> +		 * transfering data of left channel. So some additional
> +		 * parameters like frame width, frame delay should be
> +		 * configured. And more bit clocks in one frame cycle should
> +		 * be reserved to meet the clock delay formula.

Some clarification of at least the last sentance here would help - what
is the formula, or where can one find it?

> +		 *
> +		 * If frame sync signal is inverted, frame width & frame
> +		 * delay needn't be configured at here.
> +		 */
> +		sspsp |= SSPSP_SFRMWDTH(width);
> +		if (channels == 1) {
> +			sspsp |= SSPSP_DMYSTRT(1);
> +			sspsp |= SSPSP_DMYSTOP((width - 1) & 0x3);
> +			sspsp |= SSPSP_EDMYSTOP(((width - 1) >> 2) & 0x7);
> +		} else if (channels == 2) {
> +			if (width == 32) {
> +				dev_err(&ssp->pdev->dev, "can't support %d-"
> +					"data with %-channels in I2S mode\n",
> +					width, channels);

Please don't split error messages over multiple lines like this (it
makes it harder to find the source code when you see them in the logs).

> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		/* Right Justified mode doesn't support 32-bit data */
> +		if (params_format(params) == SNDRV_PCM_FORMAT_S32_LE)
> +			return -EINVAL;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		sspsp |= SSPSP_SFRMWDTH(width);
> +		break;

I'd expect to see left and right justified data configured very much
like I2S?  The clocks are very similar, it's just the location of the
data within the clocks that changes.

It also seems a little odd that DSP modes aren't supported - they're a
much more natural fit for the SSP port.

> +static void __exit pxa168_ssp_exit(void)
> +{
> +	struct snd_soc_dai *dai = NULL;
> +	int i;
> +
> +	for (i = 0; i < PXA168_DAI_SSP_MAX; i++) {

ARRAY_SIZE()?  Then you can just drop the _MAX definition - one less
thing to update if a device with more DAIs comes along.

> +/* pxa DAI SSP IDs */
> +enum {
> +	PXA168_DAI_SSP1,
> +	PXA168_DAI_SSP2,
> +	PXA168_DAI_SSP3,
> +	PXA168_DAI_SSP4,
> +	PXA168_DAI_SSP5,
> +	PXA168_DAI_SSP_MAX,
> +};

Similar comments to my previous ones on the use of an enum apply here.

> +
> +/* PXA168 SSP SYSCLK source */
> +#define PXA168_ASYSCLK_MASTER		0	/* ASYSCLK master -- pxa168 */
> +#define PXA168_ASYSCLK_SLAVE		1	/* ASYSCLK slave -- pxa168 */

As previously mentioned the master/slave setup should be done using the
direction parameter of set_sysclk().
