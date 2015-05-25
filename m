From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 26 May 2015 00:04:19 +0200
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in snd-soc-atmel_ssc_dai
In-Reply-To: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is currently possible to have CONFIG_SND_ATMEL_SOC_SSC=y with either
CONFIG_SND_ATMEL_SOC_PDC=m or CONFIG_SND_ATMEL_SOC_DMA=m. This results in a
driver that compiles but does not link with this kind of error:

sound/built-in.o: In function `atmel_ssc_set_audio':
(.text+0x87d90): undefined reference to `atmel_pcm_pdc_platform_register'
sound/built-in.o: In function `atmel_ssc_put_audio':
(.text+0x8879a): undefined reference to `atmel_pcm_pdc_platform_unregister'

Solve that by compiling the selected PCM driver (PDC, DMA or both) in the
Atmel SSC DAI driver.

Reported-by: Randy Dunlap <rdunlap@infradead.org>

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/Kconfig  | 4 ++--
 sound/soc/atmel/Makefile | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 93abe4e6d596..c3152072d682 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -9,10 +9,10 @@ config SND_ATMEL_SOC
 if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
-	tristate
+	bool
 
 config SND_ATMEL_SOC_DMA
-	tristate
+	bool
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_ATMEL_SOC_SSC
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index b327e5cc8de3..4fa7ac91f972 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -1,10 +1,8 @@
 # AT91 Platform Support
-snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
-snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
-snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
+snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)
 
-obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
-obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
 obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
 
 # AT91 Machine Support
-- 
2.1.4
