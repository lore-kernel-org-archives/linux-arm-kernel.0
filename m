From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 07 Jun 2012 00:13:07 -0600
Subject: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating during
 initial setup
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Message-ID: <20120607061306.25532.59488.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the AESS auto-gating control bit during AESS hwmod setup.  This
fixes the following boot warning on OMAP4:

omap_hwmod: aess: _wait_target_disable failed

Without this patch, the AESS IP block does not indicate to the PRCM
that it is idle after it is reset.  This prevents some types of SoC
power management until something sets the auto-gating control bit.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    2 +
 arch/arm/mach-omap2/aess.c                 |   55 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common.h               |    2 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/aess.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..bc2ac4f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o aess.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/aess.c b/arch/arm/mach-omap2/aess.c
new file mode 100644
index 0000000..d5ca3d2
--- /dev/null
+++ b/arch/arm/mach-omap2/aess.c
@@ -0,0 +1,55 @@
+/*
+ * AESS IP block integration
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/kernel.h>
+
+#include <plat/omap_hwmod.h>
+
+#include "common.h"
+
+/*
+ * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS IP
+ *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP block's
+ *     base address
+ */
+#define AESS_AUTO_GATING_ENABLE_OFFSET				0x07c
+
+/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register */
+#define AESS_AUTO_GATING_ENABLE_SHIFT				0
+
+/**
+ * omap_aess_preprogram - enable AESS internal autogating
+ * @oh: struct omap_hwmod *
+ *
+ * Since the AESS will not IdleAck to the PRCM until its internal
+ * autogating is enabled, we must enable autogating during the initial
+ * AESS hwmod setup.  Returns 0.
+ */
+int omap_aess_preprogram(struct omap_hwmod *oh)
+{
+	u32 v;
+
+	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
+	v = 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
+	omap_hwmod_write(v, oh, AESS_AUTO_GATING_ENABLE_OFFSET);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index be9dfd1..d9b8b06 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -304,5 +304,7 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 struct omap2_hsmmc_info;
 extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
 
+extern int omap_aess_preprogram(struct omap_hwmod *oh);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..4a2f2cc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -39,6 +39,7 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "wd_timer.h"
+#include "common.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
@@ -313,6 +314,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc = {
 static struct omap_hwmod_class omap44xx_aess_hwmod_class = {
 	.name	= "aess",
 	.sysc	= &omap44xx_aess_sysc,
+	.setup_preprogram = omap_aess_preprogram,
 };
 
 /* aess */
