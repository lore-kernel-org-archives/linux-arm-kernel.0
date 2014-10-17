From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Oct 2014 21:37:13 +0800
Subject: [PATCH v5 17/18] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1413553034-20956-18-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Add Kconfigs to build ACPI on ARM64, and make ACPI available on ARM64.

acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
depend on X86 || IA64, and implement it on ARM64 in the future.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig   |    2 ++
 drivers/acpi/Kconfig |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 065438c..8dabaeb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -422,6 +422,8 @@ source "drivers/Kconfig"
 
 source "drivers/firmware/Kconfig"
 
+source "drivers/acpi/Kconfig"
+
 source "fs/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d0f3265..f935d2e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -5,8 +5,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86
-	depends on PCI
+	depends on ((IA64 || X86) && PCI) || (ARM64 && EXPERT)
 	select PNP
 	default y
 	help
@@ -163,6 +162,7 @@ config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
 	select CPU_IDLE
+	depends on X86 || IA64
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux and uses
@@ -263,7 +263,7 @@ config ACPI_DEBUG
 
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
-	depends on SYSFS
+	depends on SYSFS && PCI
 	default n
 	help
 	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
-- 
1.7.9.5
