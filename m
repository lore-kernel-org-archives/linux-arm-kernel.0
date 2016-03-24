From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 24 Mar 2016 15:52:02 +0300
Subject: [PATCH v6 4/5] ACPI: enable ACPI_SPCR_TABLE on ARM64
In-Reply-To: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1458823925-19560-5-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64

Earlycon should be set up as early as possible.  ACPI boot tables are
mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from
setup_arch() and that's where we parse SPCR.  So it has to be opted-in
per-arch.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig       | 1 +
 arch/arm64/kernel/acpi.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07b6a16..c77b4b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..046f095 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -189,7 +189,7 @@ void __init acpi_boot_table_init(void)
 	 */
 	if (param_acpi_off ||
 	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
-		return;
+		goto done;
 
 	/*
 	 * ACPI is disabled at this point. Enable it in order to parse
@@ -209,6 +209,9 @@ void __init acpi_boot_table_init(void)
 		if (!param_acpi_force)
 			disable_acpi();
 	}
+
+done:
+	parse_spcr();
 }
 
 #ifdef CONFIG_ACPI_APEI
-- 
2.7.4
