From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Aug 2012 14:50:59 +0100
Subject: [PATCH v2] ARM: io: avoid writeback addressing modes for __raw_
 accessors
Message-ID: <1345557059-6922-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Data aborts taken to hyp mode do not provide a valid instruction
syndrome field in the HSR if the faulting instruction is a memory
access using a writeback addressing mode.

For hypervisors emulating MMIO accesses to virtual peripherals, taking
such an exception requires disassembling the faulting instruction in
order to determine the behaviour of the access. Since this requires
manually walking the two stages of translation, the world must be
stopped to prevent races against page aging in the guest, where the
first-stage translation is invalidated after the hypervisor has
translated to an IPA and the physical page is reused for something else.

This patch avoids taking this heavy performance penalty when running
Linux as a guest by ensuring that our I/O accessors do not make use of
writeback addressing modes.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Changes since v1:
	- Use "Qo" to allow for pre-indexing addressing modes

 arch/arm/include/asm/io.h |   67 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815c669..09c4628 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -47,13 +47,68 @@ extern void __raw_readsb(const void __iomem *addr, void *data, int bytelen);
 extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
 extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
-#define __raw_writeb(v,a)	((void)(__chk_io_ptr(a), *(volatile unsigned char __force  *)(a) = (v)))
-#define __raw_writew(v,a)	((void)(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v)))
-#define __raw_writel(v,a)	((void)(__chk_io_ptr(a), *(volatile unsigned int __force   *)(a) = (v)))
+#if __LINUX_ARM_ARCH__ < 6
+/*
+ * Half-word accesses are problematic with RiscPC due to limitations of
+ * the bus. Rather than special-case the machine, just let the compiler
+ * generate the access for CPUs prior to ARMv6.
+ */
+#define __raw_readw(a)         (__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
+#define __raw_writew(v,a)      ((void)(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v)))
+#else
+/*
+ * When running under a hypervisor, we want to avoid I/O accesses with
+ * writeback addressing modes as these incur a significant performance
+ * overhead (the address generation must be emulated in software).
+ */
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	asm volatile("strh %1, %0"
+		     : "+Qo" (*(volatile u16 __force *)addr)
+		     : "r" (val));
+}
+
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	u16 val;
+	asm volatile("ldrh %1, %0"
+		     : "+Qo" (*(volatile u16 __force *)addr),
+		       "=r" (val));
+	return val;
+}
+#endif
 
-#define __raw_readb(a)		(__chk_io_ptr(a), *(volatile unsigned char __force  *)(a))
-#define __raw_readw(a)		(__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
-#define __raw_readl(a)		(__chk_io_ptr(a), *(volatile unsigned int __force   *)(a))
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+	asm volatile("strb %1, %0"
+		     : "+Qo" (*(volatile u8 __force *)addr)
+		     : "r" (val));
+}
+
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("str %1, %0"
+		     : "+Qo" (*(volatile u32 __force *)addr)
+		     : "r" (val));
+}
+
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	u8 val;
+	asm volatile("ldrb %1, %0"
+		     : "+Qo" (*(volatile u8 __force *)addr),
+		       "=r" (val));
+	return val;
+}
+
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	u32 val;
+	asm volatile("ldr %1, %0"
+		     : "+Qo" (*(volatile u32 __force *)addr),
+		       "=r" (val));
+	return val;
+}
 
 /*
  * Architecture ioremap implementation.
-- 
1.7.4.1
