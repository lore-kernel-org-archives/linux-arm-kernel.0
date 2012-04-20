From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 20 Apr 2012 14:10:38 -0300
Subject: [PATCH v2] ARM: dts: Add basic support for imx6q-sabresd
Message-ID: <1334941838-18470-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for imx6q-sabresd.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:

- Added entry into Documentation
- Added entry in arch/arm/mach-imx/Makefile.boot
- Fixed ethernet
- Dropped SDHC for now

 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
 arch/arm/boot/dts/imx6q-sabresd.dts           |   41 +++++++++++++++++++++++++
 arch/arm/mach-imx/Makefile.boot               |    3 +-
 arch/arm/mach-imx/mach-imx6q.c                |    1 +
 4 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabresd.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index fecb580..0fc2da7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -33,6 +33,10 @@ i.MX6 Quad SABRE Lite Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
 
+i.MX6 Quad SABRE Smart Device Board
+Required root node properties:
+    - compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
new file mode 100644
index 0000000..368d2d7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
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
+/include/ "imx6q.dtsi"
+
+/ {
+	model = "Freescale i.MX6Q SABRE Smart Device Board";
+	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	soc {
+
+		aips-bus at 02000000 { /* AIPS1 */
+			spba-bus at 02000000 {
+				uart1: uart at 02020000 {
+				status = "okay";
+				};
+			};
+		};
+
+		aips-bus at 02100000 { /* AIPS2 */
+			enet at 02188000 {
+				phy-mode = "rgmii";
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 3851d8a..64eb671 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -42,4 +42,5 @@ dtb-$(CONFIG_MACH_IMX51_DT) += imx51-babbage.dtb
 dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
 			       imx53-qsb.dtb imx53-smd.dtb
 dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
-			   imx6q-sabrelite.dtb
+			   imx6q-sabrelite.dtb \
+			   imx6q-sabresd.dtb \
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index da6c1d9..512c18d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -132,6 +132,7 @@ static struct sys_timer imx6q_timer = {
 static const char *imx6q_dt_compat[] __initdata = {
 	"fsl,imx6q-arm2",
 	"fsl,imx6q-sabrelite",
+	"fsl,imx6q-sabresd",
 	"fsl,imx6q",
 	NULL,
 };
-- 
1.7.1
