From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  7 Jul 2017 14:03:18 -0500
Subject: [PATCHv1 3/4] arm64: dts: add complete clock tree for SoCFPGA
 Stratix10
In-Reply-To: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
References: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1499454199-31901-3-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the complete clock tree for SoCFPGA Stratix10 chip. The clocking on
Stratix10 is similar to the SoCFPGA Arria10/Cyclone5 platforms, so reuse
the same kind of clock structure as the previous platforms.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 461 +++++++++++++++++++++-
 1 file changed, 460 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index a0aa26e..1b035ed 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -89,9 +89,468 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
-		clkmgr at ffd1000 {
+		clkmgr at ffd10000 {
 			compatible = "altr,clk-mgr";
 			reg = <0xffd10000 0x1000>;
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+				};
+
+				cb_intosc_ls_clk: cb_intosc_ls_clk {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+				};
+
+				f2s_free_clk: f2s_free_clk {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+				};
+
+				osc1: osc1 {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+				};
+
+				main_pll: main_pll at 44 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-pll-clock";
+					clocks = <&osc1>, <&cb_intosc_hs_div2_clk>,
+						 <&f2s_free_clk>;
+					reg = <0x74>;
+
+					main_mpu_base_clk: main_mpu_base_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						div-reg = <0x84 0 8>;
+					};
+
+					main_noc_base_clk: main_noc_base_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						div-reg = <0x88 0 8>;
+					};
+
+					main_emaca_clk: main_emaca_clk at 68 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x50>;
+					};
+
+					main_emacb_clk: main_emacb_clk at 6c {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x54>;
+					};
+
+					main_emac_ptp_clk: main_emac_ptp_clk at 70 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x58>;
+					};
+
+					main_gpio_db_clk: main_gpio_db_clk at 74 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x5c>;
+					};
+
+					main_sdmmc_clk: main_sdmmc_clk at 78 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk"
+;
+						clocks = <&main_pll>;
+						reg = <0x60>;
+					};
+
+					main_s2f_usr0_clk: main_s2f_usr0_clk at 7c {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x64>;
+					};
+
+					main_s2f_usr1_clk: main_s2f_usr1_clk at 80 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x68>;
+					};
+
+					main_psi_ref_clk: main_psi_ref_clk at 84 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>;
+						reg = <0x6c>;
+					};
+				};
+
+				periph_pll: periph_pll at e4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-pll-clock";
+					clocks = <&osc1>, <&cb_intosc_hs_div2_clk>,
+						 <&f2s_free_clk>;
+					reg = <0xe4>;
+
+					peri_mpu_base_clk: peri_mpu_base_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&periph_pll>;
+						reg = <0xf4 0 8>;
+					};
+
+					peri_noc_base_clk: peri_noc_base_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&periph_pll>;
+						reg = <0xf8 0 8>;
+					};
+
+					peri_emaca_clk: peri_emaca_clk at e8 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xbc>;
+					};
+
+					peri_emacb_clk: peri_emacb_clk at ec {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xc0>;
+					};
+
+					peri_emac_ptp_clk: peri_emac_ptp_clk at f0 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xc4>;
+					};
+
+					peri_gpio_db_clk: peri_gpio_db_clk at f4 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xc8>;
+					};
+
+					peri_sdmmc_clk: peri_sdmmc_clk at f8 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xcc>;
+					};
+
+					peri_s2f_usr0_clk: peri_s2f_usr0_clk at fc {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&periph_pll>;
+						reg = <0xd0>;
+					};
+
+					peri_s2f_usr1_clk: peri_s2f_usr1_clk at 100 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xd4>;
+					};
+
+					peri_psi_ref_clk: peri_psi_ref_clk at 104 {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-s10-perip-clk";
+						clocks = <&main_pll>, <&periph_pll>,
+							 <&osc1>, <&cb_intosc_hs_div2_clk>,							    <&f2s_free_clk>;
+						reg = <0xd8>;
+					};
+				};
+
+				boot_clk: boot_clk at 0 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&osc1>, <&cb_intosc_hs_div2_clk>;
+					reg = <0x0>;
+				};
+
+				mpu_free_clk: mpu_free_clk at 48 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&main_mpu_base_clk>, <&peri_mpu_base_clk>,
+						 <&osc1>, <&cb_intosc_hs_div2_clk>,
+						 <&f2s_free_clk>;
+					reg = <0x48>;
+				};
+
+				noc_free_clk: noc_free_clk at 4c {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&main_noc_base_clk>, <&peri_noc_base_clk>,
+						 <&osc1>, <&cb_intosc_hs_div2_clk>,
+						 <&f2s_free_clk>;
+					reg = <0x4c>;
+				};
+
+				s2f_user0_free_clk: s2f_user0_free_clk at 104 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&main_s2f_usr0_clk>, <&peri_s2f_usr0_clk>,
+						 <&osc1>, <&cb_intosc_hs_div2_clk>,
+						 <&f2s_free_clk>;
+					reg = <0x64>;
+				};
+
+				l4_sys_free_clk: l4_sys_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&noc_free_clk>;
+					fixed-divider = <4>;
+				};
+
+				noc_clk: noc_clk at 30 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&noc_free_clk>;
+					bypass-reg = <0x3c 1>;
+				};
+
+				emaca_free_clk: emaca_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&main_emaca_clk>;
+					bypass-reg = <0xb0 0>;
+				};
+
+				emacb_free_clk: emacb_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&main_emacb_clk>;
+					bypass-reg = <0xb0 1>;
+				};
+
+				emac_ptp_free_clk: emac_ptp_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&peri_emac_ptp_clk>;
+					bypass-reg = <0xb0 2>;
+				};
+
+				gpio_db_free_clk: gpio_db_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&peri_gpio_db_clk>;
+					bypass-reg = <0xb0 3>;
+				};
+
+				sdmmc_free_clk: sdmmc_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&peri_sdmmc_clk>;
+					bypass-reg = <0xb0 4>;
+				};
+
+				s2f_user1_free_clk: s2f_user1_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&peri_s2f_usr1_clk>;
+					bypass-reg = <0xb0 5>;
+				};
+
+				psi_ref_free_clk: psi_ref_free_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-perip-clk";
+					clocks = <&boot_clk>, <&peri_psi_ref_clk>;
+					bypass-reg = <0xb0 6>;
+				};
+
+				mpu_clk: mpu_clk at 30 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&boot_clk>, <&mpu_free_clk>;
+					bypass-reg = <0x3c 0>;
+					clk-gate = <0x30 0>;
+				};
+
+				mpu_periph_clk: mpu_periph_clk at 30 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&mpu_clk>;
+					fixed-divider = <4>;
+					clk-gate = <0x30 0>;
+				};
+
+				mpu_l2ram_clk: mpu_l2ram_clk at 30 {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&mpu_clk>;
+					fixed-divider = <2>;
+					clk-gate = <0x30 0>;
+				};
+
+				l4_main_clk: l4_main_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					div-reg = <0x70 0 2>;
+					clk-gate = <0x30 1>;
+				};
+
+				l4_mp_clk: l4_mp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					div-reg= <0x70 8 2>;
+					clk-gate = <0x30 2>;
+				};
+
+				l4_sp_clk: l4_sp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					div-reg= <0x70 16 2>;
+					clk-gate = <0x30 3>;
+				};
+
+				cs_at_clk: cs_at_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					div-reg= <0x70 24 2>;
+					clk-gate = <0x30 4>;
+				};
+
+				cs_trace_clk: cs_trace_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					div-reg= <0x70 26 2>;
+					clk-gate = <0x30 4>;
+				};
+
+				cs_pdbg_clk: cs_pdbg_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&cs_at_clk>;
+					div-reg= <0x70 28 1>;
+					clk-gate = <0x30 4>;
+				};
+
+				cs_timer_clk: cs_timer_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&noc_clk>;
+					clk-gate = <0x30 5>;
+				};
+
+				s2f_user0_clk: s2f_user0_clk at 3c {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&boot_clk>, <&f2s_free_clk>;
+					bypass-reg = <0x3c 2>;
+					clk-gate = <0x30 6>;
+				};
+
+				emac0_clk: emac0_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&emaca_free_clk>, <&emacb_free_clk>;
+					bypass-reg = <0xdc 26>;
+					clk-gate = <0xa4 0>;
+				};
+
+				emac1_clk: emac1_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&emaca_free_clk>, <&emacb_free_clk>;
+					bypass-reg = <0xdc 27>;
+					clk-gate = <0xa4 1>;
+				};
+
+				emac2_clk: emac2_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&emaca_free_clk>, <&emacb_free_clk>;
+					bypass-reg = <0xdc 28>;
+					clk-gate = <0xa4 2>;
+				};
+
+				emac_ptp_clk: emac_ptp_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&emac_ptp_free_clk>;
+					clk-gate = <0xa4 3>;
+				};
+
+				gpio_db_clk: gpio_db_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&gpio_db_free_clk>;
+					div-reg = <0xe0>;
+					clk-gate = <0xa4 4>;
+				};
+
+				sdmmc_clk: sdmmc_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&sdmmc_free_clk>;
+					fixed-divider = <4>;
+					clk-gate = <0xa4 5>;
+				};
+
+				s2f_usr1_clk: s2f_usr1_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&s2f_user1_free_clk>;
+					clk-gate = <0xa4 6>;
+				};
+
+				psi_ref_clk: psi_ref_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&psi_ref_free_clk>;
+					clk-gate = <0xa4 7>;
+				};
+
+				usb_clk: usb_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&l4_mp_clk>;
+					clk-gate = <0xa4 8>;
+				};
+
+				spi_m_clk: spi_m_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&l4_mp_clk>;
+					clk-gate = <0xa4 9>;
+				};
+
+				nand_clk: nand_clk {
+					#clock-cells = <0>;
+					compatible = "altr,socfpga-s10-gate-clk";
+					clocks = <&l4_main_clk>;
+					clk-gate = <0xa4 10>;
+				};
+			};
 		};
 
 		gmac0: ethernet at ff800000 {
-- 
2.7.4
