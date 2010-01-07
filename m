From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 07 Jan 2010 14:39:21 +1100
Subject: [PATCH 2/3] arm: change command_line to cmd_line, and export it
In-Reply-To: <1262835561.887063.943450380979.0.gpush@pororo>
Message-ID: <1262835561.887931.658428747865.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/of/fdt expects a cmd_line symbol, while arm uses command_line.
Change to the former and make accessible from setup.h, so that we can
share with the fdt code.

This means a change in section from .init.data to .data

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/setup.h |    6 ++++--
 arch/arm/kernel/setup.c      |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index f392fb4..3b6f461 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -16,8 +16,6 @@
 
 #include <linux/types.h>
 
-#define COMMAND_LINE_SIZE 1024
-
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
@@ -223,6 +221,10 @@ extern struct meminfo meminfo;
 #define bank_phys_end(bank)	((bank)->start + (bank)->size)
 #define bank_phys_size(bank)	(bank)->size
 
+#define COMMAND_LINE_SIZE 1024
+
+extern char cmd_line[COMMAND_LINE_SIZE];
+
 #endif  /*  __KERNEL__  */
 
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4aa67cd..4206286 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(elf_platform);
 
 static const char *cpu_name;
 static const char *machine_name;
-static char __initdata command_line[COMMAND_LINE_SIZE];
+char cmd_line[COMMAND_LINE_SIZE];
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -706,9 +706,9 @@ void __init setup_arch(char **cmdline_p)
 	/* parse_early_param needs a boot_command_line */
 	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
 
-	/* populate command_line too for later use, preserving boot_command_line */
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-	*cmdline_p = command_line;
+	/* populate cmd_line too for later use, preserving boot_command_line */
+	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = cmd_line;
 
 	parse_early_param();
 
