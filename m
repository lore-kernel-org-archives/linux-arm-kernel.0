From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 28 Oct 2013 07:15:14 +0000
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131024110543.GA18506@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A4FA@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static struct snd_pcm_hardware snd_fsl_hardware = {
> > +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		SNDRV_PCM_INFO_MMAP |
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME,
> > +	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rate_min = 8000,
> > +	.channels_min = 2,
> > +	.channels_max = 2,
> > +	.buffer_bytes_max = FSL_SAI_DMABUF_SIZE,
> > +	.period_bytes_min = 4096,
> > +	.period_bytes_max = FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> > +	.periods_min = TCD_NUMBER,
> > +	.periods_max = TCD_NUMBER,
> > +	.fifo_size = 0,
> > +};
> 
> There's a patch in -next that lets the generic dmaengine code figure out
> some settings from the dmacontroller rather than requiring the driver to
> explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> default config".  Please update your driver to use this, or let's work
> out what it doesn't do any try to fix it.
>

I will do a research.
 
> > +	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> > +					FSL_FMT_TRANSMITTER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's transmitter sysclk: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
> > +					FSL_FMT_RECEIVER);
> 
> As other people have commented these should be exposed as separate clocks
> rather than set in sync, unless there's some hardware reason they need to
> be identical.  If that is the case then a comment explaining the
> limitation would be good.
> 
> Similarly with several of the other functions.
> 

As I have replied before, there is one function couldn't be separated for the hardware limitation.

> > +int fsl_sai_dai_remove(struct snd_soc_dai *dai) {
> > +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> > +
> > +	clk_disable_unprepare(sai->clk);
> 
> It'd be a bit nicer to only enable the clock while the driver is actively
> being used rather than all the time the system is powered up but it's not
> a blocker for merge.
> 
Actully there are to "XXX_probe" functions and two "XXX_remove" functions:

fsl_sai_dai_probe() and fsl_sai_dai_remove() are callbacks of the ASoC subsystem.
And in fsl_sai_dai_probe() needs to read/write the SAI controller's registers, so
the clk_enable_prepare() must be here and clk_disable_unprepare() in fsl_sai_dai_remove().

fsl_sai_probe() and fsl_sai_remove() are the driver's probe and remove interfaces.

So the "+	clk_disable_unprepare(sai->clk);" sentence in fsl_sai_remove() will be removed later.


> > +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> > +			&fsl_sai_dai, 1);
> > +	if (ret)
> > +		return ret;
> 
> There's a devm_snd_soc_register_component() in -next, please use that.
> 
See the next version.

> > +
> > +	ret = fsl_pcm_dma_init(pdev);
> > +	if (ret)
> > +		goto out;
> > +
> > +	platform_set_drvdata(pdev, sai);
> 
> These should go before the driver is registered with the subsystem
> otherwise you've got a race where something might try to use the driver
> before init is finished.
> 
> > +static int fsl_sai_remove(struct platform_device *pdev) {
> > +	struct fsl_sai *sai = platform_get_drvdata(pdev);
> > +
> > +	fsl_pcm_dma_exit(pdev);
> > +
> > +	snd_soc_unregister_component(&pdev->dev);
> 
> Similarly here, unregister from the subsystem then clean up after.
> 

See the next version.

> > +#define SAI_CR5_FBT(x)		((x) << 8)
> > +#define SAI_CR5_FBT_MASK	(0x1f << 8)
> > +
> > +/* SAI audio dividers */
> > +#define FSL_SAI_TX_DIV		0
> > +#define FSL_SAI_RX_DIV		1
> 
> Make the namespacing consistent please - for preference use FSL_SAI
> always.
>

See the next version.
