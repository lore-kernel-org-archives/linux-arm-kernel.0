From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Wed, 9 Jan 2013 16:03:08 +0100
Subject: [PATCH v2 2/5] ASoC: TI AESS: add autogating-enable function,
 callable from architecture code
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1357743792-13917-3-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <paul@pwsan.com>

Add a basic header file for the TI AESS IP block, located in the OMAP4
Audio Back-End subsystem.

Currently, this header file only contains a function to enable the
AESS internal clock auto-gating.  This will be used by a subsequent
patch to ensure that the AESS won't block the entire chip
low-power-idle mode.  We wish to be able to place the AESS into idle
even when no AESS driver has been compiled in.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 include/sound/aess.h |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/sound/aess.h

diff --git a/include/sound/aess.h b/include/sound/aess.h
new file mode 100644
index 0000000..cee0d09
--- /dev/null
+++ b/include/sound/aess.h
@@ -0,0 +1,53 @@
+/*
+ * AESS IP block reset
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
+#ifndef __SOUND_AESS_H__
+#define __SOUND_AESS_H__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
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
+static inline void aess_enable_autogating(void __iomem *base)
+{
+	u32 v;
+
+	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
+	v = 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
+	writel(v, base + AESS_AUTO_GATING_ENABLE_OFFSET);
+}
+
+#endif /* __SOUND_AESS_H__ */
-- 
1.7.10.4
