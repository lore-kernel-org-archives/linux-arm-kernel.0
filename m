From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 11:52:03 +0100
Subject: [PATCH v4 2/6] ARM: zynq: Extract slcr related functions out of
 common.h
In-Reply-To: <cover.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
Message-ID: <f3d0bb91f0cc7c9e735f756b6e664ea8aad921a9.1415962281.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create topic headers not to share all functions.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v4:
- New patch in this series

Changes in v3: None
Changes in v2: None

 arch/arm/mach-zynq/common.c  |  1 +
 arch/arm/mach-zynq/common.h  |  9 ---------
 arch/arm/mach-zynq/platsmp.c |  1 +
 arch/arm/mach-zynq/slcr.c    |  1 +
 arch/arm/mach-zynq/slcr.h    | 29 +++++++++++++++++++++++++++++
 5 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-zynq/slcr.h

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 45cb778b344d..947e72b79496 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -43,6 +43,7 @@
 #include <asm/hardware/cache-l2x0.h>

 #include "common.h"
+#include "slcr.h"
 #include "smp.h"

 #define ZYNQ_DEVCFG_MCTRL		0x80
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 0667cc79f179..5557de83058a 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,15 +17,6 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__

-extern int zynq_slcr_init(void);
-extern int zynq_early_slcr_init(void);
-extern void zynq_slcr_system_reset(void);
-extern void zynq_slcr_cpu_stop(int cpu);
-extern void zynq_slcr_cpu_start(int cpu);
-extern bool zynq_slcr_cpu_state_read(int cpu);
-extern void zynq_slcr_cpu_state_write(int cpu, bool die);
-extern u32 zynq_slcr_get_device_id(void);
-
 extern void __iomem *zynq_scu_base;

 void zynq_pm_late_init(void);
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 5aa6b9ee95fc..717ba2b922b1 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -26,6 +26,7 @@
 #include <asm/smp_scu.h>
 #include <linux/irqchip/arm-gic.h>
 #include "common.h"
+#include "slcr.h"
 #include "smp.h"

 /*
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index d4cb50cf97c0..40f8d7420334 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -20,6 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/clk/zynq.h>
 #include "common.h"
+#include "slcr.h"

 /* register offsets */
 #define SLCR_UNLOCK_OFFSET		0x8   /* SCLR unlock register */
diff --git a/arch/arm/mach-zynq/slcr.h b/arch/arm/mach-zynq/slcr.h
new file mode 100644
index 000000000000..7b4edab666ee
--- /dev/null
+++ b/arch/arm/mach-zynq/slcr.h
@@ -0,0 +1,29 @@
+/*
+ * This file contains common function prototypes to avoid externs
+ * in the c files.
+ *
+ * Copyright (C) 2014 Xilinx
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MACH_ZYNQ_SLCR_H__
+#define __MACH_ZYNQ_SLCR_H__
+
+extern int zynq_slcr_init(void);
+extern int zynq_early_slcr_init(void);
+extern void zynq_slcr_system_reset(void);
+extern void zynq_slcr_cpu_stop(int cpu);
+extern void zynq_slcr_cpu_start(int cpu);
+extern bool zynq_slcr_cpu_state_read(int cpu);
+extern void zynq_slcr_cpu_state_write(int cpu, bool die);
+extern u32 zynq_slcr_get_device_id(void);
+
+#endif
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/c3236f33/attachment.sig>
