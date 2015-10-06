From: danielwa@cisco.com (Daniel Walker)
Date: Tue,  6 Oct 2015 08:47:14 -0700
Subject: [PATCH-RFC 7/7] arm64: convert to generic builtin command line
Message-ID: <1444146434-12776-7-git-send-email-danielwa@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the arm64 code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-kernel at external.cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/arm64/Kconfig        | 17 +----------------
 arch/arm64/kernel/setup.c |  3 +++
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..a17226f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select GENERIC_CMDLINE
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -625,22 +626,6 @@ endmenu
 
 menu "Boot options"
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  Provide a set of default command-line options at build time by
-	  entering them here. As a minimum, you should specify the the
-	  root device (e.g. root=/dev/nfs).
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EFI_STUB
 	bool
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 6bab21f..bb88102 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -46,6 +46,7 @@
 #include <linux/efi.h>
 #include <linux/personality.h>
 #include <linux/psci.h>
+#include <linux/cmdline.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -418,6 +419,8 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_machine_fdt(__fdt_pointer);
 
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
+
 	parse_early_param();
 
 	/*
-- 
2.1.4
