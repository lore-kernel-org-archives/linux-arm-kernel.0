From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 23 May 2013 16:36:38 -0500
Subject: [PATCHv3 2/6] ARM: socfpga: dts: Add gate-clock bindings
In-Reply-To: <1369345002-20002-1-git-send-email-dinguyen@altera.com>
References: <1369345002-20002-1-git-send-email-dinguyen@altera.com>
Message-ID: <1369345002-20002-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for "socfpga-gate-clk" clocks. These clocks directly feed
the peripherals.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
CC: <linux@arm.linux.org.uk>
---
 .../devicetree/bindings/clock/altr_socfpga.txt     |    7 +
 arch/arm/boot/dts/socfpga.dtsi                     |  199 ++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index bd0c841..0045433 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -9,6 +9,9 @@ Required properties:
 	"altr,socfpga-pll-clock" - for a PLL clock
 	"altr,socfpga-perip-clock" - The peripheral clock divided from the
 		PLL clock.
+	"altr,socfpga-gate-clk" - Clocks that directly feed peripherals and
+		can get gated.
+
 - reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
 - clocks : shall be the input parent clock phandle for the clock. This is
 	either an oscillator or a pll output.
@@ -16,3 +19,7 @@ Required properties:
 
 Optional properties:
 - fixed-divider : If clocks have a fixed divider value, use this property.
+- clk-gate : For "socfpga-gate-clk", clk-gate contains the gating register
+        and the bit index.
+- div-reg : For "socfpga-gate-clk", div-reg contains the divider register, bit shift,
+        and width.
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 02bb425..bee62a2 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -95,6 +95,12 @@
 						compatible = "fixed-clock";
 					};
 
+					f2s_periph_ref_clk: f2s_periph_ref_clk {
+						#clock-cells = <0>;
+						compatible = "fixed-clock";
+						clock-frequency = <10000000>;
+					};
+
 					main_pll: main_pll {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -236,6 +242,199 @@
 							reg = <0xD4>;
 						};
 					};
+
+				mpu_periph_clk: mpu_periph_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mpuclk>;
+					fixed-divider = <4>;
+					};
+
+				mpu_l2_ram_clk: mpu_l2_ram_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mpuclk>;
+					fixed-divider = <2>;
+					};
+
+				l4_main_clk: l4_main_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>;
+					clk-gate = <0x60 0>;
+					};
+
+				l3_main_clk: l3_main_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>;
+					};
+
+				l3_mp_clk: l3_mp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>;
+					div-reg = <0x64 0 2>;
+					clk-gate = <0x60 1>;
+					};
+
+				l3_sp_clk: l3_sp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>;
+					div-reg = <0x64 2 2>;
+				};
+
+				l4_mp_clk: l4_mp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>, <&per_base_clk>;
+					div-reg = <0x64 4 3>;
+					clk-gate = <0x60 2>;
+					};
+
+				l4_sp_clk: l4_sp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&mainclk>, <&per_base_clk>;
+					div-reg = <0x64 7 3>;
+					clk-gate = <0x60 3>;
+					};
+
+				dbg_at_clk: dbg_at_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&dbg_base_clk>;
+					div-reg = <0x68 0 2>;
+					clk-gate = <0x60 4>;
+					};
+
+				dbg_clk: dbg_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&dbg_base_clk>;
+					div-reg = <0x68 2 2>;
+					clk-gate = <0x60 5>;
+					};
+
+				dbg_trace_clk: dbg_trace_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&dbg_base_clk>;
+					div-reg = <0x6C 0 3>;
+					clk-gate = <0x60 6>;
+					};
+
+				dbg_timer_clk: dbg_timer_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&dbg_base_clk>;
+					clk-gate = <0x60 7>;
+					};
+
+				cfg_clk: cfg_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&cfg_s2f_usr0_clk>;
+					clk-gate = <0x60 8>;
+					};
+
+				s2f_user0_clk: s2f_user0_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&cfg_s2f_usr0_clk>;
+					clk-gate = <0x60 9>;
+					};
+
+				emac_0_clk: emac_0_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&emac0_clk>;
+					clk-gate = <0xa0 0>;
+					};
+
+				emac_1_clk: emac_1_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&emac1_clk>;
+					clk-gate = <0xa0 1>;
+					};
+
+				usb_mp_clk: usb_mp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&per_base_clk>;
+					clk-gate = <0xa0 2>;
+					div-reg = <0xa4 0 3>;
+					};
+
+				spi_m_clk: spi_m_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&per_base_clk>;
+					clk-gate = <0xa0 3>;
+					div-reg = <0xa4 3 3>;
+					};
+
+				can0_clk: can0_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&per_base_clk>;
+					clk-gate = <0xa0 4>;
+					div-reg = <0xa4 6 3>;
+					};
+
+				can1_clk: can1_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&per_base_clk>;
+					clk-gate = <0xa0 5>;
+					div-reg = <0xa4 9 3>;
+					};
+
+				gpio_db_clk: gpio_db_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&per_base_clk>;
+					clk-gate = <0xa0 6>;
+					div-reg = <0xa8 0 24>;
+					};
+
+				s2f_user1_clk: s2f_user1_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&s2f_usr1_clk>;
+					clk-gate = <0xa0 7>;
+					};
+
+				sdmmc_clk: sdmmc_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+					clk-gate = <0xa0 8>;
+					};
+
+				nand_x_clk: nand_x_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+					clk-gate = <0xa0 9>;
+					};
+
+				nand_clk: nand_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+					clk-gate = <0xa0 10>;
+					fixed-divider = <4>;
+					};
+
+				qspi_clk: qspi_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-gate-clk";
+					clocks = <&f2s_periph_ref_clk>, <&main_qspi_clk>, <&per_qspi_clk>;
+					clk-gate = <0xa0 11>;
+					};
 				};
 			};
 
-- 
1.7.9.5
