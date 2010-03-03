From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 12:16:59 +0000
Subject: [PATCH v3 4/4] ARM: Add RealView-specific barrier implementation
In-Reply-To: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
References: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100303121659.22029.7659.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines ARCH_HAS_BARRIERS for the RealView boards if
CACHE_L2X0 is enabled and adds the mach/barriers.h file. The mb() and
wmb() barriers perform an L2 cache sync in addition to the DSB.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig                               |    1 +
 arch/arm/mach-realview/include/mach/barriers.h |   30 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 184a6bd..d2b1f3f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -235,6 +235,7 @@ config ARCH_REALVIEW
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	help
 	  This enables support for ARM Ltd RealView boards.
 
diff --git a/arch/arm/mach-realview/include/mach/barriers.h b/arch/arm/mach-realview/include/mach/barriers.h
new file mode 100644
index 0000000..cc11517
--- /dev/null
+++ b/arch/arm/mach-realview/include/mach/barriers.h
@@ -0,0 +1,30 @@
+/*
+ * arch/arm/mach-realview/include/mach/barriers.h
+ *
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __MACH_BARRIERS_H
+#define __MACH_BARRIERS_H
+
+#include <asm/outercache.h>
+
+#define rmb()		dmb()
+#define wmb()		do { dsb(); outer_sync(); } while (0)
+#define mb()		wmb()
+
+#endif	/* __MACH_BARRIERS_H */
