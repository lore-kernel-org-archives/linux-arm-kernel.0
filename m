From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  1 Sep 2014 22:57:41 +0800
Subject: [PATCH v3 03/17] ARM64 / ACPI: Introduce lowlevel suspend function
In-Reply-To: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1409583475-6978-4-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

acpi_wakeup_address is used on x86 as the address bios jumps into
when machine wakes up from suspend. As arm64 does not have such a
bios this mechanism will be provided by other means. But the define
is still required inside the acpi core.

Introduce a null stub for acpi_suspend_lowlevel as this is also
required by core. This will be filled in when standards are
defined for arm64 ACPI global power states.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h |   12 ++++++++++++
 arch/arm64/kernel/acpi.c      |    7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 8b837ab..02bbb0b 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -40,6 +40,18 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
+/* Low-level suspend routine.
+ *
+ * ACPI S-states for ARM64 have to be defined
+ * and approved before doing anything else, maybe
+ * we need update the ACPI spec, here we
+ * just introduce function and macro needed by
+ * ACPI core as IA64 did, and revisit them when
+ * the spec is ready.
+ */
+extern int (*acpi_suspend_lowlevel)(void);
+#define acpi_wakeup_address 0
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 9252f72..b6940a0 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -67,3 +67,10 @@ void __init acpi_boot_table_init(void)
 	if (acpi_table_init())
 		disable_acpi();
 }
+
+/*
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
+ *
+ * TBD when ARM/ARM64 starts to support suspend...
+ */
+int (*acpi_suspend_lowlevel)(void) = NULL;
-- 
1.7.9.5
