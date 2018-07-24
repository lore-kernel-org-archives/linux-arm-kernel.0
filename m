From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2018 11:33:17 +0200
Subject: [PATCH] arm64: fix ACPI dependencies
Message-ID: <20180724093345.1575921-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kconfig reports a warning on x86 builds after the ARM64 dependency
was added.

drivers/acpi/Kconfig:6:error: recursive dependency detected!
drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI

This rephrases the dependency to keep the ARM64 details out of the
shared Kconfig file, so Kconfig no longer gets confused by it.

Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig   | 1 +
 drivers/acpi/Kconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cdcaa6a798b2..2f987a938405 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1267,6 +1267,7 @@ config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
 	depends on KERNEL_MODE_NEON
+	select ARCH_SUPPORTS_ACPI
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a8da730fabc6..0cda51c5d433 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || (ARM64 && EFI)
+	depends on IA64 || X86 || ARCH_SUPPORTS_ACPI
 	depends on PCI
 	select PNP
 	default y if (IA64 || X86)
@@ -41,6 +41,9 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0
