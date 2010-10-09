From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 00:39:28 +0200
Subject: [PATCH 10/13] ARM: pxa: Correct touch IRQ passing to UCB1400 on
	vpac270
In-Reply-To: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1286663971-15634-10-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/vpac270.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 07c35eb..6278578 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -430,20 +430,18 @@ static inline void vpac270_eth_init(void) {}
  ******************************************************************************/
 #if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
 	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
-static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
-	.reset_gpio	= 95,
-};
-
 static struct ucb1400_pdata vpac270_ucb1400_pdata = {
 	.irq		= IRQ_GPIO(GPIO113_VPAC270_TS_IRQ),
 };
 
+static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
+	.reset_gpio	= 95,
+	.codec_pdata	= { &vpac270_ucb1400_pdata, },
+};
+
 static struct platform_device vpac270_ucb1400_device = {
 	.name		= "ucb1400_core",
 	.id		= -1,
-	.dev		= {
-		.platform_data = &vpac270_ucb1400_pdata,
-	},
 };
 
 static void __init vpac270_ts_init(void)
-- 
1.7.1
