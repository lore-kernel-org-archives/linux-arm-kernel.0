From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  8 Feb 2017 15:45:16 -0500
Subject: [PATCH 2/2] ARM: dts: BCM5301X: convert to iProc QSPI
In-Reply-To: <1486586716-6781-1-git-send-email-jon.mason@broadcom.com>
References: <1486586716-6781-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1486586716-6781-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iproc-qspi driver is the SPI driver that should be used going
forward.  Modify the SPI DT entry to use this driver, and add an entry
in the bcm953012k DTS file to enable the SPI.

Tested on the bcm953012k board.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi  | 50 +++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/bcm953012k.dts | 26 +++++++++++++++++++++
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index a4614c9..0acc02f 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -290,20 +290,6 @@
 			};
 		};
 
-		spi at 29000 {
-			reg = <0x00029000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			spi_nor: spi-nor at 0 {
-				compatible = "jedec,spi-nor";
-				reg = <0>;
-				spi-max-frequency = <20000000>;
-				linux,part-probe = "ofpart", "bcm47xxpart";
-				status = "disabled";
-			};
-		};
-
 		gmac0: ethernet at 24000 {
 			reg = <0x24000 0x800>;
 		};
@@ -367,4 +353,40 @@
 
 		brcm,nand-has-wp;
 	};
+
+	spi at 18029200 {
+		compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+		reg = <0x18029200 0x184>,
+		      <0x18029000 0x124>,
+		      <0x1811b408 0x004>,
+		      <0x180293a0 0x01c>;
+		reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "spi_lr_fullness_reached",
+				  "spi_lr_session_aborted",
+				  "spi_lr_impatient",
+				  "spi_lr_session_done",
+				  "spi_lr_overhead",
+				  "mspi_done",
+				  "mspi_halted";
+		clocks = <&iprocmed>;
+		clock-names = "iprocmed";
+		num-cs = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		spi_nor: spi-nor at 0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <20000000>;
+			linux,part-probe = "ofpart", "bcm47xxpart";
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index cb673c7..34a7f52 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -84,6 +84,32 @@
 	};
 };
 
+&spi_nor {
+	status = "okay";
+	spi-max-frequency = <62500000>;
+	m25p,default-addr-width = <3>;
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	partition at 0 {
+		label = "boot";
+		reg = <0x00000000 0x000d0000>;
+	};
+	partition at d000 {
+		label = "env";
+		reg = <0x000d0000 0x00030000>;
+	};
+	partition at 100000 {
+		label = "system";
+		reg = <0x00100000 0x00600000>;
+	};
+	partition at 700000 {
+		label = "rootfs";
+		reg = <0x00700000 0x00900000>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.7.4
