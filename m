From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:20 -0600
Subject: [PATCH v4 11/19] ARM: VIC: shrink down vic.h
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move all register defines except VIC_INT_ENABLE and VIC_INT_ENABLE_CLEAR
which are used by Samsung.

With multi irq handler, vic.h is not included in assembly any more, so
we can remove the assembly ifdefs.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/vic.c               |   17 +++++++++++++++++
 arch/arm/include/asm/hardware/vic.h |   23 ++---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index e4df17c..7431f47 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -35,6 +35,23 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
+#define VIC_IRQ_STATUS			0x00
+#define VIC_FIQ_STATUS			0x04
+#define VIC_INT_SELECT			0x0c	/* 1 = FIQ, 0 = IRQ */
+#define VIC_INT_SOFT			0x18
+#define VIC_INT_SOFT_CLEAR		0x1c
+#define VIC_PROTECT			0x20
+#define VIC_PL190_VECT_ADDR		0x30	/* PL190 only */
+#define VIC_PL190_DEF_VECT_ADDR		0x34	/* PL190 only */
+
+#define VIC_VECT_ADDR0			0x100	/* 0 to 15 (0..31 PL192) */
+#define VIC_VECT_CNTL0			0x200	/* 0 to 15 (0..31 PL192) */
+#define VIC_ITCR			0x300	/* VIC test control register */
+
+#define VIC_VECT_CNTL_ENABLE		(1 << 5)
+
+#define VIC_PL192_VECT_ADDR		0xF00
+
 /**
  * struct vic_device - VIC PM device
  * @irq: The IRQ number for the base of the VIC.
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index 2bebad3..a44ef71 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -20,29 +20,11 @@
 #ifndef __ASM_ARM_HARDWARE_VIC_H
 #define __ASM_ARM_HARDWARE_VIC_H
 
-#define VIC_IRQ_STATUS			0x00
-#define VIC_FIQ_STATUS			0x04
+#include <linux/types.h>
+
 #define VIC_RAW_STATUS			0x08
-#define VIC_INT_SELECT			0x0c	/* 1 = FIQ, 0 = IRQ */
 #define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
 #define VIC_INT_ENABLE_CLEAR		0x14
-#define VIC_INT_SOFT			0x18
-#define VIC_INT_SOFT_CLEAR		0x1c
-#define VIC_PROTECT			0x20
-#define VIC_PL190_VECT_ADDR		0x30	/* PL190 only */
-#define VIC_PL190_DEF_VECT_ADDR		0x34	/* PL190 only */
-
-#define VIC_VECT_ADDR0			0x100	/* 0 to 15 (0..31 PL192) */
-#define VIC_VECT_CNTL0			0x200	/* 0 to 15 (0..31 PL192) */
-#define VIC_ITCR			0x300	/* VIC test control register */
-
-#define VIC_VECT_CNTL_ENABLE		(1 << 5)
-
-#define VIC_PL192_VECT_ADDR		0xF00
-
-#ifndef __ASSEMBLY__
-#include <linux/compiler.h>
-#include <linux/types.h>
 
 struct device_node;
 struct pt_regs;
@@ -53,5 +35,4 @@ void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 r
 int vic_of_init(struct device_node *node, struct device_node *parent);
 void vic_handle_irq(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
 #endif
-- 
1.7.10.4
