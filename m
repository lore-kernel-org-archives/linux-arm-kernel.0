From: denis@eukrea.com (Denis Carikli)
Date: Wed, 26 Feb 2014 10:59:58 +0100
Subject: [PATCHv6][ 4/5] ARM: dts: i.MX35: Add display support.
In-Reply-To: <1393408800-8946-1-git-send-email-denis@eukrea.com>
References: <1393408800-8946-1-git-send-email-denis@eukrea.com>
Message-ID: <1393408800-8946-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A pinctrl node for the IPU was also added.

Cc: Eric B?nard <eric@eukrea.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- Shrinked the Cc list.

ChangeLog v4->v5:
- Added Grant Likely and Shawn Guo in the Cc list.
- Adapted to the new non-dma ipu bindings.
- Adapted to the use of imx35-pingrp.h
- The pinctrl ipu node addition was moved in this commit.

ChangeLog v3->v4:
- Splitted the imx35.dtsi display support (new patch).
---
 arch/arm/boot/dts/imx35.dtsi |    7 +++++++
 arch/arm/mach-imx/imx35-dt.c |    7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 88b218f..e6ad2a4 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -229,6 +229,13 @@
 				status = "disabled";
 			};
 
+			ipu: ipu at 53fc0000 {
+				compatible = "fsl,imx35-ipu";
+				reg = <0x53fc0000 0x4000>;
+				clocks = <&clks 55>;
+				status = "disabled";
+			};
+
 			audmux: audmux at 53fc4000 {
 				compatible = "fsl,imx35-audmux", "fsl,imx31-audmux";
 				reg = <0x53fc4000 0x4000>;
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index 9d48e00..c2919a8 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -18,14 +18,21 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "common.h"
+#include "devices-imx35.h"
 #include "mx35.h"
 
 static void __init imx35_dt_init(void)
 {
+	struct device_node *np;
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     NULL, NULL);
+
+	/* We don't want to export the IPU as DT bindings. */
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-ipu");
+	if (of_device_is_available(np))
+		imx35_add_ipu_core();
 }
 
 static void __init imx35_irq_init(void)
-- 
1.7.9.5
