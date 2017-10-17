From: james.morse@arm.com (James Morse)
Date: Tue, 17 Oct 2017 18:44:31 +0100
Subject: [PATCH v4 12/13] arm64: acpi: Remove __init from acpi_psci_use_hvc()
 for use by SDEI
In-Reply-To: <20171017174432.1684-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
Message-ID: <20171017174432.1684-13-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDEI inherits the 'use hvc' bit that is also used by PSCI. PSCI does all
its initialisation early, SDEI does its late.

Remove the __init annotation from acpi_psci_use_hvc().

Signed-off-by: James Morse <james.morse@arm.com>

---
The function name is unchanged as this bit is named 'PSCI_USE_HVC'
in table 5-37 of ACPIv6.2.

 arch/arm64/kernel/acpi.c | 2 +-
 include/linux/psci.h     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b3162715ed78..252396a96c78 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -117,7 +117,7 @@ bool __init acpi_psci_present(void)
 }
 
 /* Whether HVC must be used instead of SMC as the PSCI conduit */
-bool __init acpi_psci_use_hvc(void)
+bool acpi_psci_use_hvc(void)
 {
 	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
 }
diff --git a/include/linux/psci.h b/include/linux/psci.h
index bdea1cb5e1db..e25a99992a82 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -46,10 +46,11 @@ static inline int psci_dt_init(void) { return 0; }
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
 int __init psci_acpi_init(void);
 bool __init acpi_psci_present(void);
-bool __init acpi_psci_use_hvc(void);
+bool acpi_psci_use_hvc(void);
 #else
 static inline int psci_acpi_init(void) { return 0; }
 static inline bool acpi_psci_present(void) { return false; }
+static inline bool acpi_psci_use_hvc(void) {return false; }
 #endif
 
 #endif /* __LINUX_PSCI_H */
-- 
2.13.3
