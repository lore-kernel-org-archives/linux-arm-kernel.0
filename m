From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 13 Mar 2017 18:12:32 +0100
Subject: [PATCH v2 3/4] clk: renesas: r8a7795: Add support for R-Car H3 ES2.0
In-Reply-To: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
References: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1489425153-22623-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Clock Pulse Generator / Module Standby and Software Reset module in
R-Car H3 ES2.0 differs from ES1.x in the following areas:
  - More core clocks (S0D2, S0D3, S0D6, S0D8, S0D12),
  - Different parent clocks for AUDMAC, EtherAVB, FCP, FDP, IMR,
    SYS-DMAC, VIN, VSPB, VSPI,
  - Removal of modules CSI21, FCPCI, FCPF2, FCPVD3, FCPVI2, FDP1-2,
    USB3-IF1, VSPD3, VSPI2,
  - Addition of modules EHCI3, HS-USB-IF3, USB-DMAC3-0, USB-DMAC3-1.

The goal is twofold:
  1. Support both the ES1.x and ES2.0 SoC revisions in a single binary
     for now,
  2. Make it clear which code supports ES1.x, so it can easily be
     identified and removed later, when production SoCs are deemed
     ubiquitous.

This is achieved by:
  - Updating the clock tables for the latest revision (ES2.0), but not
    removing clocks that only exist on earlier revisions (ES1.x),
  - Detecting the SoC revision at runtime using the new soc_device_match()
    API, and fixing up the clocks tables to match the actual SoC
    revision, by:
      - NULLifying core and module clocks of modules that do not exist,
      - Reparenting module clocks that have a different parent on ES1.x.

Based on R-Car Gen3 Hardware User's Manual rev. 0.53E.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This saves ca. 3 KiB compared to using two sets of tables (one for ES1.x
and one for ES2.0).

v2:
  - Drop RFC state,
  - Add more rationale,
  - Confirm FDP parent clock on ES2.0,
  - More different parent clocks: FCP, IMR,
  - More removed modules: USB3-IF1, FCPCI,
  - Module clock 326 on ES2.0 is called USB-DMAC3-0, not USB3.0-IF3-0,
  - Drop the NAND controller, as it also doesn't exist on ES2.0,
  - Update datasheet revision.
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 201 +++++++++++++++++++++++++--------
 1 file changed, 151 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 4699f416e275d924..eaa98b488f015944 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/soc/renesas/rcar-rst.h>
+#include <linux/sys_soc.h>
 
 #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
 
@@ -24,7 +25,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A7795_CLK_OSC,
+	LAST_DT_CORE_CLK = R8A7795_CLK_S0D12,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -51,7 +52,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
+static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -78,7 +79,12 @@ static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
 	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
 	DEF_FIXED("zx",         R8A7795_CLK_ZX,    CLK_PLL1_DIV2,  2, 1),
 	DEF_FIXED("s0d1",       R8A7795_CLK_S0D1,  CLK_S0,         1, 1),
+	DEF_FIXED("s0d2",       R8A7795_CLK_S0D2,  CLK_S0,         2, 1),
+	DEF_FIXED("s0d3",       R8A7795_CLK_S0D3,  CLK_S0,         3, 1),
 	DEF_FIXED("s0d4",       R8A7795_CLK_S0D4,  CLK_S0,         4, 1),
+	DEF_FIXED("s0d6",       R8A7795_CLK_S0D6,  CLK_S0,         6, 1),
+	DEF_FIXED("s0d8",       R8A7795_CLK_S0D8,  CLK_S0,         8, 1),
+	DEF_FIXED("s0d12",      R8A7795_CLK_S0D12, CLK_S0,        12, 1),
 	DEF_FIXED("s1d1",       R8A7795_CLK_S1D1,  CLK_S1,         1, 1),
 	DEF_FIXED("s1d2",       R8A7795_CLK_S1D2,  CLK_S1,         2, 1),
 	DEF_FIXED("s1d4",       R8A7795_CLK_S1D4,  CLK_S1,         4, 1),
