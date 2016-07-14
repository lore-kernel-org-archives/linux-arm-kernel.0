From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:30 +0200
Subject: [PATCH 2/7] ARM: nuc900: avoid ASoC header dependency
In-Reply-To: <20160714111135.2476095-1-arnd@arndb.de>
References: <20160714111135.2476095-1-arnd@arndb.de>
Message-ID: <20160714111135.2476095-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ac97 driver remains as one of the few places using w90x900/nuc900
mach/*.h header files for the purpose of pin configuration. We can
avoid that by passing a pointer to the one function it needs to call
as platform data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-w90x900/dev.c    | 1 +
 sound/soc/nuc900/nuc900-ac97.c | 6 ++++--
 sound/soc/nuc900/nuc900-pcm.c  | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index ea84f053bcd3..9c9292feb066 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -512,6 +512,7 @@ struct platform_device nuc900_device_ac97 = {
 	.dev              = {
 		.dma_mask               = &nuc900_device_audio_dmamask,
 		.coherent_dma_mask      = -1,
+		.platform_data		= mfp_set_groupg,
 	}
 };
 
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615affe571..04bb89f0b6a4 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -22,8 +22,6 @@
 #include <sound/soc.h>
 #include <linux/clk.h>
 
-#include <mach/mfp.h>
-
 #include "nuc900-audio.h"
 
 static DEFINE_MUTEX(ac97_mutex);
@@ -320,6 +318,8 @@ static const struct snd_soc_component_driver nuc900_ac97_component = {
 
 static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 {
+	void (*mfp_set_groupg)(struct device *dev, const char *subname);
+
 	struct nuc900_audio *nuc900_audio;
 	int ret;
 
@@ -362,6 +362,8 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	mfp_set_groupg = platform_get_drvdata(pdev);
+
 	/* enbale ac97 multifunction pin */
 	mfp_set_groupg(nuc900_audio->dev, NULL);
 
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 2cca055fd806..70883ec94f89 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -21,8 +21,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/hardware.h>
-
 #include "nuc900-audio.h"
 
 static const struct snd_pcm_hardware nuc900_pcm_hardware = {
-- 
2.9.0
