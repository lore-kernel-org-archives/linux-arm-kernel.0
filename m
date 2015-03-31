From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 07:42:09 +0100
Subject: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
In-Reply-To: <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
Message-ID: <20150331064209.GD2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 08:16:24PM -0700, Scott Branden wrote:

The CC list for this patch is pretty wide - please look at who you're
sending this to and try to send to only relevant people (for example I'm
not sure the Raspberry Pi people need to review this).  People working
upstream get a lot of mail so it's helpful to avoid filling their
inboxes with random irrelevant stuff.

>  sound/soc/bcm/Kconfig      |   11 +
>  sound/soc/bcm/Makefile     |    5 +-
>  sound/soc/bcm/cygnus-pcm.c |  918 +++++++++++++++++++++++++
>  sound/soc/bcm/cygnus-pcm.h |   45 ++
>  sound/soc/bcm/cygnus-ssp.c | 1613 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/bcm/cygnus-ssp.h |   84 +++
>  6 files changed, 2675 insertions(+), 1 deletion(-)

Send the DMA and DAI drivers as separate patches please, it makes review
easier.

> +config SND_SOC_CYGNUS
> +	tristate "SoC platform audio for Broadcom Cygnus chips"
> +	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> +	default ARCH_BCM_CYGNUS

Remove the default setting here - we don't do this for other drivers, we
shouldn't do it here.

> +/*
> + * PERIOD_BYTES_MIN is the number of bytes to at which the interrupt will tick.
> + * This number should be a multiple of 256
> + */
> +#define PERIOD_BYTES_MIN 0x100

This sounds like it's a setting rather than actually the minimum?

> +static const struct snd_pcm_hardware cygnus_pcm_hw = {
> +	.info = SNDRV_PCM_INFO_MMAP |
> +			SNDRV_PCM_INFO_MMAP_VALID |
> +			SNDRV_PCM_INFO_INTERLEAVED,

The DMA controller is integrated into the IP?

> +static int enable_count;

This looks bogus - why is this a global variable not part of the device
struct and if it does need to be global why does it need no locking?

> +		if (aio->portnum == 0)
> +			*p_rbuf = RINGBUF_REG_PLAYBACK(0);
> +		else if (aio->portnum == 1)
> +			*p_rbuf = RINGBUF_REG_PLAYBACK(2);
> +		else if (aio->portnum == 2)
> +			*p_rbuf = RINGBUF_REG_PLAYBACK(4);
> +		else if (aio->portnum == 3)
> +			*p_rbuf = RINGBUF_REG_PLAYBACK(6); /*SPDIF */
> +		else
> +			status = -EINVAL;

This looks like a switch statement, there are many places in the code
where you're writing switch statements as chains of ifs.

> +static void ringbuf_inc(void __iomem *audio_io, bool is_playback,
> +			const struct ringbuf_regs *p_rbuf)
> +{
> +	u32 regval, endval, active_ptr;
> +
> +	if (is_playback)
> +		active_ptr = p_rbuf->wraddr;
> +	else
> +		active_ptr = p_rbuf->rdaddr;
> +
> +	endval = readl(audio_io + p_rbuf->endaddr);
> +	regval = readl(audio_io + active_ptr);
> +	regval = regval + p_rbuf->period_bytes;
> +	if (regval > endval)
> +		regval -= p_rbuf->buf_size;
> +
> +	writel(regval, audio_io + active_ptr);
> +}

So it looks like we're getting an interrupt per period and we have to
manually advance to the next one?

> +static irqreturn_t cygnus_dma_irq(int irq, void *data)
> +{
> +	u32 r5_status;
> +	struct cygnus_audio *cygaud;
> +
> +	cygaud = (struct cygnus_audio *)data;

If you need to cast away from void something is very wrong.

> +	/*
> +	 * R5 status bits	Description
> +	 *  0		ESR0 (playback FIFO interrupt)
> +	 *  1		ESR1 (playback rbuf interrupt)
> +	 *  2		ESR2 (capture rbuf interrupt)
> +	 *  3		ESR3 (Freemark play. interrupt)
> +	 *  4		ESR4 (Fullmark capt. interrupt)
> +	 */
> +	r5_status = readl(cygaud->audio + INTH_R5F_STATUS_OFFSET);
> +
> +	/* If playback interrupt happened */
> +	if (ANY_PLAYBACK_IRQ & r5_status)
> +		handle_playback_irq(cygaud);
> +
> +	/* If  capture interrupt happened */
> +	if (ANY_CAPTURE_IRQ & r5_status)
> +		handle_capture_irq(cygaud);
> +
> +	/*
> +	 * clear r5 interrupts after servicing them to avoid overwriting
> +	 * esr_status
> +	 */
> +	writel(r5_status, cygaud->audio + INTH_R5F_CLEAR_OFFSET);

This feels racy especially given that we seem to need every interrupt
delivering.  What if another period happens during the servicing?  I
don't understand what "overwriting esr_status" means here.

> +	return IRQ_HANDLED;

If neither playback nor capture interrupts were flagged we should return
IRQ_NONE.

> +/*
> + * This code is identical to what is done by the framework, when we do not
> + * supply a 'copy' function.  Having our own copy hook in place allows for
> + * us to easily add some diagnotics when needed.
> + */
> +int cygnus_pcm_copy(struct snd_pcm_substream *substream, int channel,
> +		snd_pcm_uframes_t pos,
> +		void __user *buf, snd_pcm_uframes_t count)

This is obviously not suitable for mainline - "let's just cut'n'paste
the shared code in case we want to add diagnostics in future" does not
scale, you can always add local diagnostics in the core code.

> +};
> +/*

Blank line between these two please.  Missing blanks between bits of
code seem to be a common issue in this driver.

> +static int audio_ssp_in_enable(struct cygnus_aio_port *aio, bool enable)
> +{
> +	u32 value;
> +
> +	if (enable) {

> +	} else {

Why not just write two functions?

> +static int audio_ssp_source_bitres(struct cygnus_aio_port *aio, unsigned bits)
> +{
> +	u32 mask = 0x1f;
> +	u32 value = 0;
> +
> +	if ((bits == 8) || (bits == 16) || (bits == 32)) {
> +		value = readl(aio->audio + aio->regs.bf_sourcech_cfg);
> +		value &= ~(mask << BF_SRC_CFGX_BIT_RES);
> +
> +		/* 32 bit mode is coded as 0 */
> +		if ((bits == 8) || (bits == 16))
> +			value |= (bits << BF_SRC_CFGX_BIT_RES);
> +
> +		writel(value, aio->audio + aio->regs.bf_sourcech_cfg);
> +		return 0;
> +	}
> +
> +	pr_err("Bit resolution not supported %d\n", bits);
> +	return -EINVAL;

