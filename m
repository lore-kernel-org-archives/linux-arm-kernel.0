From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 24 Aug 2013 12:35:30 -0300
Subject: [PATCH v4 2/4] ARM: Add atomic_io_modify optimized routines
In-Reply-To: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377358532-23802-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement arch-specific atomic_io_modify and atomic_io_modify_relaxed,
which are based on writel/readl_relaxed and writel_relaxed/readl_relaxed,
respectively.
In both cases, by relaxing the readl, perfomance can be improved.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/include/asm/io.h |  4 ++++
 arch/arm/kernel/io.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d070741..53637b6 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -397,5 +397,9 @@ extern int devmem_is_allowed(unsigned long pfn);
 extern void register_isa_ports(unsigned int mmio, unsigned int io,
 			       unsigned int io_shift);
 
+#define __HAVE_ARCH_ATOMIC_IO_MODIFY
+extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
+extern void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set);
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_ARM_IO_H */
diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index dcd5b4d..a8c9c9b 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -1,6 +1,35 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
+
+static DEFINE_RAW_SPINLOCK(__io_lock);
+
+void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&__io_lock, flags);
+	value = readl_relaxed(reg) & ~mask;
+	value |= (set & mask);
+	writel_relaxed(value, reg);
+	raw_spin_unlock_irqrestore(&__io_lock, flags);
+}
+EXPORT_SYMBOL(atomic_io_modify_relaxed);
+
+void atomic_io_modify(void __iomem *reg, u32 mask, u32 set)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&__io_lock, flags);
+	value = readl_relaxed(reg) & ~mask;
+	value |= (set & mask);
+	writel(value, reg);
+	raw_spin_unlock_irqrestore(&__io_lock, flags);
+}
+EXPORT_SYMBOL(atomic_io_modify);
 
 /*
  * Copy data from IO memory space to "real" memory space.
-- 
1.8.1.5