@@ -108,10 +114,10 @@ static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
 	DEF_BASE("r",           R8A7795_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
-	DEF_MOD("fdp1-2",		 117,	R8A7795_CLK_S2D1),
-	DEF_MOD("fdp1-1",		 118,	R8A7795_CLK_S2D1),
-	DEF_MOD("fdp1-0",		 119,	R8A7795_CLK_S2D1),
+static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
+	DEF_MOD("fdp1-2",		 117,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fdp1-1",		 118,	R8A7795_CLK_S0D1),
+	DEF_MOD("fdp1-0",		 119,	R8A7795_CLK_S0D1),
 	DEF_MOD("scif5",		 202,	R8A7795_CLK_S3D4),
 	DEF_MOD("scif4",		 203,	R8A7795_CLK_S3D4),
 	DEF_MOD("scif3",		 204,	R8A7795_CLK_S3D4),
@@ -121,9 +127,9 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("msiof2",		 209,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof1",		 210,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof0",		 211,	R8A7795_CLK_MSO),
-	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S3D1),
-	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
-	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
+	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S0D3),
+	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S0D3),
+	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S0D3),
 	DEF_MOD("cmt3",			 300,	R8A7795_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A7795_CLK_R),
 	DEF_MOD("cmt1",			 302,	R8A7795_CLK_R),
@@ -135,15 +141,15 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("sdif0",		 314,	R8A7795_CLK_SD0),
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
-	DEF_MOD("usb3-if1",		 327,	R8A7795_CLK_S3D1),
+	DEF_MOD("usb3-if1",		 327,	R8A7795_CLK_S3D1), /* ES1.x */
 	DEF_MOD("usb3-if0",		 328,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac0",		 330,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac1",		 331,	R8A7795_CLK_S3D1),
 	DEF_MOD("rwdt",			 402,	R8A7795_CLK_R),
 	DEF_MOD("intc-ex",		 407,	R8A7795_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
-	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S3D1),
-	DEF_MOD("audmac0",		 502,	R8A7795_CLK_S3D1),
+	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S0D3),
+	DEF_MOD("audmac0",		 502,	R8A7795_CLK_S0D3),
 	DEF_MOD("drif7",		 508,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif6",		 509,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif5",		 510,	R8A7795_CLK_S3D2),
@@ -159,35 +165,35 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("hscif0",		 520,	R8A7795_CLK_S3D1),
 	DEF_MOD("thermal",		 522,	R8A7795_CLK_CP),
 	DEF_MOD("pwm",			 523,	R8A7795_CLK_S3D4),
-	DEF_MOD("fcpvd3",		 600,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvd2",		 601,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvd1",		 602,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvd0",		 603,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvb1",		 606,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvb0",		 607,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvi2",		 609,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvi1",		 610,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpvi0",		 611,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpf2",		 613,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpf1",		 614,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpf0",		 615,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpci1",		 616,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpci0",		 617,	R8A7795_CLK_S2D1),
-	DEF_MOD("fcpcs",		 619,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspd3",		 620,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspd2",		 621,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspd1",		 622,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspd0",		 623,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspbc",		 624,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspbd",		 626,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspi2",		 629,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S2D1),
-	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S2D1),
+	DEF_MOD("fcpvd3",		 600,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fcpvd2",		 601,	R8A7795_CLK_S0D2),
+	DEF_MOD("fcpvd1",		 602,	R8A7795_CLK_S0D2),
+	DEF_MOD("fcpvd0",		 603,	R8A7795_CLK_S0D2),
+	DEF_MOD("fcpvb1",		 606,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpvb0",		 607,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpvi2",		 609,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fcpvi1",		 610,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpvi0",		 611,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpf2",		 613,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fcpf1",		 614,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpf0",		 615,	R8A7795_CLK_S0D1),
+	DEF_MOD("fcpci1",		 616,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fcpci0",		 617,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("fcpcs",		 619,	R8A7795_CLK_S0D1),
+	DEF_MOD("vspd3",		 620,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("vspd2",		 621,	R8A7795_CLK_S0D2),
+	DEF_MOD("vspd1",		 622,	R8A7795_CLK_S0D2),
+	DEF_MOD("vspd0",		 623,	R8A7795_CLK_S0D2),
+	DEF_MOD("vspbc",		 624,	R8A7795_CLK_S0D1),
+	DEF_MOD("vspbd",		 626,	R8A7795_CLK_S0D1),
+	DEF_MOD("vspi2",		 629,	R8A7795_CLK_S2D1), /* ES1.x */
+	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S0D1),
+	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S0D1),
 	DEF_MOD("ehci2",		 701,	R8A7795_CLK_S3D4),
 	DEF_MOD("ehci1",		 702,	R8A7795_CLK_S3D4),
 	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D4),
 	DEF_MOD("hsusb",		 704,	R8A7795_CLK_S3D4),
-	DEF_MOD("csi21",		 713,	R8A7795_CLK_CSI0),
+	DEF_MOD("csi21",		 713,	R8A7795_CLK_CSI0), /* ES1.x */
 	DEF_MOD("csi20",		 714,	R8A7795_CLK_CSI0),
 	DEF_MOD("csi41",		 715,	R8A7795_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A7795_CLK_CSI0),
@@ -198,20 +204,20 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("lvds",			 727,	R8A7795_CLK_S0D4),
 	DEF_MOD("hdmi1",		 728,	R8A7795_CLK_HDMI),
 	DEF_MOD("hdmi0",		 729,	R8A7795_CLK_HDMI),
-	DEF_MOD("vin7",			 804,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin6",			 805,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin5",			 806,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin4",			 807,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin3",			 808,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin2",			 809,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin1",			 810,	R8A7795_CLK_S2D1),
-	DEF_MOD("vin0",			 811,	R8A7795_CLK_S2D1),
-	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S3D2),
+	DEF_MOD("vin7",			 804,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin6",			 805,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin5",			 806,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin4",			 807,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin3",			 808,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin2",			 809,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin1",			 810,	R8A7795_CLK_S0D2),
+	DEF_MOD("vin0",			 811,	R8A7795_CLK_S0D2),
+	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S0D6),
 	DEF_MOD("sata0",		 815,	R8A7795_CLK_S3D2),
