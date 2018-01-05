From: will.deacon@arm.com (Will Deacon)
Date: Fri,  5 Jan 2018 13:12:35 +0000
Subject: [PATCH v2 05/11] drivers/firmware: Expose psci_get_version through
 psci_ops structure
In-Reply-To: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
Message-ID: <1515157961-20963-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Entry into recent versions of ARM Trusted Firmware will invalidate the CPU
branch predictor state in order to protect against aliasing attacks.

This patch exposes the PSCI "VERSION" function via psci_ops, so that it
can be invoked outside of the PSCI driver where necessary.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/firmware/psci.c | 2 ++
 include/linux/psci.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index d687ca3d5049..8b25d31e8401 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -496,6 +496,8 @@ static void __init psci_init_migrate(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_ops.get_version = psci_get_version;
+
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index bdea1cb5e1db..6306ab10af18 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -26,6 +26,7 @@ int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
 struct psci_operations {
+	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
-- 
2.1.4
