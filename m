From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:43 +0800
Subject: [PATCH 07/13] ARM: mxs: get ocotp base address from device tree
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the static definitions, get ocotp base address from
device tree with mapping.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    1 +
 arch/arm/mach-mxs/ocotp.c    |    9 ++++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 30b410b..ad2d793 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -322,6 +322,7 @@
 			};
 
 			ocotp at 8002c000 {
+				compatible = "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 56d84bf..64af238 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -677,6 +677,7 @@
 			};
 
 			ocotp at 8002c000 {
+				compatible = "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
 				status = "disabled";
 			};
diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
index 1dff467..c2002eb 100644
--- a/arch/arm/mach-mxs/ocotp.c
+++ b/arch/arm/mach-mxs/ocotp.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/processor.h>	/* for cpu_relax() */
 
@@ -33,7 +35,8 @@ static u32 ocotp_words[OCOTP_WORD_COUNT];
 
 const u32 *mxs_get_ocotp(void)
 {
-	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
+	struct device_node *np;
+	void __iomem *ocotp_base;
 	int timeout = 0x400;
 	size_t i;
 	static int once = 0;
@@ -41,6 +44,10 @@ const u32 *mxs_get_ocotp(void)
 	if (once)
 		return ocotp_words;
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,ocotp");
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
 	mutex_lock(&ocotp_mutex);
 
 	/*
-- 
1.7.9.5