-	DEF_MOD("imr3",			 820,	R8A7795_CLK_S2D1),
-	DEF_MOD("imr2",			 821,	R8A7795_CLK_S2D1),
-	DEF_MOD("imr1",			 822,	R8A7795_CLK_S2D1),
-	DEF_MOD("imr0",			 823,	R8A7795_CLK_S2D1),
+	DEF_MOD("imr3",			 820,	R8A7795_CLK_S0D2),
+	DEF_MOD("imr2",			 821,	R8A7795_CLK_S0D2),
+	DEF_MOD("imr1",			 822,	R8A7795_CLK_S0D2),
+	DEF_MOD("imr0",			 823,	R8A7795_CLK_S0D2),
 	DEF_MOD("gpio7",		 905,	R8A7795_CLK_CP),
 	DEF_MOD("gpio6",		 906,	R8A7795_CLK_CP),
 	DEF_MOD("gpio5",		 907,	R8A7795_CLK_CP),
@@ -314,6 +320,82 @@ static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	{ 2,		192,		192,	},
 };
 
+static const struct soc_device_attribute r8a7795es1[] __initconst = {
+	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+	{ /* sentinel */ }
+};
+
+
+	/*
+	 * Fixups for R-Car H3 ES1.x
+	 */
+
+static const unsigned int r8a7795es1_mod_nullify[] __initconst = {
+	MOD_CLK_ID(326),			/* USB-DMAC3-0 */
+	MOD_CLK_ID(329),			/* USB-DMAC3-1 */
+	MOD_CLK_ID(700),			/* EHCI/OHCI3 */
+	MOD_CLK_ID(705),			/* HS-USB-IF3 */
+
+};
+
+static const struct mssr_mod_reparent r8a7795es1_mod_reparent[] __initconst = {
+	{ MOD_CLK_ID(118), R8A7795_CLK_S2D1 },	/* FDP1-1 */
+	{ MOD_CLK_ID(119), R8A7795_CLK_S2D1 },	/* FDP1-0 */
+	{ MOD_CLK_ID(217), R8A7795_CLK_S3D1 },	/* SYS-DMAC2 */
+	{ MOD_CLK_ID(218), R8A7795_CLK_S3D1 },	/* SYS-DMAC1 */
+	{ MOD_CLK_ID(219), R8A7795_CLK_S3D1 },	/* SYS-DMAC0 */
+	{ MOD_CLK_ID(501), R8A7795_CLK_S3D1 },	/* AUDMAC1 */
+	{ MOD_CLK_ID(502), R8A7795_CLK_S3D1 },	/* AUDMAC0 */
+	{ MOD_CLK_ID(601), R8A7795_CLK_S2D1 },	/* FCPVD2 */
+	{ MOD_CLK_ID(602), R8A7795_CLK_S2D1 },	/* FCPVD1 */
+	{ MOD_CLK_ID(603), R8A7795_CLK_S2D1 },	/* FCPVD0 */
+	{ MOD_CLK_ID(606), R8A7795_CLK_S2D1 },	/* FCPVB1 */
+	{ MOD_CLK_ID(607), R8A7795_CLK_S2D1 },	/* FCPVB0 */
+	{ MOD_CLK_ID(610), R8A7795_CLK_S2D1 },	/* FCPVI1 */
+	{ MOD_CLK_ID(611), R8A7795_CLK_S2D1 },	/* FCPVI0 */
+	{ MOD_CLK_ID(614), R8A7795_CLK_S2D1 },	/* FCPF1 */
+	{ MOD_CLK_ID(615), R8A7795_CLK_S2D1 },	/* FCPF0 */
+	{ MOD_CLK_ID(619), R8A7795_CLK_S2D1 },	/* FCPCS */
+	{ MOD_CLK_ID(621), R8A7795_CLK_S2D1 },	/* VSPD2 */
+	{ MOD_CLK_ID(622), R8A7795_CLK_S2D1 },	/* VSPD1 */
+	{ MOD_CLK_ID(623), R8A7795_CLK_S2D1 },	/* VSPD0 */
+	{ MOD_CLK_ID(624), R8A7795_CLK_S2D1 },	/* VSPBC */
+	{ MOD_CLK_ID(626), R8A7795_CLK_S2D1 },	/* VSPBD */
+	{ MOD_CLK_ID(630), R8A7795_CLK_S2D1 },	/* VSPI1 */
+	{ MOD_CLK_ID(631), R8A7795_CLK_S2D1 },	/* VSPI0 */
+	{ MOD_CLK_ID(804), R8A7795_CLK_S2D1 },	/* VIN7 */
+	{ MOD_CLK_ID(805), R8A7795_CLK_S2D1 },	/* VIN6 */
+	{ MOD_CLK_ID(806), R8A7795_CLK_S2D1 },	/* VIN5 */
+	{ MOD_CLK_ID(807), R8A7795_CLK_S2D1 },	/* VIN4 */
+	{ MOD_CLK_ID(808), R8A7795_CLK_S2D1 },	/* VIN3 */
+	{ MOD_CLK_ID(809), R8A7795_CLK_S2D1 },	/* VIN2 */
+	{ MOD_CLK_ID(810), R8A7795_CLK_S2D1 },	/* VIN1 */
+	{ MOD_CLK_ID(811), R8A7795_CLK_S2D1 },	/* VIN0 */
+	{ MOD_CLK_ID(812), R8A7795_CLK_S3D2 },	/* EAVB-IF */
+	{ MOD_CLK_ID(820), R8A7795_CLK_S2D1 },	/* IMR3 */
+	{ MOD_CLK_ID(821), R8A7795_CLK_S2D1 },	/* IMR2 */
+	{ MOD_CLK_ID(822), R8A7795_CLK_S2D1 },	/* IMR1 */
+	{ MOD_CLK_ID(823), R8A7795_CLK_S2D1 },	/* IMR0 */
+};
+
+
+	/*
+	 * Fixups for R-Car H3 ES2.x
+	 */
+
+static const unsigned int r8a7795es2_mod_nullify[] __initconst = {
+	MOD_CLK_ID(117),			/* FDP1-2 */
+	MOD_CLK_ID(327),			/* USB3-IF1 */
+	MOD_CLK_ID(600),			/* FCPVD3 */
+	MOD_CLK_ID(609),			/* FCPVI2 */
+	MOD_CLK_ID(613),			/* FCPF2 */
+	MOD_CLK_ID(616),			/* FCPCI1 */
+	MOD_CLK_ID(617),			/* FCPCI0 */
+	MOD_CLK_ID(620),			/* VSPD3 */
+	MOD_CLK_ID(629),			/* VSPI2 */
+	MOD_CLK_ID(713),			/* CSI21 */
+};
+
 static int __init r8a7795_cpg_mssr_init(struct device *dev)
 {
 	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
@@ -330,6 +412,25 @@ static int __init r8a7795_cpg_mssr_init(struct device *dev)
 		return -EINVAL;
 	}
 
+	if (soc_device_match(r8a7795es1)) {
+		cpg_core_nullify_range(r8a7795_core_clks,
+				       ARRAY_SIZE(r8a7795_core_clks),
+				       R8A7795_CLK_S0D2, R8A7795_CLK_S0D12);
+		mssr_mod_nullify(r8a7795_mod_clks,
+				 ARRAY_SIZE(r8a7795_mod_clks),
+				 r8a7795es1_mod_nullify,
+				 ARRAY_SIZE(r8a7795es1_mod_nullify));
+		mssr_mod_reparent(r8a7795_mod_clks,
+				  ARRAY_SIZE(r8a7795_mod_clks),
+				  r8a7795es1_mod_reparent,
+				  ARRAY_SIZE(r8a7795es1_mod_reparent));
+	} else {
+		mssr_mod_nullify(r8a7795_mod_clks,
+				 ARRAY_SIZE(r8a7795_mod_clks),
+				 r8a7795es2_mod_nullify,
+				 ARRAY_SIZE(r8a7795es2_mod_nullify));
+	}
+
 	return rcar_gen3_cpg_init(cpg_pll_config, CLK_EXTALR, cpg_mode);
 }
 
-- 
2.7.4
