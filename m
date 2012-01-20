From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:09 -0600
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
removed by converting platforms over to sparse irq.

This intentionally breaks platforms that enable SPARSE_IRQ.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/irq.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 5a526af..35c21c3 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -1,14 +1,18 @@
 #ifndef __ASM_ARM_IRQ_H
 #define __ASM_ARM_IRQ_H
 
+#define NR_IRQS_LEGACY	16
+
+#ifndef CONFIG_SPARSE_IRQ
 #include <mach/irqs.h>
+#else
+#define NR_IRQS NR_IRQS_LEGACY
+#endif
 
 #ifndef irq_canonicalize
 #define irq_canonicalize(i)	(i)
 #endif
 
-#define NR_IRQS_LEGACY	16
-
 /*
  * Use this value to indicate lack of interrupt
  * capability
-- 
1.7.5.4
