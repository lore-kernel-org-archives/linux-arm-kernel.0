From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 19 May 2017 10:30:07 +0200
Subject: [PATCH v2] clk: renesas: Rework Kconfig and Makefile logic
Message-ID: <1495182607-20856-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goals are to:
  - Allow precise control over and automatic selection of which
    (sub)drivers are used for which SoC (which may change in the
    future),
  - Allow adding support for new SoCs easily,
  - Allow compile-testing of all (sub)drivers,
  - Keep driver selection logic in the subsystem-specific Kconfig,
    independent from the architecture-specific Kconfig (i.e. no "select"
    from arch/arm64/Kconfig.platforms), to avoid dependencies.

This is implemented by:
  - Introducing Kconfig symbols for all drivers and sub-drivers,
  - Introducing the Kconfig symbol CLK_RENESAS, which is enabled
    automatically when building for a Renesas ARM platform, and which
    enables all required drivers without interaction of the user, based
    on SoC-specific ARCH_* symbols,
  - Allowing the user to enable any Kconfig symbol manually if
    COMPILE_TEST is enabled,
  - Using the new Kconfig symbols instead of the ARCH_* symbols to
    control compilation in the Makefile,
  - Always entering drivers/clk/renesas/ during the build.

Note that currently not all (sub)drivers are enabled for
compile-testing, as they depend on independent fixes in other
subsystems.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
To be queued in clk-renesas-for-v4.13.

v2:
  - Add Acked-by,
  - Remove ability to do compile-testing from all drivers that need
    pending fixes:
      - dummy of_clk_get_from_provider() for CONFIG_OF=n,
      - dummy of_device_compatible_match() for CONFIG_OF=n,
      - dummy rcar_rst_read_mode_pins() if rcar-rst is not built,
      - new helper of_node_get_match_data().
    These will be re-enabled for compile-testing later.

This rework was sparked by a discussion with Olof about the Renesas
clock driver dependencies.

Before anyone responds "But the CLK_R8A779[0-4] symbols can be removed,
just select CLK_RCAR_GEN2 directly!": the latter will go away, as the
shared R-Car Gen2 clock driver (which depends on describing most clocks
in DT, which is error prone, inflexible, and which prevents implementing
module reset support) will be replaced by SoC-specific drivers using the
CPG/MSSR driver core, as is already done on R-Car Gen3 and on RZ/G.
Compatibility with old DTBs will be preserved through a new Kconfig
option.
---
 drivers/clk/Makefile                   |   2 +-
 drivers/clk/renesas/Kconfig            | 125 +++++++++++++++++++++++++++++----
 drivers/clk/renesas/Makefile           |  37 +++++-----
 drivers/clk/renesas/renesas-cpg-mssr.c |   8 +--
 4 files changed, 135 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c19983afcb81c9d1..8ea0c55645b0db95 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -75,7 +75,7 @@ obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
 obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
-obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 2586dfa0026bb015..9c8b44db39f14326 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -1,20 +1,115 @@
+config CLK_RENESAS
+	bool "Renesas SoC clock support" if COMPILE_TEST && !ARCH_RENESAS
+	default y if ARCH_RENESAS
+	select CLK_EMEV2 if ARCH_EMEV2
+	select CLK_RZA1 if ARCH_R7S72100
+	select CLK_R8A73A4 if ARCH_R8A73A4
+	select CLK_R8A7740 if ARCH_R8A7740
+	select CLK_R8A7743 if ARCH_R8A7743
+	select CLK_R8A7745 if ARCH_R8A7745
+	select CLK_R8A7778 if ARCH_R8A7778
+	select CLK_R8A7779 if ARCH_R8A7779
+	select CLK_R8A7790 if ARCH_R8A7790
+	select CLK_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
+	select CLK_R8A7792 if ARCH_R8A7792
+	select CLK_R8A7794 if ARCH_R8A7794
+	select CLK_R8A7795 if ARCH_R8A7795
+	select CLK_R8A7796 if ARCH_R8A7796
+	select CLK_SH73A0 if ARCH_SH73A0
+
+if CLK_RENESAS
+
+# SoC
+config CLK_EMEV2
+	bool "Emma Mobile EV2 clock support" if COMPILE_TEST
+
+config CLK_RZA1
+	bool
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A73A4
+	bool
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7740
+	bool
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7743
+	bool
+	select CLK_RCAR_GEN2_CPG
+
+config CLK_R8A7745
+	bool
+	select CLK_RCAR_GEN2_CPG
+
+config CLK_R8A7778
+	bool
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A7779
+	bool
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A7790
+	bool
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7791
+	bool
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7792
+	bool
+	select CLK_RCAR_GEN2
+
+config CLK_R8A7794
+	bool
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7795
+	bool
+	select CLK_RCAR_GEN3_CPG
+
+config CLK_R8A7796
+	bool
+	select CLK_RCAR_GEN3_CPG
+
+config CLK_SH73A0
+	bool
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+
+# Family
+config CLK_RCAR_GEN2
+	bool
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_RCAR_GEN2_CPG
+	bool
+	select CLK_RENESAS_CPG_MSSR
+
+config CLK_RCAR_GEN3_CPG
+	bool
+	select CLK_RENESAS_CPG_MSSR
+
+
+# Generic
 config CLK_RENESAS_CPG_MSSR
 	bool
