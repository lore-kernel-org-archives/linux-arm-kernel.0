From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Jun 2012 18:46:14 -0600
Subject: [PATCHv2 07/12] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Message-ID: <20120611004611.20034.60143.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the AESS auto-gating control bit during AESS hwmod setup.  This
fixes the following boot warning on OMAP4:

omap_hwmod: aess: _wait_target_disable failed

Without this patch, the AESS IP block does not indicate to the PRCM
that it is idle after it is reset.  This prevents some types of SoC
power management until something sets the auto-gating control bit.

This second version of this patch moves the control functions to
include/linux/platform_data/aess.h at Tony's request:

    http://www.spinics.net/lists/arm-kernel/msg178329.html

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +
 include/linux/platform_data/aess.h         |   76 ++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 include/linux/platform_data/aess.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6b0aedc..7700d6d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -20,6 +20,8 @@
 
 #include <linux/io.h>
 
+#include <linux/platform_data/aess.h>
+
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <plat/i2c.h>
@@ -313,6 +315,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc = {
 static struct omap_hwmod_class omap44xx_aess_hwmod_class = {
 	.name	= "aess",
 	.sysc	= &omap44xx_aess_sysc,
+	.setup_preprogram = hwmod_aess_preprogram,
 };
 
 /* aess */
diff --git a/include/linux/platform_data/aess.h b/include/linux/platform_data/aess.h
new file mode 100644
index 0000000..1e0d71b
--- /dev/null
+++ b/include/linux/platform_data/aess.h
@@ -0,0 +1,76 @@
+/*
+ * AESS IP block integration
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+#ifndef __LINUX_PLATFORM_DATA_AESS_H__
+#define __LINUX_PLATFORM_DATA_AESS_H__
+
+#include <linux/kernel.h>
+
+#include <plat/omap_hwmod.h>
+
+/*
+ * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS IP
+ *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP block's
+ *     base address
+ */
+#define AESS_AUTO_GATING_ENABLE_OFFSET			0x07c
+
+/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register */
+#define AESS_AUTO_GATING_ENABLE_SHIFT			0
+
+/**
+ * aess_enable_autogating - enable AESS internal autogating
+ * @oh: struct omap_hwmod *
+ *
+ * Enable internal autogating on the AESS.  This allows the AESS to
+ * indicate that it is idle to the OMAP PRCM.  Returns 0.
+ */
+static void aess_enable_autogating(void __iomem *base)
+{
+	u32 v;
+
+	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
+	v = 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
+	writel(v, base + AESS_AUTO_GATING_ENABLE_OFFSET);
+}
+
+/**
+ * hwmod_aess_preprogram - enable AESS internal autogating (called by hwmod)
+ * @oh: struct omap_hwmod *
+ *
+ * The AESS will not IdleAck to the PRCM until its internal autogating
+ * is enabled.  Since internal autogating is disabled by default after
+ * AESS reset, we must enable autogating after the hwmod code resets
+ * the AESS.  Returns 0.
+ */
+static int __maybe_unused hwmod_aess_preprogram(struct omap_hwmod *oh)
+{
+	void __iomem *va;
+
+	va = omap_hwmod_get_mpu_rt_va(oh);
+	if (!va)
+		return -EINVAL;
+
+	aess_enable_autogating(va);
+
+	return 0;
+}
+
+#endif /* __LINUX_PLATFORM_DATA_AESS_H__ */
