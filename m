From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 21 Oct 2014 12:54:23 +0400
Subject: [PATCH 1/2] ARM: pxa: spitz: register spitz-audio device
Message-ID: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register spitz-audio device to be used by ASoC driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 840c3a4..a9f971f 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -924,6 +924,23 @@ static inline void spitz_i2c_init(void) {}
 #endif
 
 /******************************************************************************
+ * Audio devices
+ ******************************************************************************/
+#if defined(CONFIG_SND_PXA2XX_SOC_SPITZ) || defined(SND_PXA2XX_SOC_SPITZ_MODULE)
+static struct platform_device spitz_audio_device = {
+	.name	= "spitz-audio",
+	.id	= -1,
+};
+
+static inline void spitz_audio_init(void)
+{
+	platform_device_register(&spitz_audio_device);
+}
+#else
+static inline void spitz_audio_init(void) {}
+#endif
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void spitz_poweroff(void)
@@ -970,6 +987,7 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	spitz_audio_init();
 }
 
 static void __init spitz_fixup(struct tag *tags, char **cmdline)
-- 
2.1.1
