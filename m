From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 12:02:41 +0800
Subject: [PATCH v4 3/9] arm: dts: mt7623: add mt7623-mt6323.dtsi file
In-Reply-To: <cover.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
Message-ID: <2c770301279b10b78382b53529a6b83a6d847e32.1495683769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

MediaTek produces various PMICs. Which one is used depends on the actual
circuit design. Instead of adding the correct PMIC node to every dts file
we instead add a new intermediate dtsi file which adds the PMIC node.
Additionally we also add the phandles for the regulators to various nodes.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623-evb.dts     |   2 +-
 arch/arm/boot/dts/mt7623-mt6323.dtsi | 269 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623.dtsi        |   8 +-
 3 files changed, 274 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623-mt6323.dtsi

diff --git a/arch/arm/boot/dts/mt7623-evb.dts b/arch/arm/boot/dts/mt7623-evb.dts
index b60b41c..a769149 100644
--- a/arch/arm/boot/dts/mt7623-evb.dts
+++ b/arch/arm/boot/dts/mt7623-evb.dts
@@ -13,7 +13,7 @@
  */
 
 /dts-v1/;
-#include "mt7623.dtsi"
+#include "mt7623-mt6323.dtsi"
 
 / {
 	model = "MediaTek MT7623 evaluation board";
diff --git a/arch/arm/boot/dts/mt7623-mt6323.dtsi b/arch/arm/boot/dts/mt7623-mt6323.dtsi
new file mode 100644
index 0000000..93d3f71
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623-mt6323.dtsi
@@ -0,0 +1,269 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: John Crispin <john@phrozen.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "mt7623.dtsi"
+
+&cpu0 {
+	proc-supply = <&mt6323_vproc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6323_vproc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6323_vproc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6323_vproc_reg>;
+};
+
+&pwrap {
+	pmic: mt6323 {
+		compatible = "mediatek,mt6323";
+		interrupt-parent = <&pio>;
+		interrupts = <150 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mt6323regulator: mt6323regulator{
+			compatible = "mediatek,mt6323-regulator";
+
+			mt6323_vproc_reg: buck_vproc{
+				regulator-name = "vproc";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vsys_reg: buck_vsys{
+				regulator-name = "vsys";
+				regulator-min-microvolt = <1400000>;
+				regulator-max-microvolt = <2987500>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vpa_reg: buck_vpa{
+				regulator-name = "vpa";
+				regulator-min-microvolt = < 500000>;
+				regulator-max-microvolt = <3650000>;
+			};
+
+			mt6323_vtcxo_reg: ldo_vtcxo{
+				regulator-name = "vtcxo";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <90>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcn28_reg: ldo_vcn28{
+				regulator-name = "vcn28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_vcn33_bt_reg: ldo_vcn33_bt{
+				regulator-name = "vcn33_bt";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_vcn33_wifi_reg: ldo_vcn33_wifi{
+				regulator-name = "vcn33_wifi";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_va_reg: ldo_va{
+				regulator-name = "va";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcama_reg: ldo_vcama{
+				regulator-name = "vcama";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vio28_reg: ldo_vio28{
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vusb_reg: ldo_vusb{
+				regulator-name = "vusb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-boot-on;
+			};
+
+			mt6323_vmc_reg: ldo_vmc{
+				regulator-name = "vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vmch_reg: ldo_vmch{
+				regulator-name = "vmch";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vemc3v3_reg: ldo_vemc3v3{
+				regulator-name = "vemc3v3";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vgp1_reg: ldo_vgp1{
+				regulator-name = "vgp1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vgp2_reg: ldo_vgp2{
+				regulator-name = "vgp2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vgp3_reg: ldo_vgp3{
+				regulator-name = "vgp3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vcn18_reg: ldo_vcn18{
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vsim1_reg: ldo_vsim1{
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vsim2_reg: ldo_vsim2{
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vrtc_reg: ldo_vrtc{
+				regulator-name = "vrtc";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcamaf_reg: ldo_vcamaf{
+				regulator-name = "vcamaf";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vibr_reg: ldo_vibr{
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+			};
+
+			mt6323_vrf18_reg: ldo_vrf18{
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1825000>;
+				regulator-max-microvolt = <1825000>;
+				regulator-enable-ramp-delay = <187>;
+			};
+
+			mt6323_vm_reg: ldo_vm{
+				regulator-name = "vm";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vio18_reg: ldo_vio18{
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcamd_reg: ldo_vcamd{
+				regulator-name = "vcamd";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vcamio_reg: ldo_vcamio{
+				regulator-name = "vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+		};
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&mt6323_vemc3v3_reg>;
+	vqmmc-supply = <&mt6323_vio18_reg>;
+};
+
+&mmc1 {
+	vmmc-supply = <&mt6323_vmch_reg>;
+	vqmmc-supply = <&mt6323_vmc_reg>;
+};
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index d81158b2..e9e0974 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -32,22 +32,22 @@
 		#size-cells = <0>;
 		enable-method = "mediatek,mt6589-smp";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
 		};
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
 		};
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
-- 
2.7.4
