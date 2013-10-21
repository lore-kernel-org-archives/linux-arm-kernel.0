From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 21 Oct 2013 06:59:10 +0000
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <526021B0.6050206@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828667B8@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> > +		struct snd_pcm_hw_params *params,
> > +		struct snd_soc_dai *cpu_dai)
> > +{
> > +	int ret;
> > +
> > +	ret = fsl_sai_hw_params_tr(substream, params, cpu_dai,
> > +				FSL_FMT_TRANSMITTER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai transmitter hw params: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = fsl_sai_hw_params_tr(substream, params, cpu_dai,
> > +				FSL_FMT_RECEIVER);
> > +	if (ret) {
> > +		dev_err(cpu_dai->dev,
> > +				"Cannot set sai's receiver hw params: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> 
> Shouldn't, depending on the substream direction, either transmit or
> receiver be configured, instead of always configuring both?
> 

Yes, this can be configed separately. Please see the next version.

> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_sai_trigger(struct snd_pcm_substream *substream, int
> cmd,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
> > +	unsigned int tcsr, rcsr;
> > +
> > +	tcsr = readl(sai->base + SAI_TCSR);
> > +	rcsr = readl(sai->base + SAI_RCSR);
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +		rcsr |= SAI_CSR_TERE | SAI_CSR_FRDE;
> > +		tcsr |= SAI_CSR_TERE | SAI_CSR_FRDE;
> > +		writel(rcsr, sai->base + SAI_RCSR);
> > +		udelay(10);
> > +		writel(tcsr, sai->base + SAI_TCSR);
> > +		break;
> > +
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +	case SNDRV_PCM_TRIGGER_SUSPEND:
> > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +		tcsr &= ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> > +		rcsr &= ~(SAI_CSR_TERE | SAI_CSR_FRDE);
> > +		writel(tcsr, sai->base + SAI_TCSR);
> > +		udelay(10);
> > +		writel(rcsr, sai->base + SAI_RCSR);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> 
> Same here, shouldn't tx and rx be started independently depending on the
> substream direction?
> 

But this couldn't, from the SAI's spec we can see that:
------
The SAI transmitter and receiver can be configured to operate with synchronous bit clock
and frame sync.

1), 
If the transmitter bit clock and frame sync are to be used by both the transmitter and
receiver:
* The transmitter must be configured for asynchronous operation and the receiver for
synchronous operation.
* In synchronous mode, the receiver is enabled only when both the transmitter and
receiver are enabled.
* It is recommended that the transmitter is the last enabled and the first disabled.

2),
If the receiver bit clock and frame sync are to be used by both the transmitter and
receiver:
* The receiver must be configured for asynchronous operation and the transmitter for
synchronous operation.
* In synchronous mode, the transmitter is enabled only when both the receiver and
transmitter are both enabled.
* It is recommended that the receiver is the last enabled and the first disabled.
------

The receiver and transmitter should be both enabled at the same time if any of them is alive.


> > +	return 0;
> > +}
> > +
> > +static struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> 
> const
> 

Please see the next version.
