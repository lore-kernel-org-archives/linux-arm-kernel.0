From: james.morse@arm.com (James Morse)
Date: Tue, 17 Oct 2017 18:44:32 +0100
Subject: [PATCH v4 13/13] firmware: arm_sdei: Discover SDEI support via ACPI
In-Reply-To: <20171017174432.1684-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
Message-ID: <20171017174432.1684-14-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDEI defines a new ACPI table to indicate the presence of the interface.
The conduit is discovered in the same way as PSCI.

For ACPI we need to create the platform device ourselves as SDEI doesn't
have an entry in the DSDT.

The SDEI platform device should be created after ACPI has been initialised
so that we can parse the table, but before GHES devices are created, which
may register SDE events if they use SDEI as their notification type.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 5598d9ba8b5d..f764f48144c2 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -911,6 +911,14 @@ static int sdei_get_conduit(struct platform_device *pdev)
 		}
 
 		pr_warn("invalid \"method\" property: %s\n", method);
+	} else if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled) {
+		if (acpi_psci_use_hvc()) {
+			sdei_firmware_call = &sdei_smccc_hvc;
+			return CONDUIT_HVC;
+		} else {
+			sdei_firmware_call = &sdei_smccc_smc;
+			return CONDUIT_SMC;
+		}
 	}
 
 	return CONDUIT_INVALID;
@@ -1024,14 +1032,45 @@ static bool __init sdei_present_dt(void)
 	return true;
 }
 
+static bool __init sdei_present_acpi(void)
+{
+	acpi_status status;
+	struct platform_device *pdev;
+	struct acpi_table_header *sdei_table_header;
+
+	if (acpi_disabled)
+		return false;
+
+	status = acpi_get_table(ACPI_SIG_SDEI, 0, &sdei_table_header);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_info("Failed to get ACPI:SDEI table, %s\n", msg);
+	}
+	if (ACPI_FAILURE(status))
+		return false;
+
+	pdev = platform_device_register_simple(sdei_driver.driver.name, 0, NULL,
+					       0);
+	if (IS_ERR(pdev))
+		return false;
+
+	return true;
+}
+
 static int __init sdei_init(void)
 {
-	if (sdei_present_dt())
+	if (sdei_present_dt() || sdei_present_acpi())
 		platform_driver_register(&sdei_driver);
 
 	return 0;
 }
 
+/*
+ * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
+ * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
+ * by device_initcall(). We want to be called in the middle.
+ */
 subsys_initcall_sync(sdei_init);
 
 int sdei_event_handler(struct pt_regs *regs,
-- 
2.13.3
