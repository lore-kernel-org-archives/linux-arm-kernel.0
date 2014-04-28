From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 29 Apr 2014 00:35:41 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVNvQzogZnNsOiBzZWxlY3QgU05EX1NPQ19JTVhfUENN?=
 =?UTF-8?B?X0RNQSB3aGVyZSBuZWVkZWQ=?=
In-Reply-To: <7785150.X1QaggmPtm@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <1398710770.235891074@f303.i.mail.ru>
 <7785150.X1QaggmPtm@wuerfel>
Message-ID: <1398717341.630093136@f319.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 28 Apr 2014 21:52:16 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> On Monday 28 April 2014 22:46:10 Alexander Shiyan wrote:
> > Mon, 28 Apr 2014 16:46:30 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> > > Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> > > options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> > > manually. However, these two options are for drivers that both
> > > require the imx-pcm-dma framework and result in a link error if that
> > > is not provided.
> > > 
> > > This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
> > > to avoid the problem, as we do for other drivers that need the same
> > > framework.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Can you give an exact error?
> 
> 
> sound/built-in.o: In function `fsl_ssi_probe':
> :(.text+0x51fb8): undefined reference to `imx_pcm_dma_init'
> sound/built-in.o: In function `fsl_spdif_probe':
> :(.text+0x52e20): undefined reference to `imx_pcm_dma_init'

This call is defined in imx-pcm.h as:
#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
int imx_pcm_dma_init(struct platform_device *pdev);
#else
static inline int imx_pcm_dma_init(struct platform_device *pdev)
{
  return -ENODEV;
}
#endif

So, I don't understand why this error happen, as well as I can not
reproduce this...

---
