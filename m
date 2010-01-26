From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 10:47:23 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100126104723.GF15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 02:51:40PM +0900, jassisinghbrar at gmail.com wrote:

This looks good overall, just a few smallish issues:

> +static void s3c_ac97_activate(struct snd_ac97 *ac97)
> +{
> +	u32 ac_glbctrl, stat;
> +
> +	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
> +	switch (stat) {
> +	case S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE:
> +		return;
> +	case S3C_AC97_GLBSTAT_MAINSTATE_READY:
> +	case S3C_AC97_GLBSTAT_MAINSTATE_INIT:
> +		break;
> +	default:
> +		s3c_ac97_cold_reset(ac97);
> +		s3c_ac97_warm_reset(ac97);
> +		break;
> +	}

This automatic cold and warm reset looks a bit fishy - obviously if this
code path ever gets hit in normal operation then it's going to seriously
disrupt things since it'll reset the CODEC registers.  A warm reset by
itself wouldn't be a problem but I'd rather see explicit cold resets in
the callers where that's required.

> +	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
> +	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +	msleep(1);

This also looks a bit odd, ACLINKON sounds like bringing up the link
which is what a warm reset does.

> +	INIT_COMPLETION(s3c_ac97.done);
> +
> +	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
> +		printk(KERN_ERR "AC97: Unable to activate!");

This looks racy - the INIT_COMPLETION() happens after all the hardware
configuration which suggests that if you're unlucky the event which
should trigger the completion will have happened before the init.  A
bunch of interrupts arriving at an inconvenient time could trigger this,
for example.

The same idiom appears in the register reads and writes.

> +	if (addr != reg)
> +		printk(KERN_ERR "s3c-ac97: req addr = %02x,"
> +				" rep addr = %02x\n", reg, addr);

Please don't split error messages over multiple lines, it makes grepping
for them harder.

> +static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
> +{
> +	u32 ac_glbctrl, ac_glbstat;
> +
> +	ac_glbstat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT);
> +
> +	if (ac_glbstat & S3C_AC97_GLBSTAT_CODECREADY) {
> +
> +		ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +		ac_glbctrl &= ~S3C_AC97_GLBCTRL_CODECREADYIE;
> +		writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +
> +		ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +		ac_glbctrl |= (1<<30); /* Clear interrupt */
> +		writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
> +
> +		complete(&s3c_ac97.done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

You should only be returning IRQ_HANDLED if you actually handled an
interrupt here.

> +#define S3C_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
> +		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +		SNDRV_PCM_RATE_48000)

SNDRV_PCM_RATE_8000_48000.

> +		.capture = {
> +			.stream_name = "AC97 Capture",
> +			/* NOTE: If the codec ouputs just one slot,
> +			 * it *seems* our AC97 controller reads the only
> +			 * valid slot(if either 3 or 4) for PCM-In.
> +			 * For such cases, we record Mono.
> +			 */

This seems like unsurprising behaviour for an AC97 controller - the slot
validity information is there for just this purpose.  I'd just remove
the comment as a result.

> +		.capture = {
> +			.stream_name = "AC97 Mic Capture",
> +			.channels_min = 1,
> +			/* NOTE: If the codec(like WM9713) can't ouput just
> +			 * one slot, it *seems* our AC97 controller reads
> +			 * two slots(if one of them is Slot-6) for MIC also.
> +			 * For such cases, we record Stereo.
> +			 */

Similarly here.

> +	if (ac97_pdata->cfg_gpio(pdev)) {
> +		dev_err(&pdev->dev, "Unable to configure gpio\n");
> +		ret = -EINVAL;
> +		goto lb3;
> +	}

Should really check for the function being non-NULL here.

> +lb5:
> +	free_irq(irq_res->start, NULL);

Perhaps a better name than 'lb' - err, or fail or something.  lb means
nothing to me at least.

> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq_res)
> +		free_irq(irq_res->start, NULL);

This should never get called if the resources aren't allocated.
