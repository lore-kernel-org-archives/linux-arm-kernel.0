From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 18 Nov 2015 12:28:05 +0300
Subject: [PATCH] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <1447838885-9888-1-git-send-email-p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an option to extend built-in command line with one obtained from
the device tree.

This option is very useful for, for example, switching between some
stable and development version, when one of them requires additional
arguments (e. g. to turn on some extra debug). It can be annoying to
reprogram command line in the bootloaded every time.

Actually, this patch introduces the necessary support to all
architectures using the device tree, however only arm64 Kconfig is
modified, because this is the only platform i can test.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm64/Kconfig | 18 ++++++++++++++++++
 drivers/of/fdt.c   | 12 ++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ac16a4..c741837 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -695,6 +695,23 @@ config CMDLINE
 	  entering them here. As a minimum, you should specify the the
 	  root device (e.g. root=/dev/nfs).
 
+choice
+	prompt "Kernel command line type" if CMDLINE != ""
+	default CMDLINE_FROM_BOOTLOADER
+
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
@@ -702,6 +719,7 @@ config CMDLINE_FORCE
 	  loader passes other arguments to the kernel.
 	  This is useful if you cannot or don't want to change the
 	  command-line options your boot loader passes to the kernel.
+endchoice
 
 config EFI_STUB
 	bool
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d243029..494307e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -949,8 +949,16 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
+	if (p != NULL && l > 0) {
+		int offset = 0;
+#ifdef CONFIG_CMDLINE
+#ifdef CONFIG_CMDLINE_EXTEND
+		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		offset = strlcat(data, " ", COMMAND_LINE_SIZE);
+#endif
+#endif
+		strlcpy(data + offset, p, min(l, COMMAND_LINE_SIZE - offset));
+	}
 
 	/*
 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-- 
2.4.4
