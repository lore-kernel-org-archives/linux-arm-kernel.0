From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 24 Sep 2015 23:38:56 +0800
Subject: [PATCH v4 1/5] ARM: mediatek: enable gpt6 on boot up to make arch
 timer working
In-Reply-To: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1443109140-5406-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

We enable GTP6 which ungates the arch timer clock.
In the future this should be done in the bootloader.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm/mach-mediatek/mediatek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index a954900..19dc738 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -16,6 +16,32 @@
  */
 #include <linux/init.h>
 #include <asm/mach/arch.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+
+#define GPT6_CON_MT65xx 0x10008060
+#define GPT_ENABLE      0x31
+
+static void __init mediatek_timer_init(void)
+{
+	void __iomem *gpt_base;
+
+	if (of_machine_is_compatible("mediatek,mt6589") ||
+	    of_machine_is_compatible("mediatek,mt8135") ||
+	    of_machine_is_compatible("mediatek,mt8127")) {
+		/* turn on GPT6 which ungates arch timer clocks */
+		gpt_base = ioremap(GPT6_CON_MT65xx, 0x04);
+
+		/* enable clock and set to free-run */
+		writel(GPT_ENABLE, gpt_base);
+		iounmap(gpt_base);
+	}
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+};
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
@@ -27,4 +53,5 @@ static const char * const mediatek_board_dt_compat[] = {
 
 DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
 	.dt_compat	= mediatek_board_dt_compat,
+	.init_time	= mediatek_timer_init,
 MACHINE_END
-- 
1.9.1
