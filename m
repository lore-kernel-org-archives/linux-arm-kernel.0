From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 18 Aug 2014 16:58:34 +0200
Subject: [PATCH v2 6/9] arm: mediatek: enable gpt6 on boot up to make arch
 timer working
In-Reply-To: <1408373917-10002-1-git-send-email-matthias.bgg@gmail.com>
References: <1408373917-10002-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1408373917-10002-7-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enable GTP6 which ungates the arch timer clock. Apart we write the
frequency with which the timer is running in the CNTFREQ register.
In the future this should be done in the bootloader.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/mach-mediatek/mediatek.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index f2acf07..2989f18 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -16,6 +16,31 @@
  */
 #include <linux/init.h>
 #include <asm/mach/arch.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+#define TIMER_CTRL_OP_FREERUN	0x30
+#define TIMER_CTRL_ENABLE	0x01
+
+#define GPT6_CON_MT65xx 0x10008060
+
+static void __init mediatek_timer_init(void)
+{
+	static void __iomem *gpt_base;
+
+	if (of_machine_is_compatible("mediatek,mt6589")) {
+		/* turn on GPT6 which ungates arch timer clocks */
+		gpt_base = ioremap(GPT6_CON_MT65xx, 0x04);
+	}
+
+	/* enabel clock and set to free-run */
+	if (gpt_base)
+		writel(TIMER_CTRL_OP_FREERUN | TIMER_CTRL_ENABLE, gpt_base);
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+};
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
@@ -24,4 +49,5 @@ static const char * const mediatek_board_dt_compat[] = {
 
 DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
 	.dt_compat	= mediatek_board_dt_compat,
+	.init_time	= mediatek_timer_init,
 MACHINE_END
-- 
1.7.9.5
