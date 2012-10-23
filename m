From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:50 +0800
Subject: [PATCH 01/10] ARM: imx6q: print silicon version on boot
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6Q has 3 revisions 1.0, 1.1 and 1.2.  Print revision on boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 978b6dd..1c5acf8 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -38,6 +38,33 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
+#define IMX6Q_ANALOG_DIGPROG	0x260
+
+static int imx6q_revision(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+	static u32 rev;
+
+	if (!rev) {
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+		base = of_iomap(np, 0);
+		rev =  readl_relaxed(base + IMX6Q_ANALOG_DIGPROG);
+		iounmap(base);
+	}
+
+	switch (rev & 0xff) {
+	case 0:
+		return IMX_CHIP_REVISION_1_0;
+	case 1:
+		return IMX_CHIP_REVISION_1_1;
+	case 2:
+		return IMX_CHIP_REVISION_1_2;
+	default:
+		return IMX_CHIP_REVISION_UNKNOWN;
+	}
+}
+
 void imx6q_restart(char mode, const char *cmd)
 {
 	struct device_node *np;
@@ -192,6 +219,7 @@ static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
 	twd_local_timer_of_register();
+	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
 }
 
 static struct sys_timer imx6q_timer = {
-- 
1.7.9.5
