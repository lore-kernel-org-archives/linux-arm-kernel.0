From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 13:45:51 -0700
Subject: [PATCH] ASoC: SAMSUNG: Add SND_SOC_DAIFMT_CONT option for
 snd_soc_set_fmt()
In-Reply-To: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
References: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
Message-ID: <20120827204550.GA4400@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 05:45:54PM +0900, ????? wrote:
> SND_SOC_DAIFMT_CONT option is now needed because of below commit:
> 
> ASoC: Allow DAI formats to be specified in the dai_link

Clearly it's not a direct consequence of this commit, that just
introduces a new optional facility which...

>  	/* Set the cpu DAI configuration */
>  	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_B
> +				| SND_SOC_DAIFMT_CONT
>  				| SND_SOC_DAIFMT_IB_NF
>  				| SND_SOC_DAIFMT_CBS_CFS);

...isn't being used by the driver.

Looking at the above it looks like the PCM driver is doing something
very odd - _CONT doesn't make a whole lot of sense on the slave side,
it's related to the clock generation so should have no effect at all on
the slave side.  The driver code looks reasonably sensible though.

What specifically is going wrong here?
