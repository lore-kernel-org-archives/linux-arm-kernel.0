From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 21:00:09 +0800
Subject: [PATCH 03/19] ARM64 / ACPI: Introduce lowlevel suspend function
In-Reply-To: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206825-15590-4-git-send-email-hanjun.guo@linaro.org>
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

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h |   12 ++++++++++++
 arch/arm64/kernel/acpi.c      |    7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index e8581ea..44b617f 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -36,6 +36,18 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return 1;
 }
 
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
index ac78e4e..f5a10b5 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -95,3 +95,10 @@ static int __init parse_acpi(char *arg)
 	return 0;
 }
 early_param("acpi", parse_acpi);
+
+/*
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
+ *
+ * TBD when ARM/ARM64 starts to support suspend...
+ */
+int (*acpi_suspend_lowlevel)(void);
-- 
1.7.9.5
