From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 10 Feb 2016 11:40:51 +0530
Subject: [PATCH 6/6] arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2
In-Reply-To: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
References: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1455084651-29325-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ray Jui <rjui@broadcom.com>

This patch enables PCIe0 and PCIe4 for NS2 by adding
appropriate DT nodes in NS2 DT.

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts |  8 ++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 74 ++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 3321bd1..ce0ab84 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -52,6 +52,14 @@
 	};
 };
 
+&pcie0 {
+	status = "ok";
+};
+
+&pcie4 {
+	status = "ok";
+};
+
 &i2c0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 062616b4..6f81c9d 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -137,6 +137,80 @@
 		};
 	};
 
+	pcie0: pcie at 20020000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0 0x20020000 0 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 281 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <0>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x83000000 0 0x00000000 0 0x00000000 0 0x20000000>;
+
+		brcm,pcie-ob;
+		brcm,pcie-ob-oarr-size;
+		brcm,pcie-ob-axi-offset = <0x00000000>;
+		brcm,pcie-ob-window-size = <256>;
+
+		status = "disabled";
+
+		msi-parent = <&msi0>;
+		msi0: msi at 20020000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_NONE>,
+				     <GIC_SPI 278 IRQ_TYPE_NONE>,
+				     <GIC_SPI 279 IRQ_TYPE_NONE>,
+				     <GIC_SPI 280 IRQ_TYPE_NONE>;
+			brcm,num-eq-region = <1>;
+			brcm,num-msi-msg-region = <1>;
+		};
+	};
+
+	pcie4: pcie at 50020000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0 0x50020000 0 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 305 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <4>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x83000000 0 0x00000000 0 0x30000000 0 0x20000000>;
+
+		brcm,pcie-ob;
+		brcm,pcie-ob-oarr-size;
+		brcm,pcie-ob-axi-offset = <0x30000000>;
+		brcm,pcie-ob-window-size = <256>;
+
+		status = "disabled";
+
+		msi-parent = <&msi4>;
+		msi4: msi at 50020000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 301 IRQ_TYPE_NONE>,
+				     <GIC_SPI 302 IRQ_TYPE_NONE>,
+				     <GIC_SPI 303 IRQ_TYPE_NONE>,
+				     <GIC_SPI 304 IRQ_TYPE_NONE>;
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
