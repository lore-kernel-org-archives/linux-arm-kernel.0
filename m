From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 00:39:29 +0200
Subject: [PATCH 11/13] ARM: pxa: Pass GPIO offset to ucb1400-gpio on PalmTC
In-Reply-To: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1286663971-15634-11-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palmtc.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 2576e63..8fbd8e0 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -367,6 +367,14 @@ static inline void palmtc_udc_init(void) {}
  ******************************************************************************/
 #if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
 	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static struct ucb1400_pdata palmtc_ucb1400_pdata = {
+	.gpio_offset	= PALMTC_UCB1400_GPIO_OFFSET,
+};
+
+static pxa2xx_audio_ops_t palmtc_ac97_pdata = {
+	.codec_pdata	= { &palmtc_ucb1400_pdata, },
+};
+
 static struct platform_device palmtc_ucb1400_device = {
 	.name	= "ucb1400_core",
 	.id	= -1,
@@ -374,7 +382,7 @@ static struct platform_device palmtc_ucb1400_device = {
 
 static void __init palmtc_ts_init(void)
 {
-	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmtc_ac97_pdata);
 	platform_device_register(&palmtc_ucb1400_device);
 }
 #else
-- 
1.7.1
