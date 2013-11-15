From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Nov 2013 08:31:07 -0800
Subject: [PATCH] ARM: OMAP2+: Fix build for dra7xx without omap4 and 5
Message-ID: <20131115163107.GZ10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we can get errors like:

arch/arm/mach-omap2/prm44xx.c:274: error: redefinition of ?omap44xx_prm_reconfigure_io_chain?
arch/arm/mach-omap2/built-in.o: In function `default_finish_suspend':
arch/arm/mach-omap2/omap-mpuss-lowpower.c:95: undefined reference to `omap_do_wfi'

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -40,7 +40,7 @@ omap-4-5-common				=  omap4-common.o omap-wakeupgen.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(omap-4-5-common)
-obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y)
+obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -42,7 +42,8 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
 void omap44xx_prm_reconfigure_io_chain(void);
 #else
 static inline void omap44xx_prm_reconfigure_io_chain(void)
