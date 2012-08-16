From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 Aug 2012 17:31:50 +0800
Subject: [PATCH V3 3/6] ARM: tegra: clean up the common assembly macros into
 sleep.h
In-Reply-To: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
References: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345109513-21553-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some common macros for Tegra low-level assembly code. Clean
up them into one header file and move the definitions that will be
re-used into it as well.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* no change

 arch/arm/mach-tegra/headsmp.S |    6 +---
 arch/arm/mach-tegra/sleep.S   |   33 +-----------------------
 arch/arm/mach-tegra/sleep.h   |   56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/mach-tegra/sleep.h

diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index fef9c2c..6addc78 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -7,17 +7,13 @@
 
 #include "flowctrl.h"
 #include "reset.h"
+#include "sleep.h"
 
 #define APB_MISC_GP_HIDREV	0x804
 #define PMC_SCRATCH41	0x140
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
-	.macro mov32, reg, val
-	movw	\reg, #:lower16:\val
-	movt	\reg, #:upper16:\val
-	.endm
-
         .section ".text.head", "ax"
 	__CPUINIT
 
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index d29b156..ea81554 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -29,36 +29,5 @@
 #include <mach/iomap.h>
 
 #include "flowctrl.h"
+#include "sleep.h"
 
-#define TEGRA_FLOW_CTRL_VIRT (TEGRA_FLOW_CTRL_BASE - IO_PPSB_PHYS \
-					+ IO_PPSB_VIRT)
-
-/* returns the offset of the flow controller halt register for a cpu */
-.macro cpu_to_halt_reg rd, rcpu
-	cmp	\rcpu, #0
-	subne	\rd, \rcpu, #1
-	movne	\rd, \rd, lsl #3
-	addne	\rd, \rd, #0x14
-	moveq	\rd, #0
-.endm
-
-/* returns the offset of the flow controller csr register for a cpu */
-.macro cpu_to_csr_reg rd, rcpu
-	cmp	\rcpu, #0
-	subne	\rd, \rcpu, #1
-	movne	\rd, \rd, lsl #3
-	addne	\rd, \rd, #0x18
-	moveq	\rd, #8
-.endm
-
-/* returns the ID of the current processor */
-.macro cpu_id, rd
-	mrc	p15, 0, \rd, c0, c0, 5
-	and	\rd, \rd, #0xF
-.endm
-
-/* loads a 32-bit value into a register without a data access */
-.macro mov32, reg, val
-	movw	\reg, #:lower16:\val
-	movt	\reg, #:upper16:\val
-.endm
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
new file mode 100644
index 0000000..d0c7a8b
--- /dev/null
+++ b/arch/arm/mach-tegra/sleep.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_TEGRA_SLEEP_H
+#define __MACH_TEGRA_SLEEP_H
+
+#include <mach/iomap.h>
+
+#define TEGRA_FLOW_CTRL_VIRT (TEGRA_FLOW_CTRL_BASE - IO_PPSB_PHYS \
+					+ IO_PPSB_VIRT)
+
+#ifdef __ASSEMBLY__
+/* returns the offset of the flow controller halt register for a cpu */
+.macro cpu_to_halt_reg rd, rcpu
+	cmp	\rcpu, #0
+	subne	\rd, \rcpu, #1
+	movne	\rd, \rd, lsl #3
+	addne	\rd, \rd, #0x14
+	moveq	\rd, #0
+.endm
+
+/* returns the offset of the flow controller csr register for a cpu */
+.macro cpu_to_csr_reg rd, rcpu
+	cmp	\rcpu, #0
+	subne	\rd, \rcpu, #1
+	movne	\rd, \rd, lsl #3
+	addne	\rd, \rd, #0x18
+	moveq	\rd, #8
+.endm
+
+/* returns the ID of the current processor */
+.macro cpu_id, rd
+	mrc	p15, 0, \rd, c0, c0, 5
+	and	\rd, \rd, #0xF
+.endm
+
+/* loads a 32-bit value into a register without a data access */
+.macro mov32, reg, val
+	movw	\reg, #:lower16:\val
+	movt	\reg, #:upper16:\val
+.endm
+#endif
+#endif
-- 
1.7.0.4
