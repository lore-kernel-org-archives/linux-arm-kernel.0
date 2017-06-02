From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  2 Jun 2017 15:30:06 -0700
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <20170602121532.glfjkxp333ynvcwm@flea.lan>
Message-ID: <20170602223006.1653-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've run into kconfig missing dependency errors in the sunxi-ng
code a couple times now. Each time the fix is to find the missing
select statement and add it to the Kconfig entry for a particular
SoC driver. Given that all this code is builtin (non-modular) we
don't need to do this complicated dependency tracking in Kconfig.
Instead we can move all the "library"ish code to be compiled as
lib-y instead of obj-y, let the linker throw away unused code in
the resulting vmlinux, and drop all the Kconfig stuff we use to
track clock types.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Based on linux-next-20170602.

 drivers/clk/sunxi-ng/Kconfig  | 117 ------------------------------------------
 drivers/clk/sunxi-ng/Makefile |  26 +++++-----
 2 files changed, 13 insertions(+), 130 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 67acef3d2494..dd15f9f9e1ef 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -6,149 +6,42 @@ config SUNXI_CCU
 
 if SUNXI_CCU
 
-# Base clock types
-
-config SUNXI_CCU_DIV
-	bool
-	select SUNXI_CCU_MUX
-
-config SUNXI_CCU_FRAC
-	bool
-
-config SUNXI_CCU_GATE
-	def_bool y
-
-config SUNXI_CCU_MUX
-	bool
-
-config SUNXI_CCU_MULT
-	bool
-	select SUNXI_CCU_MUX
-
-config SUNXI_CCU_PHASE
-	bool
-
-# Multi-factor clocks
-
-config SUNXI_CCU_NK
-	bool
-	select SUNXI_CCU_GATE
-
-config SUNXI_CCU_NKM
-	bool
-	select SUNXI_CCU_GATE
-
-config SUNXI_CCU_NKMP
-	bool
-	select SUNXI_CCU_GATE
-
-config SUNXI_CCU_NM
-	bool
-	select SUNXI_CCU_FRAC
-	select SUNXI_CCU_GATE
-
-config SUNXI_CCU_MP
-	bool
-	select SUNXI_CCU_GATE
-	select SUNXI_CCU_MUX
-
-# SoC Drivers
-
 config SUN50I_A64_CCU
 	bool "Support for the Allwinner A64 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN5I_CCU
 	bool "Support for the Allwinner sun5i family CCM"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN5I
 	depends on MACH_SUN5I || COMPILE_TEST
 
 config SUN6I_A31_CCU
 	bool "Support for the Allwinner A31/A31s CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN6I
 	depends on MACH_SUN6I || COMPILE_TEST
 
 config SUN8I_A23_CCU
 	bool "Support for the Allwinner A23 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A33_CCU
 	bool "Support for the Allwinner A33 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A83T_CCU
 	bool "Support for the Allwinner A83T CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_GATE
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_MUX
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 
 config SUN8I_H3_CCU
 	bool "Support for the Allwinner H3 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN8I_V3S_CCU
 	bool "Support for the Allwinner V3s CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_NK
-	select SUNXI_CCU_NKM
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
@@ -159,21 +52,11 @@ config SUN8I_DE2_CCU
 
 config SUN9I_A80_CCU
 	bool "Support for the Allwinner A80 CCU"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_MULT
-	select SUNXI_CCU_GATE
-	select SUNXI_CCU_NKMP
-	select SUNXI_CCU_NM
-	select SUNXI_CCU_MP
-	select SUNXI_CCU_PHASE
 	default MACH_SUN9I
 	depends on MACH_SUN9I || COMPILE_TEST
 
 config SUN8I_R_CCU
 	bool "Support for Allwinner SoCs' PRCM CCUs"
-	select SUNXI_CCU_DIV
-	select SUNXI_CCU_GATE
-	select SUNXI_CCU_MP
 	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
 
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 0185c6ffadcb..cbc8cb4f70e3 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,21 +1,21 @@
 # Common objects
-obj-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
-obj-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
 
 # Base clock types
-obj-$(CONFIG_SUNXI_CCU_DIV)	+= ccu_div.o
-obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
-obj-$(CONFIG_SUNXI_CCU_GATE)	+= ccu_gate.o
-obj-$(CONFIG_SUNXI_CCU_MUX)	+= ccu_mux.o
-obj-$(CONFIG_SUNXI_CCU_MULT)	+= ccu_mult.o
-obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_div.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_frac.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_gate.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_mux.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_mult.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_phase.o
 
 # Multi-factor clocks
-obj-$(CONFIG_SUNXI_CCU_NK)	+= ccu_nk.o
-obj-$(CONFIG_SUNXI_CCU_NKM)	+= ccu_nkm.o
-obj-$(CONFIG_SUNXI_CCU_NKMP)	+= ccu_nkmp.o
-obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
-obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_nk.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_nkm.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_nkmp.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_nm.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_mp.o
 
 # SoC support
 obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
