From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 29 Apr 2015 08:44:08 -0500
Subject: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
In-Reply-To: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From ACPIv6 (http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf),
section 6.2.17 _CCA states that ARM platforms require ACPI _CCA object to be
specified for DMA-cabpable devices. This patch introduces ACPI_MUST_HAVE_CCA
in arm and arm64 Kconfig to specify such requirement.

Note that when _CCA is required, if it is missing in the DSDT. ACPI driver
will default to setting up devices as non-coherent.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm/Kconfig     | 1 +
 arch/arm64/Kconfig   | 1 +
 drivers/acpi/Kconfig | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..2a0d036 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ACPI_MUST_HAVE_CCA if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4269dba..e5471f8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,7 @@
 config ARM64
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MUST_HAVE_CCA if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb5..620ee67 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -54,6 +54,9 @@ config ACPI_GENERIC_GSI
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
 
+config ACPI_MUST_HAVE_CCA
+	bool
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
-- 
2.1.0
