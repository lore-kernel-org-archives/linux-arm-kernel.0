From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 29 Jan 2010 20:42:38 +0100
Subject: [PATCH 1/1] ARM: Add option CMDLINE_FORCE to force usage of the
	in-kernel cmdline
In-Reply-To: <1264794158-4933-1-git-send-email-holler@ahsoftware.de>
References: <1264794158-4933-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1264794158-4933-2-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If true the default kernel command string is used, even if the boot
loader passes another command string to the kernel.

Useful if someone cannot or don't want to change the
command-line options of the boot loader but is able to change
the kernel.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/Kconfig        |   11 +++++++++++
 arch/arm/kernel/setup.c |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..193cf10 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1301,6 +1301,17 @@ config CMDLINE
 	  time by entering them here. As a minimum, you should specify the
 	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
 
+config CMDLINE_FORCE
+	bool "Always use the default kernel command string"
+	depends on CMDLINE != ""
+	help
+	  Always use the default kernel command string, even if the boot
+	  loader passes other arguments to the kernel.
+	  This is useful if you cannot or don't want to change the
+	  command-line options your boot loader passes to the kernel.
+
+	  If unsure, say N.
+
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ZBOOT_ROM
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..1d31800 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -627,6 +627,7 @@ static int __init parse_tag_revision(const struct tag *tag)
 
 __tagtable(ATAG_REVISION, parse_tag_revision);
 
+#ifndef CONFIG_CMDLINE_FORCE
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
 	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
@@ -634,6 +635,7 @@ static int __init parse_tag_cmdline(const struct tag *tag)
 }
 
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
+#endif /* CONFIG_CMDLINE_FORCE */
 
 /*
  * Scan the tag table for this tag, and call its parse function.
-- 
1.6.2.5
