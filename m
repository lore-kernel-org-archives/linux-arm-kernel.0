From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Aug 2018 10:54:20 -0700
Subject: [PATCH v2 3/3] ARM: dts: NSP: Wire up switch interrupts
In-Reply-To: <20180828175420.7992-1-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
Message-ID: <20180828175420.7992-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Switch Register Access Block (SRAB) has one interrupt for link state
change on each ports (0-5, 7-8) a PHY interrupt, timestamping interrupt
and sleep timer interrupts for each management ports (5,7,8). Wire those
up so we can utilize them to speed up link resolution.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 09ba85046322..ec869a80f9ba 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -377,7 +377,36 @@
 
 		srab: srab at 36000 {
 			compatible = "brcm,nsp-srab";
-			reg = <0x36000 0x1000>;
+			reg = <0x36000 0x1000>,
+			      <0x3f308 0x8>,
+			      <0x3f410 0xc>;
+			reg-names = "srab", "mux_config", "sgmii";
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "link_state_p0",
+					  "link_state_p1",
+					  "link_state_p2",
+					  "link_state_p3",
+					  "link_state_p4",
+					  "link_state_p5",
+					  "link_state_p7",
+					  "link_state_p8",
+					  "phy",
+					  "ts",
+					  "imp_sleep_timer_p5",
+					  "imp_sleep_timer_p7",
+					  "imp_sleep_timer_p8";
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.17.1
