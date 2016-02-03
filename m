From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Feb 2016 18:00:13 +0000
Subject: [PATCH v3 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the kernel is running in HYP (with VHE), it is necessary to
include EL2 events if the user requests counting kernel or
hypervisor events.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/perf_event.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f7ab14c..6013a38 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -20,6 +20,7 @@
  */
 
 #include <asm/irq_regs.h>
+#include <asm/virt.h>
 
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
@@ -693,10 +694,15 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 		return -EPERM;
 	if (attr->exclude_user)
 		config_base |= ARMV8_EXCLUDE_EL0;
-	if (attr->exclude_kernel)
-		config_base |= ARMV8_EXCLUDE_EL1;
-	if (!attr->exclude_hv)
-		config_base |= ARMV8_INCLUDE_EL2;
+	if (is_kernel_in_hyp_mode()) {
+		if (!attr->exclude_kernel || !attr->exclude_hv)
+			config_base |= ARMV8_INCLUDE_EL2;
+	} else {
+		if (attr->exclude_kernel)
+			config_base |= ARMV8_EXCLUDE_EL1;
+		if (!attr->exclude_hv)
+			config_base |= ARMV8_INCLUDE_EL2;
+	}
 
 	/*
 	 * Install the filter into config_base as this is used to
-- 
2.1.4
