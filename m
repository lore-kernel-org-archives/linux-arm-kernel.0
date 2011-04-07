From: oskar.andero@sonyericsson.com (oskar.andero at sonyericsson.com)
Date: Thu, 7 Apr 2011 10:17:16 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
Message-ID: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Boivie <victor.boivie@sonyericsson.com>

This patch allows the provided CONFIG_CMDLINE to be concatenated
with the one provided by the boot loader. This is useful to
merge the static values defined in CONFIG_CMDLINE with the
boot loader's (possibly) more dynamic values, such as startup
reasons and more.

Signed-off-by: Victor Boivie <victor.boivie@sonyericsson.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonyericsson.com>
Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
---
 arch/arm/Kconfig        |   21 +++++++++++++++++++--
 arch/arm/kernel/setup.c |    9 ++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b9f78b..71b35e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1743,6 +1743,24 @@ config CMDLINE
 	  time by entering them here. As a minimum, you should specify the
 	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
 
+choice
+	prompt "Kernel command line type"
+	default CMDLINE_DEFAULT
+
+config CMDLINE_DEFAULT
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	depends on CMDLINE != ""
+	help
+	  The default kernel command string will be concatenated with the
+	  arguments provided by the boot loader.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	depends on CMDLINE != ""
@@ -1751,8 +1769,7 @@ config CMDLINE_FORCE
 	  loader passes other arguments to the kernel.
 	  This is useful if you cannot or don't want to change the
 	  command-line options your boot loader passes to the kernel.
-
-	  If unsure, say N.
+endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 006c1e8..465bc7e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -673,7 +673,14 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
 #ifndef CONFIG_CMDLINE_FORCE
-	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+#ifdef CONFIG_CMDLINE_EXTEND
+	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
+	strlcat(default_command_line, tag->u.cmdline.cmdline,
+		COMMAND_LINE_SIZE);
+#else
+	strlcpy(default_command_line, tag->u.cmdline.cmdline,
+		COMMAND_LINE_SIZE);
+#endif
 #else
 	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");
 #endif /* CONFIG_CMDLINE_FORCE */
-- 
1.7.4.2
