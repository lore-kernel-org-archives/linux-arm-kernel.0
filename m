From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 29 Aug 2013 15:55:40 +0100
Subject: [PATCH v6 3/5] ARM64: arch_timer: add support to configure and enable
 event stream
In-Reply-To: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1377788142-21388-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch adds support for configuring the event stream frequency
and enabling it.

It also adds the hwcaps as well as compat-specific definitions to
the user to detect this event stream feature.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm64/include/asm/arch_timer.h | 32 +++++++++++++++++++++++++++++---
 arch/arm64/include/asm/hwcap.h      | 11 ++++++-----
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/setup.c           | 11 +++++++++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index fa4af76..3bca364 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -97,21 +97,47 @@ static inline u32 arch_timer_get_cntfrq(void)
 	return val;
 }
 
-static inline void arch_counter_set_user_access(void)
+static inline u32 arch_timer_get_cntkctl(void)
 {
 	u32 cntkctl;
-
 	asm volatile("mrs	%0, cntkctl_el1" : "=r" (cntkctl));
+	return cntkctl;
+}
+
+static inline void arch_timer_set_cntkctl(u32 cntkctl)
+{
+	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
+}
+
+static inline void arch_counter_set_user_access(void)
+{
+	u32 cntkctl = arch_timer_get_cntkctl();
 
 	/* Disable user access to the timers and the physical counter */
+	/* Also disable virtual event stream */
 	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
 			| ARCH_TIMER_USR_VT_ACCESS_EN
+			| ARCH_TIMER_VIRT_EVT_EN
 			| ARCH_TIMER_USR_PCT_ACCESS_EN);
 
 	/* Enable user access to the virtual counter */
 	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
 
-	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
+	arch_timer_set_cntkctl(cntkctl);
+}
+
+static inline void arch_timer_evtstrm_enable(int divider)
+{
+	u32 cntkctl = arch_timer_get_cntkctl();
+	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
+	/* Set the divider and enable virtual event stream */
+	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
+			| ARCH_TIMER_VIRT_EVT_EN;
+	arch_timer_set_cntkctl(cntkctl);
+	elf_hwcap |= HWCAP_EVTSTRM;
+#ifdef CONFIG_COMPAT
+	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+#endif
 }
 
 static inline u64 arch_counter_get_cntvct(void)
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 6d4482f..3a48433 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -30,6 +30,7 @@
 #define COMPAT_HWCAP_IDIVA	(1 << 17)
 #define COMPAT_HWCAP_IDIVT	(1 << 18)
 #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
+#define COMPAT_HWCAP_EVTSTRM	(1 << 21)
 
 #ifndef __ASSEMBLY__
 /*
@@ -37,11 +38,11 @@
  * instruction set this cpu supports.
  */
 #define ELF_HWCAP		(elf_hwcap)
-#define COMPAT_ELF_HWCAP	(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
-				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
-				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
-				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
-				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
+
+#ifdef CONFIG_COMPAT
+#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
+extern unsigned int compat_elf_hwcap;
+#endif
 
 extern unsigned int elf_hwcap;
 #endif
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index eea4975..9b12476 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -21,6 +21,7 @@
  */
 #define HWCAP_FP		(1 << 0)
 #define HWCAP_ASIMD		(1 << 1)
+#define HWCAP_EVTSTRM		(1 << 2)
 
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..57cb006 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -60,6 +60,16 @@ EXPORT_SYMBOL(processor_id);
 unsigned int elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
+#ifdef CONFIG_COMPAT
+#define COMPAT_ELF_HWCAP_DEFAULT	\
+				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
+				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
+				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
+				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
+				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
+unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
+#endif
+
 static const char *cpu_name;
 static const char *machine_name;
 phys_addr_t __fdt_pointer __initdata;
@@ -309,6 +319,7 @@ subsys_initcall(topology_init);
 static const char *hwcap_str[] = {
 	"fp",
 	"asimd",
+	"evtstrm",
 	NULL
 };
 
-- 
1.8.1.2
