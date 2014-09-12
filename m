From: b38343@freescale.com (Robin Gong)
Date: Fri, 12 Sep 2014 16:48:57 +0800
Subject: [PATCH v2 1/3] ARM: dts: imx6: add pm_power_off support for i.mx6
 chips
In-Reply-To: <1410511739-31122-1-git-send-email-b38343@freescale.com>
References: <1410511739-31122-1-git-send-email-b38343@freescale.com>
Message-ID: <1410511739-31122-2-git-send-email-b38343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All chips of i.mx6 can be powered off by programming SNVS.
For example :
On i.mx6q-sabresd board, PMIC_ON_REQ connect with external
pmic ON/OFF pin, that will cause the whole PMIC powered off
except VSNVS. And system can restart once PMIC_ON_REQ goes
high by push POWRER key.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 .../bindings/power_supply/imx-snvs-poweroff.txt     | 21 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi                      |  5 +++++
 arch/arm/boot/dts/imx6sl.dtsi                       |  5 +++++
 arch/arm/boot/dts/imx6sx.dtsi                       |  5 +++++
 4 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt b/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
new file mode 100644
index 0000000..1a3ab9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
@@ -0,0 +1,21 @@
+i.mx6 Poweroff Driver
+
+SNVS_LPCR in SNVS module can power off the whole system by pull
+PMIC_ON_REQ low.
+
+Required Properties:
+-compatible: "fsl,sec-v4.0-poweroff"
+-reg: Specifies the physical address of the SNVS_LPCR register
+
+Example:
+	snvs at 020cc000 {
+		compatible = "fsl,sec-v4.0-mon", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x020cc000 0x4000>;
+		.....
+		snvs-poweroff at 38 {
+			compatible = "fsl,sec-v4.0-poweroff";
+			reg = <0x38 0x4>;
+		};
+	}
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70d7207..d2d7563 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -650,6 +650,11 @@
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				snvs-poweroff at 38 {
+					compatible = "fsl,sec-v4.0-poweroff";
+					reg = <0x38 0x4>;
+				};
 			};
 
 			epit1: epit at 020d0000 { /* EPIT1 */
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ba67714..6e1d8f6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -568,6 +568,11 @@
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				snvs-poweroff at 38 {
+					compatible = "fsl,sec-v4.0-poweroff";
+					reg = <0x38 0x4>;
+				};
 			};
 
 			epit1: epit at 020d0000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index d137caca..c1f937e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -671,6 +671,11 @@
 					reg = <0x34 0x58>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				snvs-poweroff at 38 {
+					compatible = "fsl,sec-v4.0-poweroff";
+					reg = <0x38 0x4>;
+				};
 			};
 
 			epit1: epit at 020d0000 {
-- 
1.9.1
