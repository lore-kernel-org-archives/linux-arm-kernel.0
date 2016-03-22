From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 22 Mar 2016 13:46:31 +0300
Subject: [PATCH v5 4/6] ACPI: enable ACPI_SPCR_TABLE on ARM64
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1458643595-14719-5-git-send-email-aleksey.makarov@linaro.org>
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
 arch/arm64/kernel/acpi.c | 2 ++
 2 files changed, 3 insertions(+)

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
index d1ce8e2..36d6f70 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -208,6 +208,8 @@ void __init acpi_boot_table_init(void)
 		pr_err("Failed to init ACPI tables\n");
 		if (!param_acpi_force)
 			disable_acpi();
+	} else {
+		parse_spcr();
 	}
 }
 
-- 
2.7.4
