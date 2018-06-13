From: geoff@infradead.org (Geoff Levand)
Date: Wed, 13 Jun 2018 11:22:30 -0700
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
Message-ID: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new ACPI init routine acpi_fixup_m400_quirks that adds
a work-around for HPE ProLiant m400 APEI firmware problems.

The work-around disables APEI when CONFIG_ACPI_APEI is set and
m400 firmware is detected.  Without this fixup m400 systems
experience errors like these on startup:

  [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
  [Hardware Error]: event severity: fatal
  [Hardware Error]:  Error 0, type: fatal
  [Hardware Error]:   section_type: memory error
  [Hardware Error]:   error_status: 0x0000000000001300
  [Hardware Error]:   error_type: 10, invalid address
  Kernel panic - not syncing: Fatal hardware error!

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi,

It seems unlikely there will be any m400 firmware updates to fix
this problem.  APEI support is desired for new ARM64 servers coming
to market.  Distros are now forced to have their own fixes, not
enable APEI, or let m400 users fend for themselves.

Please consider.

-Geoff

 arch/arm64/kernel/acpi.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7b09487ff8fb..3c315c2c7476 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -31,6 +31,8 @@
 #include <asm/cpu_ops.h>
 #include <asm/smp_plat.h>
 
+#include <acpi/apei.h>
+
 #ifdef CONFIG_ACPI_APEI
 # include <linux/efi.h>
 # include <asm/pgtable.h>
@@ -177,6 +179,33 @@ static int __init acpi_fadt_sanity_check(void)
 	return ret;
 }
 
+/*
+ * acpi_fixup_m400_quirks - Work-around for HPE ProLiant m400 APEI firmware
+ * problems.
+ */
+static void __init acpi_fixup_m400_quirks(void)
+{
+	acpi_status status;
+	struct acpi_table_header *header;
+#if !defined(CONFIG_ACPI_APEI)
+	int hest_disable = HEST_DISABLED;
+#endif
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI) || hest_disable != HEST_ENABLED)
+		return;
+
+	status = acpi_get_table(ACPI_SIG_HEST, 0, &header);
+
+	if (ACPI_SUCCESS(status) && !strncmp(header->oem_id, "HPE   ", 6) &&
+		!strncmp(header->oem_table_id, "ProLiant", 8) &&
+		MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
+		hest_disable = HEST_DISABLED;
+		pr_info("Disabled APEI for m400.\n");
+	}
+
+	acpi_put_table(header);
+}
+
 /*
  * acpi_boot_table_init() called from setup_arch(), always.
  *	1. find RSDP and get its address, and then find XSDT
@@ -232,11 +261,14 @@ void __init acpi_boot_table_init(void)
 	if (acpi_disabled) {
 		if (earlycon_acpi_spcr_enable)
 			early_init_dt_scan_chosen_stdout();
-	} else {
-		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
-		if (IS_ENABLED(CONFIG_ACPI_BGRT))
-			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+		return;
 	}
+
+	acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+	if (IS_ENABLED(CONFIG_ACPI_BGRT))
+		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+
+	acpi_fixup_m400_quirks();
 }
 
 #ifdef CONFIG_ACPI_APEI
-- 
2.14.1
