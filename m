From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 May 2012 20:14:01 +0800
Subject: [PATCH 2/2] ARM: imx: add initial imx6dl-sabreai board support
Message-ID: <1337084041-19436-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial imx6dl-sabreai board support.  With uart, usdhc and
fec enabled, the board can boot into console with rootfs on nfs
or SD/MMC cards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    3 ++
 arch/arm/boot/dts/imx6dl-sabreai.dts          |   42 +++++++++++++++++++++++++
 arch/arm/mach-imx/Makefile.boot               |    1 +
 arch/arm/mach-imx/mach-imx6q.c                |    2 +
 4 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreai.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index ac9e751..066bb58 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -41,6 +41,9 @@ i.MX6 Quad SABRE Smart Device Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 
+i.MX6 DualLite SABRE Automotive Infotainment Board;
+    - compatible = "fsl,imx6dl-sabreai", "fsl,imx6dl";
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm/boot/dts/imx6dl-sabreai.dts b/arch/arm/boot/dts/imx6dl-sabreai.dts
new file mode 100644
index 0000000..3e0c1e3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreai.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx6dl.dtsi"
+
+/ {
+	model = "Freescale i.MX6 DualLite SABRE Automotive Infotainment Board";
+	compatible = "fsl,imx6dl-sabreai", "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	soc {
+		aips2: aips-bus at 02100000 {
+			ethernet at 02188000 {
+				phy-mode = "rgmii";
+				status = "okay";
+			};
+
+			usdhc3: usdhc at 02198000 {
+				cd-gpios = <&gpio6 15 0>;
+				wp-gpios = <&gpio1 13 0>;
+				status = "okay";
+			};
+
+			uart4: serial at 021f0000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 05541cf..c136c59 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -44,3 +44,4 @@ dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
 dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
 			   imx6q-sabrelite.dtb \
 			   imx6q-sabresd.dtb \
+			   imx6q-sabreai.dtb \
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index b47e98b..bb6c265 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -173,6 +173,8 @@ static struct sys_timer imx6q_timer = {
 };
 
 static const char *imx6q_dt_compat[] __initdata = {
+	"fsl,imx6dl-sabreai",
+	"fsl,imx6dl",
 	"fsl,imx6q-arm2",
 	"fsl,imx6q-sabrelite",
 	"fsl,imx6q-sabresd",
-- 
1.7.4.1
