From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 26 Mar 2010 04:45:54 +0100
Subject: [PATCH] VPAC270: Add touchscreen support
Message-ID: <1269575154-1651-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the UCB1400 touchscreen found in the VPAC270 device.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/vpac270.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 56cc245..fa428ca 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -22,11 +22,13 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/dm9000.h>
+#include <linux/ucb1400.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
 #include <mach/pxa27x.h>
+#include <mach/audio.h>
 #include <mach/vpac270.h>
 #include <mach/mmc.h>
 #include <mach/pxafb.h>
@@ -121,6 +123,15 @@ static unsigned long vpac270_pin_config[] __initdata = {
 
 	/* Ethernet */
 	GPIO114_GPIO,	/* IRQ */
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+	GPIO95_AC97_nRESET,
+	GPIO98_AC97_SYSCLK,
+	GPIO113_GPIO,	/* TS IRQ */
 };
 
 /******************************************************************************
@@ -357,6 +368,36 @@ static inline void vpac270_eth_init(void) {}
 #endif
 
 /******************************************************************************
+ * Audio and Touchscreen
+ ******************************************************************************/
+#if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
+	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
+	.reset_gpio	= 95,
+};
+
+static struct ucb1400_pdata vpac270_ucb1400_pdata = {
+	.irq		= IRQ_GPIO(113),
+};
+
+static struct platform_device vpac270_ucb1400_device = {
+	.name		= "ucb1400_core",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &vpac270_ucb1400_pdata,
+	},
+};
+
+static void __init vpac270_ts_init(void)
+{
+	pxa_set_ac97_info(&vpac270_ac97_pdata);
+	platform_device_register(&vpac270_ucb1400_device);
+}
+#else
+static inline void vpac270_ts_init(void) {}
+#endif
+
+/******************************************************************************
  * Framebuffer
  ******************************************************************************/
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
@@ -439,6 +480,7 @@ static void __init vpac270_init(void)
 	vpac270_uhc_init();
 	vpac270_udc_init();
 	vpac270_eth_init();
+	vpac270_ts_init();
 }
 
 MACHINE_START(VPAC270, "Voipac PXA270")
-- 
1.7.0
