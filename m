From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Wed, 10 Nov 2010 19:50:25 -0600
Subject: [PATCH 02/02] staging: tidspbridge: hardcode SCM macros while fix is
	upstreamed
In-Reply-To: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
References: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1289440225-27221-3-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Contreras <felipe.contreras@gmail.com>

On 2.6.37-rc1, omap platform internals for SCM have changed,
so the build is broken again.

drivers/staging/tidspbridge/core/tiomap3430.c:26:
    fatal error: plat/control.h: No such file or directory

This is a totally ugly layer violation, but needed until
omap_ctrl_set_dsp_boot*() are provided.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f22bc12..d302e30 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -23,7 +23,6 @@
 #include <dspbridge/host_os.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <plat/control.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -68,6 +67,19 @@
 #define OMAP3_IVA2_BOOTADDR_MASK 0xFFFFFC00
 #define PAGES_II_LVL_TABLE   512
 
+/*
+ * This is a totally ugly layer violation, but needed until
+ * omap_ctrl_set_dsp_boot*() are provided.
+ */
+#define OMAP3_IVA2_BOOTMOD_IDLE 1
+#define OMAP2_CONTROL_GENERAL 0x270
+#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
+
+#define OMAP343X_CTRL_REGADDR(reg) \
+	OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+
+
 /* Forward Declarations: */
 static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
 static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
-- 
1.7.1
