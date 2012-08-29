From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Wed, 29 Aug 2012 20:06:32 +0900
Subject: [PATCH] ASoC: SAMSUNG: Add SND_SOC_DAIFMT_CONT option for
 snd_soc_set_fmt()
In-Reply-To: <20120827204550.GA4400@opensource.wolfsonmicro.com>
References: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
 <20120827204550.GA4400@opensource.wolfsonmicro.com>
Message-ID: <001d01cd85d6$59298040$0b7c80c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 05:45:54PM +0900, Mark Brown wrote:
> On Sun, Aug 26, 2012 at 05:45:54PM +0900,  ?    wrote:
> > SND_SOC_DAIFMT_CONT option is now needed because of below commit:
> >
> > ASoC: Allow DAI formats to be specified in the dai_link
> 
> Clearly it's not a direct consequence of this commit, that just introduces a new optional facility
> which...
OK, I'll change it.
> 
> >  	/* Set the cpu DAI configuration */
> >  	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_B
> > +				| SND_SOC_DAIFMT_CONT
> >  				| SND_SOC_DAIFMT_IB_NF
> >  				| SND_SOC_DAIFMT_CBS_CFS);
> 
> ...isn't being used by the driver.
> 
> Looking at the above it looks like the PCM driver is doing something very odd - _CONT doesn't make
> a whole lot of sense on the slave side, it's related to the clock generation so should have no
> effect at all on the slave side.  The driver code looks reasonably sensible though.
You mean cpu side is slave? 
And I think that pcm driver can be changed to solve this issue.
> 
> What specifically is going wrong here?
SND_SOC_DAIFMT_CONT is used sound/soc/Samsung/pcm.c (s3c_pcm_set_fmt()) like below.

switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
        case SND_SOC_DAIFMT_CONT:
                pcm->idleclk = 1;
                break;
        case SND_SOC_DAIFMT_GATED:
                pcm->idleclk = 0;
                break;
        default:
                dev_err(pcm->dev, "Invalid Clock gating request!\n");
                ret = -EINVAL;
                goto exit;
        }

If fmt argument has no SND_SOC_DAIFMT_ option, s3c_pcm_set_fmt() return -EINVAL.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
