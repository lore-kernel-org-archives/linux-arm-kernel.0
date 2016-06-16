From: geoff@infradead.org (Geoff Levand)
Date: Thu, 16 Jun 2016 23:48:27 +0000
Subject: [PATCH v19 01/13] arm64: Add cpus_are_stuck_in_kernel
In-Reply-To: <cover.1466120418.git.geoff@infradead.org>
References: <cover.1466120418.git.geoff@infradead.org>
Message-ID: <b8820595fdc768f4d321fb9eeb178a0b0c1cf3f7.1466120418.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

kernel/smp.c has a fancy counter that keeps track of the number of CPUs
it marked as not-present and left in cpu_park_loop(). If there are any
CPUs spinning in here, kexec will release them once the memory is re-used
by the new kernel.

Provide a function to expose whether this counter is non-zero, so we can
use this when loading a new kexec image, and when calling machine_kexec().

Signed-off-by: James Morse <james.morse@arm.com>
[Split off from a larger patch]
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/smp.h | 10 ++++++++++
 arch/arm64/kernel/smp.c      |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 433e504..38712f4 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -124,6 +124,16 @@ static inline void cpu_panic_kernel(void)
 	cpu_park_loop();
 }
 
+/*
+ * If a secondary CPU fails to come online, (e.g. due to mismatched features),
+ * it will try to call cpu_die(). If this fails, it updates
+ * cpus_stuck_in_kernel and sits in cpu_park_loop().
+ *
+ * Kexec checks this counter and refuses to load/kexec if it is non-zero, as
+ * cpu_park_loop() would be overwritten releasing the parked cpus.
+ */
+bool cpus_are_stuck_in_kernel(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 678e084..d0bcd55 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -909,3 +909,8 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+bool cpus_are_stuck_in_kernel(void)
+{
+	return !!cpus_stuck_in_kernel;
+}
-- 
2.5.0
