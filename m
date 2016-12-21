From: jtoppins@redhat.com (Jonathan Toppins)
Date: Wed, 21 Dec 2016 12:54:05 -0500
Subject: [RFC] arm64/acpi: make ACPI boot preference configurable
Message-ID: <7eba0601099f75f19021c4259eca75ada06f4511.1482341997.git.jtoppins@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows a user to configure ACPI to be preferred over
device-tree.

Currently for ACPI to be used a user either has to set acpi=on on the
kernel command line or make sure any device tree passed to the kernel
is empty. If the dtb passed to the kernel is non-empty then device-tree
will be chosen as the boot method of choice even if it is not correct.
To prevent this situation where a system is only intended to be booted
via ACPI a user can set this kernel configuration so it ignores
device-tree settings unless ACPI table checks fail.

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---
 arch/arm64/Kconfig       | 13 +++++++++++++
 arch/arm64/kernel/acpi.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 111742126897..e432e84245b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -954,6 +954,19 @@ config ARM64_ACPI_PARKING_PROTOCOL
 	  protocol even if the corresponding data is present in the ACPI
 	  MADT table.
 
+config ARM64_PREFER_ACPI
+	bool "Prefer usage of ACPI boot tables over device-tree"
+	depends on ACPI
+	help
+	  Normally device-tree is preferred over ACPI on arm64 unless
+	  explicitly preferred via kernel command line, something like: acpi=on
+	  This configuration changes this default behaviour by pretending
+	  the user set acpi=on on the command line. This configuration still
+	  allows the user to turn acpi table parsing off via acpi=off. If
+	  for some reason the table checks fail the system will still fall
+	  back to using device-tree unless the user explicitly sets acpi=force
+	  on the command line.
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 252a6d9c1da5..b5dfa5752ff7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -43,7 +43,7 @@ int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
 static bool param_acpi_off __initdata;
-static bool param_acpi_on __initdata;
+static bool param_acpi_on __initdata = IS_ENABLED(CONFIG_ARM64_PREFER_ACPI);
 static bool param_acpi_force __initdata;
 
 static int __init parse_acpi(char *arg)
-- 
2.10.2
