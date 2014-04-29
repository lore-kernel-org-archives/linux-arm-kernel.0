From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 29 Apr 2014 07:07:33 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVNvQzogZnNsOiBzZWxlY3QgU05EX1NPQ19JTVhfUENN?=
 =?UTF-8?B?X0RNQSB3aGVyZSBuZWVkZWQ=?=
In-Reply-To: <6285923.UQqcZVikjI@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <1398717341.630093136@f319.i.mail.ru>
 <6285923.UQqcZVikjI@wuerfel>
Message-ID: <1398740853.880576398@f238.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 28 Apr 2014 23:12:14 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 29 April 2014 00:35:41 Alexander Shiyan wrote:
...
> > > > > Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> > > > > options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> > > > > manually. However, these two options are for drivers that both
> > > > > require the imx-pcm-dma framework and result in a link error if that
> > > > > is not provided.
> > > > > 
> > > > > This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
> > > > > to avoid the problem, as we do for other drivers that need the same
> > > > > framework.
> > > > > 
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > Can you give an exact error?
> > > 
> > > 
> > > sound/built-in.o: In function `fsl_ssi_probe':
> > > :(.text+0x51fb8): undefined reference to `imx_pcm_dma_init'
> > > sound/built-in.o: In function `fsl_spdif_probe':
> > > :(.text+0x52e20): undefined reference to `imx_pcm_dma_init'
> > 
> > This call is defined in imx-pcm.h as:
> > #if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
> > int imx_pcm_dma_init(struct platform_device *pdev);
> > #else
> > static inline int imx_pcm_dma_init(struct platform_device *pdev)
> > {
> >   return -ENODEV;
> > }
> > #endif
> > 
> > So, I don't understand why this error happen, as well as I can not
> > reproduce this...
> 
> It's probably CONFIG_SND_SOC_IMX_PCM_DMA=m and CONFIG_SND_SOC_FSL_SSI=y then.
> What is the intended behavior in this case? Should CONFIG_SND_SOC_FSL_SSI
> be forced to be a module as well?

Hmm, yes...
I thought that I had already solved a similar problem for the earlier
version of the patch ...

---
