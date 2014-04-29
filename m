From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 21:16:35 +0200
Subject: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
In-Reply-To: <20140429165630.GD16981@sirena.org.uk>
References: <6606961.lAGLvkNsEj@wuerfel> <535FB793.5050200@metafoo.de>
 <20140429165630.GD16981@sirena.org.uk>
Message-ID: <8655908.M1OtjG8JKI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 09:56:30 Mark Brown wrote:
> On Tue, Apr 29, 2014 at 04:30:43PM +0200, Lars-Peter Clausen wrote:
> 
> > Yes. The patch should also add a select for SND_SOC_IMX_PCM_FIQ as that is
> > used in the same way in the fsl_ssi driver. If anybody is afraid that
> > selecting both SND_SOC_IMX_PCM_FIQ and SND_SOC_IMX_PCM_DMA by default adds
> > too much overhead you could add boolean sub-options that allow to
> > enable/disable support individually.
> 
> Yes, the overhead should be negligable since the FIQ code is tiny.
> Arnd, please CC maintainers on patches - you've sent this to my
> Linaro address again and not added Liam.

I've tried yet another approach now, this should also work and
has simpler dependencies. I'll follow up with the suggested patch
and let you pick one or the other.

Sorry for using the wrong Cc list, I too the addresses out of the
patch that introduced the problem and didn't think about it.

	Arnd

8<-----------
>From e07c95b1519c2103a9b42fd12e993440dafba9d6 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 Apr 2014 16:28:01 +0200
Subject: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where needed

Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
manually, either as loadable modules or built-in. This unfortunately
leads to a link error if one or both of them are built-in, while
the imx-pcm-dma framework is a loadable module:

sound/built-in.o: In function `fsl_ssi_probe':
:(.text+0x51fb8): undefined reference to `imx_pcm_dma_init'
sound/built-in.o: In function `fsl_spdif_probe':
:(.text+0x52e20): undefined reference to `imx_pcm_dma_init'

This changes Kconfig to prevent this case by ensuring the imx-pcm-dma
code is built-in if the i.MX SoC support is enabled and at least
one of the two drivers is built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index fb26345..5e0a58c 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -34,6 +34,7 @@ config SND_SOC_FSL_UTILS
 
 config SND_SOC_IMX_PCM_DMA
 	tristate
+	default y if SND_IMX_SOC!=n && (SND_SOC_FSL_SSI=y || SND_SOC_FSL_SPDIF=y)
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_IMX_AUDMUX
