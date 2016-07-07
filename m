From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri,  8 Jul 2016 01:46:41 +0300
Subject: [PATCH] ARM: dts: lpc32xx: add device node for IRAM on-chip memory
Message-ID: <1467931601-25067-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a new device node with description of generic SRAM
on-chip memory found on NXP LPC32xx SoC series and connected to AHB
matrix slave port 3.

Note that NXP LPC3220 SoC has 128KiB of SRAM memory, the other
LPC3230, LPC3240 and LPC3250 SoCs all have 256KiB SRAM space,
in the shared DTSI file this change specifies 128KiB SRAM size.

Also it's worth to mention that the SRAM area contains of 64KiB banks,
2 banks on LPC3220 and 4 banks on the other SoCs from the series, and
all SRAM banks but the first one have independent power controls,
the description of this feature will be added with the introduction of
power domains for the SoC series.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
---

Hi Arnd, Olof, Kevin,

please consider to include this NXP LPC32xx DT change directly to
ARM tree for v4.8.

The SRAM device node will be utilized to store PM resume code
and to store MAC buffers.

 arch/arm/boot/dts/lpc32xx.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index e295e1e..b5841fa 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -51,9 +51,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0x20000000 0x20000000 0x30000000>,
+		ranges = <0x00000000 0x00000000 0x10000000>,
+			 <0x20000000 0x20000000 0x30000000>,
 			 <0xe0000000 0xe0000000 0x04000000>;
 
+		iram: sram at 08000000 {
+			compatible = "mmio-sram";
+			reg = <0x08000000 0x20000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x08000000 0x20000>;
+		};
+
 		/*
 		 * Enable either SLC or MLC
 		 */
-- 
2.8.0.rc3
