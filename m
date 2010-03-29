From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:28 +0300
Subject: [RFC 02/10] arm: kdump: implement crash_setup_regs()
In-Reply-To: <7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement machine specific function crash_setup_regs() which is responsible for
storing machine state when crash occured.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/kexec.h |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index df15a0d..4a4b66f 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -19,10 +19,39 @@
 
 #ifndef __ASSEMBLY__
 
-struct kimage;
-/* Provide a dummy definition to avoid build failures. */
+/*
+ * crash_setup_regs() - save registers for the panic kernel
+ * @newregs: registers are saved here
+ * @oldregs: registers to be saved (may be %NULL)
+ *
+ * Function copies machine registers from @oldregs to @newregs. If @oldregs is
+ * %NULL then current registers are stored there.
+ */
 static inline void crash_setup_regs(struct pt_regs *newregs,
-                                        struct pt_regs *oldregs) { }
+				    struct pt_regs *oldregs)
+{
+	if (oldregs) {
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	} else {
+		__asm__ __volatile__("mov %0, r0" : "=r"(newregs->ARM_r0));
+		__asm__ __volatile__("mov %0, r1" : "=r"(newregs->ARM_r1));
+		__asm__ __volatile__("mov %0, r2" : "=r"(newregs->ARM_r2));
+		__asm__ __volatile__("mov %0, r3" : "=r"(newregs->ARM_r3));
+		__asm__ __volatile__("mov %0, r4" : "=r"(newregs->ARM_r4));
+		__asm__ __volatile__("mov %0, r5" : "=r"(newregs->ARM_r5));
+		__asm__ __volatile__("mov %0, r6" : "=r"(newregs->ARM_r6));
+		__asm__ __volatile__("mov %0, r7" : "=r"(newregs->ARM_r7));
+		__asm__ __volatile__("mov %0, r8" : "=r"(newregs->ARM_r8));
+		__asm__ __volatile__("mov %0, r9" : "=r"(newregs->ARM_r9));
+		__asm__ __volatile__("mov %0, r10" : "=r"(newregs->ARM_r10));
+		__asm__ __volatile__("mov %0, r11" : "=r"(newregs->ARM_fp));
+		__asm__ __volatile__("mov %0, r12" : "=r"(newregs->ARM_ip));
+		__asm__ __volatile__("mov %0, r13" : "=r"(newregs->ARM_sp));
+		__asm__ __volatile__("mov %0, r14" : "=r"(newregs->ARM_lr));
+		__asm__ __volatile__("mov %0, r15" : "=r"(newregs->ARM_pc));
+		__asm__ __volatile__("mrs %0, cpsr" : "=r"(newregs->ARM_cpsr));
+	}
+}
 
 #endif /* __ASSEMBLY__ */
 
-- 
1.5.6.5
