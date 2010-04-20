From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:48 +0300
Subject: [PATCH 2/8] arm: kdump: implement crash_setup_regs()
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <2fd2e3a694c1e1484a8c8bb8d8bc532dce85dea4.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement machine specific function crash_setup_regs() which is responsible for
storing machine state when crash occured.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/kexec.h |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index df15a0d..8df7e5f 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -19,10 +19,26 @@
 
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
+		__asm__ __volatile__ ("stmia %0, {r0 - r15}"
+				      : : "r" (&newregs->ARM_r0));
+		__asm__ __volatile__ ("mrs %0, cpsr"
+				      : "=r" (newregs->ARM_cpsr));
+	}
+}
 
 #endif /* __ASSEMBLY__ */
 
-- 
1.5.6.5
