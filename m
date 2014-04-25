From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Apr 2014 21:20:15 +0800
Subject: [PATCH v3 part1 09/11] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1398432017-8506-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfigs to build ACPI on ARM64, and make ACPI available on ARM64.

acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
depend on X86 || IA64, and implement it on ARM64 in the future.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig   |    2 ++
 drivers/acpi/Kconfig |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9c32702..834a74e7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -348,6 +348,8 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
+source "drivers/acpi/Kconfig"
+
 source "fs/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab686b3..ae45088 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -5,10 +5,10 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86
+	depends on IA64 || X86 || ARM64
 	depends on PCI
 	select PNP
-	default y
+	default y if !ARM64
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
 	  Linux requires an ACPI-compliant platform (hardware/firmware),
@@ -140,6 +140,7 @@ config ACPI_PROCESSOR
 	tristate "Processor"
 	select THERMAL
 	select CPU_IDLE
+	depends on X86 || IA64
 	default y
 	help
 	  This driver installs ACPI as the idle handler for Linux and uses
-- 
1.7.9.5
