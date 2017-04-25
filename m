From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 25 Apr 2017 18:27:05 +0200
Subject: [PATCH/RFC 1/2] clk: renesas: Rework Kconfig and Makefile logic
In-Reply-To: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
References: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1493137626-21404-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goals are to:
  - Allow precise control over and automatic selection of which
    (sub)drivers are used for which SoC (which may change in the
    future),
  - Allow adding support for new SoCs easily,
  - Allow compile-testing of all (sub)drivers,
  - Keep driver selection logic in the subsystem-specific Kconfig
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This rework was sparked by a discussion with Olof about the Renesas
clock driver dependencies.

For now, some of the 'bool "foo clock support" if COMPILE_TEST' will
need to be replaced by 'bool', as compile-testing all drivers depends on
independent fixes, some in other subsystems.

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
 drivers/clk/renesas/Kconfig            | 129 ++++++++++++++++++++++++++++-----
 drivers/clk/renesas/Makefile           |  37 +++++-----
 drivers/clk/renesas/renesas-cpg-mssr.c |   8 +-
 4 files changed, 137 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 92c12b86c2e86f20..6d341c802b299241 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
 obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
-obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 2586dfa0026bb015..ec17edc6c4ab2e2a 100644
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
+	bool "RZ/A1H clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A73A4
+	bool "R-Mobile APE6 clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7740
+	bool "R-Mobile A1 clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7743
+	bool "RZ/G1M clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2_CPG
+
+config CLK_R8A7745
+	bool "RZ/G1E clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2_CPG
+
+config CLK_R8A7778
+	bool "R-Car M1A clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A7779
+	bool "R-Car H1 clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+
+config CLK_R8A7790
+	bool "R-Car H2 clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7791
+	bool "R-Car M2-W/N clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7792
+	bool "R-Car V2H clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2
+
+config CLK_R8A7794
+	bool "R-Car E2 clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN2
+	select CLK_RENESAS_DIV6
+
+config CLK_R8A7795
+	bool "R-Car H3 clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN3_CPG
+
+config CLK_R8A7796
+	bool "R-Car M3-W clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN3_CPG
+
+config CLK_SH73A0
+	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+
+# Family
+config CLK_RCAR_GEN2
+	bool "R-Car Gen2 clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSTP
+	select CLK_RENESAS_DIV6
+
+config CLK_RCAR_GEN2_CPG
+	bool "R-Car Gen2 CPG clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSSR
+
+config CLK_RCAR_GEN3_CPG
+	bool "R-Car Gen3 CPG clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSSR
+
+
+# Generic
 config CLK_RENESAS_CPG_MSSR
-	bool
-	default y if ARCH_R8A7743
-	default y if ARCH_R8A7745
-	default y if ARCH_R8A7795
-	default y if ARCH_R8A7796
+	bool "CPG/MSSR clock support" if COMPILE_TEST
+	select CLK_RENESAS_DIV6
 
 config CLK_RENESAS_CPG_MSTP
-	bool
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
+	bool "MSTP clock support" if COMPILE_TEST
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
index 1799e160c88f8299..4b281a8d06edf1d3 100644
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
