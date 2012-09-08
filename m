From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 07 Sep 2012 18:39:48 -0600
Subject: [PATCH 2/6] ARM: OMAP2+: clean up omap_hwmod.o build directives in
 Makefile
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Message-ID: <20120908003938.4648.33787.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the omap_hwmod_common_data.o build directive down to the hwmod
data Makefile section where it belongs.  Move the omap_hwmod.o build
directive to the top 'Common support' line, since we have no separate
hwmod code Makefile section, and it's currently needed for all OMAP2+.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 22ee340..bdcf508 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,20 +4,18 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o
 
 omap-2-3-common				= irq.o
-hwmod-common				= omap_hwmod.o \
-					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
 secure-common				= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
-obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
-obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(secure-common)
+obj-$(CONFIG_SOC_AM33XX) += irq.o
+obj-$(CONFIG_SOC_OMAP5)	 += prm44xx.o $(secure-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -181,6 +179,7 @@ obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
 # hwmod data
+obj-y					+= omap_hwmod_common_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
