From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 11 Jan 2011 18:29:13 +0100
Subject: [PATCH] ARM: Change misleading warning when CONFIG_CMDLINE_FORCE is
	used
Message-ID: <1294766953-6889-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_CMDLINE_FORCE is used, the warning

  Ignoring unrecognised tag 0x54410009

was displayed. Change this to

  Ignoring tag cmdline (using the default kernel command line)

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/kernel/setup.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..19c0e96 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -649,15 +649,19 @@ static int __init parse_tag_revision(const struct tag *tag)
 
 __tagtable(ATAG_REVISION, parse_tag_revision);
 
-#ifndef CONFIG_CMDLINE_FORCE
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
+#ifndef CONFIG_CMDLINE_FORCE
 	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+#else
+	printk(KERN_WARNING
+		"Ignoring tag cmdline"
+		" (using the default kernel command line)\n");
+#endif /* CONFIG_CMDLINE_FORCE */
 	return 0;
 }
 
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
-#endif /* CONFIG_CMDLINE_FORCE */
 
 /*
  * Scan the tag table for this tag, and call its parse function.
-- 
1.7.3.4