-	default y if ARCH_R8A7743
-	default y if ARCH_R8A7745
-	default y if ARCH_R8A7795
-	default y if ARCH_R8A7796
+	select CLK_RENESAS_DIV6
 
 config CLK_RENESAS_CPG_MSTP
 	bool
-	default y if ARCH_R7S72100
-	default y if ARCH_R8A73A4
-	default y if ARCH_R8A7740
-	default y if ARCH_R8A7778
-	default y if ARCH_R8A7779
-	default y if ARCH_R8A7790
-	default y if ARCH_R8A7791
-	default y if ARCH_R8A7792
-	default y if ARCH_R8A7793
-	default y if ARCH_R8A7794
-	default y if ARCH_SH73A0
+
+config CLK_RENESAS_DIV6
+	bool "DIV6 clock support" if COMPILE_TEST
+
+endif # CLK_RENESAS
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 5b8fccf574787632..aa24c2f5078ca333 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -1,19 +1,22 @@
-obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
-obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
-obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7743)		+= r8a7743-cpg-mssr.o rcar-gen2-cpg.o
-obj-$(CONFIG_ARCH_R8A7745)		+= r8a7745-cpg-mssr.o rcar-gen2-cpg.o
-obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7792)		+= clk-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7795)		+= r8a7795-cpg-mssr.o rcar-gen3-cpg.o
-obj-$(CONFIG_ARCH_R8A7796)		+= r8a7796-cpg-mssr.o rcar-gen3-cpg.o
-obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-div6.o
+# SoC
+obj-$(CONFIG_CLK_EMEV2)			+= clk-emev2.o
+obj-$(CONFIG_CLK_RZA1)			+= clk-rz.o
+obj-$(CONFIG_CLK_R8A73A4)		+= clk-r8a73a4.o
+obj-$(CONFIG_CLK_R8A7740)		+= clk-r8a7740.o
+obj-$(CONFIG_CLK_R8A7743)		+= r8a7743-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A7745)		+= r8a7745-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A7778)		+= clk-r8a7778.o
+obj-$(CONFIG_CLK_R8A7779)		+= clk-r8a7779.o
+obj-$(CONFIG_CLK_R8A7795)		+= r8a7795-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A7796)		+= r8a7796-cpg-mssr.o
+obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
-obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)	+= renesas-cpg-mssr.o clk-div6.o
+# Family
+obj-$(CONFIG_CLK_RCAR_GEN2)		+= clk-rcar-gen2.o
+obj-$(CONFIG_CLK_RCAR_GEN2_CPG)		+= rcar-gen2-cpg.o
+obj-$(CONFIG_CLK_RCAR_GEN3_CPG)		+= rcar-gen3-cpg.o
+
+# Generic
+obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)	+= renesas-cpg-mssr.o
 obj-$(CONFIG_CLK_RENESAS_CPG_MSTP)	+= clk-mstp.o
+obj-$(CONFIG_CLK_RENESAS_DIV6)		+= clk-div6.o
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 51d4af0a53ec2d38..9ebe0bec42a8dbfc 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -627,25 +627,25 @@ static inline int cpg_mssr_reset_controller_register(struct cpg_mssr_priv *priv)
 
 
 static const struct of_device_id cpg_mssr_match[] = {
-#ifdef CONFIG_ARCH_R8A7743
+#ifdef CONFIG_CLK_R8A7743
 	{
 		.compatible = "renesas,r8a7743-cpg-mssr",
 		.data = &r8a7743_cpg_mssr_info,
 	},
 #endif
-#ifdef CONFIG_ARCH_R8A7745
+#ifdef CONFIG_CLK_R8A7745
 	{
 		.compatible = "renesas,r8a7745-cpg-mssr",
 		.data = &r8a7745_cpg_mssr_info,
 	},
 #endif
-#ifdef CONFIG_ARCH_R8A7795
+#ifdef CONFIG_CLK_R8A7795
 	{
 		.compatible = "renesas,r8a7795-cpg-mssr",
 		.data = &r8a7795_cpg_mssr_info,
 	},
 #endif
-#ifdef CONFIG_ARCH_R8A7796
+#ifdef CONFIG_CLK_R8A7796
 	{
 		.compatible = "renesas,r8a7796-cpg-mssr",
 		.data = &r8a7796_cpg_mssr_info,
-- 
2.7.4
