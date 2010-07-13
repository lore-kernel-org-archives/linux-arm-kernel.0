From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:18 +0800
Subject: [PATCH 03/13] [ARM] Define a default minimum NR_IRQS when SPARSE_IRQ
	is selected
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-4-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SPARSE_IRQ is selected, platforms should define their own number of
IRQs. A default minimum NR_IRQS is defined.  And #include <mach/irqs.h>
only when SPARSE_IRQ is not selected.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/irq.h |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 2721a58..bf1c42e 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARM_IRQ_H
 #define __ASM_ARM_IRQ_H
 
-#include <mach/irqs.h>
-
 #ifndef irq_canonicalize
 #define irq_canonicalize(i)	(i)
 #endif
@@ -10,6 +8,16 @@
 #define NR_IRQS_LEGACY	16
 
 /*
+ * A minimum NR_IRQS is defined when CONFIG_SPARSE_IRQ is enabled.
+ * And platforms should define their own number of IRQs.
+ */
+#ifdef CONFIG_SPARSE_IRQ
+#define NR_IRQS		(NR_IRQS_LEGACY)
+#else
+#include <mach/irqs.h>
+#endif
+
+/*
  * Use this value to indicate lack of interrupt
  * capability
  */
-- 
1.7.1
