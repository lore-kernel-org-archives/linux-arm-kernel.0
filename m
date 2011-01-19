From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:40 -0800
Subject: [PATCH v2 04/11] msm: io: I/O register definitions for MSM8960
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-5-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Add the register address definitions for the basic hardware
blocks on the Qualcomm MSM8960 chip.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/io.h             |    1 +
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |   48 +++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    2 +
 arch/arm/mach-msm/io.c                          |   14 +++++++
 4 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8960.h

diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index 7386e73..dc1b928 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -29,6 +29,7 @@ void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int m
 void msm_map_qsd8x50_io(void);
 void msm_map_msm7x30_io(void);
 void msm_map_msm8x60_io(void);
+void msm_map_msm8960_io(void);
 
 extern unsigned int msm_shared_ram_phys;
 
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8960.h b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
new file mode 100644
index 0000000..3c9d960
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2011, Code Aurora Forum. All rights reserved.
+ * Author: Brian Swetland <swetland@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * The MSM peripherals are spread all over across 768MB of physical
+ * space, which makes just having a simple IO_ADDRESS macro to slide
+ * them into the right virtual location rough.  Instead, we will
+ * provide a master phys->virt mapping for peripherals here.
+ *
+ */
+
+#ifndef __ASM_ARCH_MSM_IOMAP_8960_H
+#define __ASM_ARCH_MSM_IOMAP_8960_H
+
+/* Physical base address and size of peripherals.
+ * Ordered by the virtual base addresses they will be mapped at.
+ *
+ * If you add or remove entries here, you'll want to edit the
+ * msm_io_desc array in arch/arm/mach-msm/io.c to reflect your
+ * changes.
+ *
+ */
+
+
+#define MSM8960_QGIC_DIST_PHYS	0x02000000
+#define MSM8960_QGIC_DIST_SIZE	SZ_4K
+
+#define MSM8960_QGIC_CPU_PHYS	0x02002000
+#define MSM8960_QGIC_CPU_SIZE	SZ_4K
+
+#define MSM8960_TMR_PHYS	0x0200A000
+#define MSM8960_TMR_SIZE	SZ_4K
+
+#define MSM8960_TMR0_PHYS	0x0208A000
+#define MSM8960_TMR0_SIZE	SZ_4K
+
+#endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index bb42de3..c98c759 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -53,6 +53,8 @@
 #include "msm_iomap-7x00.h"
 #endif
 
+#include "msm_iomap-8960.h"
+
 /* Virtual addressses shared across all MSM targets. */
 #define MSM_CSR_BASE		IOMEM(0xE0001000)
 #define MSM_QGIC_DIST_BASE	IOMEM(0xF0000000)
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 5dd0d1b9..eea502e 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -117,6 +117,20 @@ void __init msm_map_msm8x60_io(void)
 }
 #endif /* CONFIG_ARCH_MSM8X60 */
 
+#ifdef CONFIG_ARCH_MSM8960
+static struct map_desc msm8960_io_desc[] __initdata = {
+	MSM_CHIP_DEVICE(QGIC_DIST, MSM8960),
+	MSM_CHIP_DEVICE(QGIC_CPU, MSM8960),
+	MSM_CHIP_DEVICE(TMR, MSM8960),
+	MSM_CHIP_DEVICE(TMR0, MSM8960),
+};
+
+void __init msm_map_msm8960_io(void)
+{
+	iotable_init(msm8960_io_desc, ARRAY_SIZE(msm8960_io_desc));
+}
+#endif /* CONFIG_ARCH_MSM8960 */
+
 #ifdef CONFIG_ARCH_MSM7X30
 static struct map_desc msm7x30_io_desc[] __initdata = {
 	MSM_DEVICE(VIC),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
