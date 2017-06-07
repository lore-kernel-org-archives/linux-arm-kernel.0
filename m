From: s-anna@ti.com (Suman Anna)
Date: Wed, 7 Jun 2017 16:27:29 -0500
Subject: [PATCH 5/6] ARM: dts: dra7xx-clocks: Set IVA DPLL and its output
 clock rates
In-Reply-To: <20170607212730.33002-1-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Message-ID: <20170607212730.33002-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IVA DPLL in DRA7xx provides the output clocks for only the IVAHD
subsystem in DRA7xx as compared to previous OMAP generations when it
provided the clocks for both DSP and IVAHD subsystems. This DPLL is
currently not configured by older bootloaders. Use the DT standard
properties "assigned-clocks" and "assigned-clock-rates" to set the
IVA DPLL clock rate and the rates for its derivative clocks at boot
time to properly initialize/lock this DPLL and be independent of the
bootloader version. Newer u-boots (from 2017.01 onwards) reuse and
can update these properties to choose an appropriate one-time fixed
OPP configuration. The DPLL will automatically transition into a
low-power stop mode when the associated output clocks are not
utilized or gated automatically.

The reset value of the divider M2 (that supplies the IVA_GFLCK, the
functional clock for the IVAHD subsystem) does not match a specific
OPP. So, the derived output clock from this IVA DPLL has to be
initialized as well to avoid initializing these divider outputs to an
incorrect frequencies.

The OPP_NOM clock frequencies are defined in the AM572x SR2.0 Data
Sheet vB, section 5.5.2 "Voltage And Core Clock Specifications". The
clock rates are chosen based on these OPP_NOM values and defined as per
a DRA7xx PLL spec document. The DPLL locked frequency is 2300 MHz, so
the dpll_iva_ck clock rate used is half of this value. The value for the
divider clock, dpll_iva_m2_ck, has to be set to 388.333334 MHz or more
for the divider clk logic to compute the appropriate divider value for
OPP_NOM.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 8a82490035d9..76e2b7478141 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -376,6 +376,8 @@
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_iva_byp_mux>;
 		reg = <0x01a0>, <0x01a4>, <0x01ac>, <0x01a8>;
+		assigned-clocks = <&dpll_iva_ck>;
+		assigned-clock-rates = <1165000000>;
 	};
 
 	dpll_iva_m2_ck: dpll_iva_m2_ck at 1b0 {
@@ -387,6 +389,8 @@
 		reg = <0x01b0>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_iva_m2_ck>;
+		assigned-clock-rates = <388333334>;
 	};
 
 	iva_dclk: iva_dclk {
-- 
2.12.0
