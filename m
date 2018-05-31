From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 18:32:23 +0100
Subject: [PATCHv2 4/4] firmware: arm_sdei: use common SMCCC_CONDUIT_*
In-Reply-To: <20180531173223.9668-1-mark.rutland@arm.com>
References: <20180531173223.9668-1-mark.rutland@arm.com>
Message-ID: <20180531173223.9668-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common definitions for SMCCC conduits, move the SDEI
code over to them, and remove the SDEI-specific definitions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: James Morse <james.morse@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sdei.c    |  3 ++-
 drivers/firmware/arm_sdei.c | 12 ++++++------
 include/linux/arm_sdei.h    |  6 ------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 6b8d90d5ceae..a3be67ae8a88 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2017 Arm Ltd.
 #define pr_fmt(fmt) "sdei: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/arm_sdei.h>
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
@@ -125,7 +126,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 			return 0;
 	}
 
-	sdei_exit_mode = (conduit == CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
+	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	if (arm64_kernel_unmapped_at_el0()) {
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1ea71640fdc2..1357dbd7c7fc 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -896,29 +896,29 @@ static int sdei_get_conduit(struct platform_device *pdev)
 	if (np) {
 		if (of_property_read_string(np, "method", &method)) {
 			pr_warn("missing \"method\" property\n");
-			return CONDUIT_INVALID;
+			return SMCCC_CONDUIT_NONE;
 		}
 
 		if (!strcmp("hvc", method)) {
 			sdei_firmware_call = &sdei_smccc_hvc;
-			return CONDUIT_HVC;
+			return SMCCC_CONDUIT_HVC;
 		} else if (!strcmp("smc", method)) {
 			sdei_firmware_call = &sdei_smccc_smc;
-			return CONDUIT_SMC;
+			return SMCCC_CONDUIT_SMC;
 		}
 
 		pr_warn("invalid \"method\" property: %s\n", method);
 	} else if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled) {
 		if (acpi_psci_use_hvc()) {
 			sdei_firmware_call = &sdei_smccc_hvc;
-			return CONDUIT_HVC;
+			return SMCCC_CONDUIT_HVC;
 		} else {
 			sdei_firmware_call = &sdei_smccc_smc;
-			return CONDUIT_SMC;
+			return SMCCC_CONDUIT_SMC;
 		}
 	}
 
-	return CONDUIT_INVALID;
+	return SMCCC_CONDUIT_NONE;
 }
 
 static int sdei_probe(struct platform_device *pdev)
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 942afbd544b7..21e337d99fa6 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -5,12 +5,6 @@
 
 #include <uapi/linux/arm_sdei.h>
 
-enum sdei_conduit_types {
-	CONDUIT_INVALID = 0,
-	CONDUIT_SMC,
-	CONDUIT_HVC,
-};
-
 #include <asm/sdei.h>
 
 /* Arch code should override this to set the entry point from firmware... */
-- 
2.11.0
