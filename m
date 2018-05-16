From: james.morse@arm.com (James Morse)
Date: Wed, 16 May 2018 17:28:26 +0100
Subject: [PATCH v4 09/12] firmware: arm_sdei: Add ACPI GHES registration helper
In-Reply-To: <20180516162829.14348-1-james.morse@arm.com>
References: <20180516162829.14348-1-james.morse@arm.com>
Message-ID: <20180516162829.14348-10-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APEI's Generic Hardware Error Source structures do not describe
whether the SDEI event is shared or private, as this information is
discoverable via the API.

GHES needs to know whether an event is normal or critical to avoid
sharing locks or fixmap entries.

Add a helper to ask firmware for this information so it can initialise
the struct ghes and register then enable the event.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
---
Changes since v3:
 * Removed acpi_disabled() checks that aren't necessary after v2s #ifdef
   change.

Changes since v2:
 * Added header file, thanks kbuild-robot!
 * changed ifdef to the GHES version to match the fixmap definition

Changes since v1:
 * ghes->fixmap_idx variable rename

 arch/arm64/include/asm/fixmap.h |  4 +++
 drivers/firmware/arm_sdei.c     | 67 +++++++++++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |  5 +++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index c3974517c2cb..e2b423a5feaf 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -58,6 +58,10 @@ enum fixed_addresses {
 #ifdef CONFIG_ACPI_APEI_SEA
 	FIX_APEI_GHES_SEA,
 #endif
+#ifdef CONFIG_ARM_SDE_INTERFACE
+	FIX_APEI_GHES_SDEI_NORMAL,
+	FIX_APEI_GHES_SDEI_CRITICAL,
+#endif
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1ea71640fdc2..7c304ebb6282 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2017 Arm Ltd.
 #define pr_fmt(fmt) "sdei: " fmt
 
+#include <acpi/ghes.h>
 #include <linux/acpi.h>
 #include <linux/arm_sdei.h>
 #include <linux/arm-smccc.h>
@@ -32,6 +33,8 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
+#include <asm/fixmap.h>
+
 /*
  * The call to use to reach the firmware.
  */
@@ -887,6 +890,70 @@ static void sdei_smccc_hvc(unsigned long function_id,
 	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
 }
 
+#ifdef CONFIG_ACPI_APEI_GHES
+static DEFINE_GHES_NMI_FIXMAP(sde_normal, FIX_APEI_GHES_SDEI_NORMAL);
+static DEFINE_GHES_NMI_FIXMAP(sde_critical, FIX_APEI_GHES_SDEI_CRITICAL);
+
+int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *cb)
+{
+	int err;
+	u32 event_num;
+	u64 result;
+
+	event_num = ghes->generic->notify.vector;
+	if (event_num == 0) {
+		/*
+		 * Event 0 is reserved by the specification for
+		 * SDEI_EVENT_SIGNAL.
+		 */
+		return -EINVAL;
+	}
+
+	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
+				      &result);
+	if (err)
+		return err;
+
+	if (result == SDEI_EVENT_PRIORITY_CRITICAL)
+		ghes->nmi_fixmap = &sde_critical;
+	else
+		ghes->nmi_fixmap = &sde_normal;
+
+	err = sdei_event_register(event_num, cb, ghes);
+	if (!err)
+		err = sdei_event_enable(event_num);
+
+	return err;
+}
+
+int sdei_unregister_ghes(struct ghes *ghes)
+{
+	int i;
+	int err;
+	u32 event_num = ghes->generic->notify.vector;
+
+	might_sleep();
+
+	/*
+	 * The event may be running on another CPU. Disable it
+	 * to stop new events, then try to unregister a few times.
+	 */
+	err = sdei_event_disable(event_num);
+	if (err)
+		return err;
+
+	for (i = 0; i < 3; i++) {
+		err = sdei_event_unregister(event_num);
+		if (err != -EINPROGRESS)
+			break;
+
+		schedule();
+	}
+
+	return err;
+}
+#endif /* CONFIG_ACPI_APEI_GHES */
+
 static int sdei_get_conduit(struct platform_device *pdev)
 {
 	const char *method;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 942afbd544b7..5fdf799be026 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -11,6 +11,7 @@ enum sdei_conduit_types {
 	CONDUIT_HVC,
 };
 
+#include <acpi/ghes.h>
 #include <asm/sdei.h>
 
 /* Arch code should override this to set the entry point from firmware... */
@@ -39,6 +40,10 @@ int sdei_event_unregister(u32 event_num);
 int sdei_event_enable(u32 event_num);
 int sdei_event_disable(u32 event_num);
 
+/* GHES register/unregister helpers */
+int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *cb);
+int sdei_unregister_ghes(struct ghes *ghes);
+
 #ifdef CONFIG_ARM_SDE_INTERFACE
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
-- 
2.16.2
