From: danielwa@cisco.com (Daniel Walker)
Date: Tue,  6 Oct 2015 08:47:12 -0700
Subject: [PATCH-RFC 5/7] arm: convert to generic builtin command line
Message-ID: <1444146434-12776-5-git-send-email-danielwa@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the arm 32bit code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-kernel at external.cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/arm/Kconfig              | 38 +-------------------------------------
 arch/arm/kernel/atags_parse.c | 14 ++++----------
 arch/arm/kernel/devtree.c     |  2 ++
 3 files changed, 7 insertions(+), 47 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..5a49e36 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select GENERIC_ALLOCATOR
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CMDLINE
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -1949,43 +1950,6 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 
 endchoice
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some architectures (EBSA110 and CATS), there is currently no way
-	  for the boot loader to pass arguments to the kernel. For these
-	  architectures, you should supply some command-line options at build
-	  time by entering them here. As a minimum, you should specify the
-	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
-	depends on ATAGS
-
-config CMDLINE_FROM_BOOTLOADER
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Uses the command-line options passed by the boot loader. If
-	  the boot loader doesn't provide any, the default kernel command
-	  string provided in CMDLINE will be used.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided by the boot loader will be
-	  appended to the default kernel command string.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-endchoice
-
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0..de2193e 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -23,6 +23,7 @@
 #include <linux/root_dev.h>
 #include <linux/screen_info.h>
 #include <linux/memblock.h>
+#include <linux/cmdline.h>
 
 #include <asm/setup.h>
 #include <asm/system_info.h>
@@ -31,7 +32,7 @@
 
 #include "atags.h"
 
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
+static char default_command_line[COMMAND_LINE_SIZE] __initdata;
 
 #ifndef MEM_SIZE
 #define MEM_SIZE	(16*1024*1024)
@@ -125,16 +126,9 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
 	strlcat(default_command_line, tag->u.cmdline.cmdline,
 		COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
-#else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#endif
+
 	return 0;
 }
 
@@ -232,7 +226,7 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 	}
 
 	/* parse_early_param needs a boot_command_line */
-	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	cmdline_add_builtin(boot_command_line, from, COMMAND_LINE_SIZE);
 
 	return mdesc;
 }
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..d0277b5 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
+#include <linux/cmdline.h>
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -242,6 +243,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		mdesc->dt_fixup();
 
 	early_init_dt_scan_nodes();
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
 
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
-- 
2.1.4