dev_err() (this applies throughout the driver).

It's not clear why this is a function and not just written as a single
statement in the one place that it's used (there are multiple calls but
they're all together and could just be inlined).

> +	if (!aio->bitrate) {
> +		pr_err("%s Use .set_clkdiv() to set bitrate\n", __func__);
> +		return -EINVAL;
> +	}

This seems bogus - why are we enforcing the use of set_clkdiv()?  Can't
we figure out something esneible?

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	/* Set the SSP up as slave */
> +	case SND_SOC_DAIFMT_CBM_CFM:

The comments here look odd due to the indentation and really aren't
adding much anyway.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		return -EINVAL;

These are just eaten by the default case.

> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		ssp_newcfg |= BIT(I2S_OUT_CFGX_TDM_MODE);
> +
> +		/* DSP_A = data after FS, DSP_B = data during FS */
> +		if (SND_SOC_DAIFMT_DSP_A)
> +			ssp_newcfg |= BIT(I2S_OUT_CFGX_DATA_ALIGNMENT);

That if statement isn't doing what was intended...

> +	} else {
> +
> +		switch (cmd) {
> +		case SNDRV_PCM_TRIGGER_START:
> +			audio_ssp_in_enable(aio, 1);
> +			break;
> +
> +		case SNDRV_PCM_TRIGGER_STOP:
> +			audio_ssp_in_enable(aio, 0);
> +			break;
> +		}

We can just ignore other triggers?  It's not clear why this is different
to the playback case.

> +int cygnus_ssp_get_mode(struct snd_soc_dai *cpu_dai)
> +{
> +	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
> +
> +	return aio->mode;
> +}
> +EXPORT_SYMBOL(cygnus_ssp_get_mode);

What is this for, it's setting off alarm bells?  Note also that ASoC is
_GPL() only.

> +static const struct snd_kcontrol_new pll_tweak_controls[] = {
> +	SOC_SINGLE_EXT("PLL Tweak", 0, 0, PLL_NDIV_FRACT_MAX, 0,
> +	pll_tweak_get, pll_tweak_put),
> +};

Whatever this control is doing it should be a separate patch (as I think
we discussed in person a ELC?), it's clearly something that's unusual
and is likely to block the rest of the code as a result.  At a high
level this needs at least some documentation.

> +int cygnus_ssp_add_pll_tweak_controls(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +
> +	return snd_soc_add_dai_controls(cpu_dai,
> +				pll_tweak_controls,
> +				ARRAY_SIZE(pll_tweak_controls));
> +}
> +EXPORT_SYMBOL(cygnus_ssp_add_pll_tweak_controls);

Again, why is this being exported and why is it not _GPL?  If the driver
is adding controls I'd expect it to just add its controls itself.

> +static int cygnus_ssp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *child_node;
> +	struct resource *res = pdev->resource;
> +	struct cygnus_audio *cygaud;
> +	int err = -EINVAL;
> +	int node_count;
> +	int active_port_count;
> +
> +	if (!of_match_device(cygnus_ssp_of_match, dev)) {
> +		dev_err(dev, "Failed to find ssp controller\n");
> +		return -ENODEV;
> +	}

This error message is misleading - you mean to say that the driver got
loaded for a device it doesn't understand.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cygaud->audio = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(cygaud->audio)) {
> +		dev_err(dev, "audio_io ioremap failed\n");
> +		return PTR_ERR(cygaud->audio);

devm_ioremap_resource() will complain for you, and in general you should
be printing error codes.

> +	node_count = 0;

This doesn't seem to be needed?

> +	node_count = of_get_child_count(pdev->dev.of_node);
> +	if ((node_count < 1) || (node_count > CYGNUS_MAX_PORTS)) {
> +		dev_err(dev, "Incorrct number of child nodes\n");
> +		return -EINVAL;

Spelling mistake there and it would be helpful to the user to tell them
what we parsed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/c15e0492/attachment.sig>
