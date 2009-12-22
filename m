From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 01/11] arm: change command_line to cmd_line, and export it
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.245647.957109336298.1.gpush@pororo>
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
index 5ccce0a..1e2ab1b 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -16,8 +16,6 @@
 
 #include <linux/types.h>
 
-#define COMMAND_LINE_SIZE 1024
-
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
@@ -235,6 +233,10 @@ struct early_params {
 static struct early_params __early_##fn __used			\
 __attribute__((__section__(".early_param.init"))) = { name, fn }
 
+#define COMMAND_LINE_SIZE 1024
+
+extern char cmd_line[COMMAND_LINE_SIZE];
+
 #endif  /*  __KERNEL__  */
 
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..015803a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(elf_platform);
 
 static const char *cpu_name;
 static const char *machine_name;
-static char __initdata command_line[COMMAND_LINE_SIZE];
+char cmd_line[COMMAND_LINE_SIZE];
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -446,7 +446,7 @@ __early_param("mem=", early_mem);
  */
 static void __init parse_cmdline(char **cmdline_p, char *from)
 {
-	char c = ' ', *to = command_line;
+	char c = ' ', *to = cmd_line;
 	int len = 0;
 
 	for (;;) {
@@ -458,7 +458,7 @@ static void __init parse_cmdline(char **cmdline_p, char *from)
 				int arglen = strlen(p->arg);
 
 				if (memcmp(from, p->arg, arglen) == 0) {
-					if (to != command_line)
+					if (to != cmd_line)
 						to -= 1;
 					from += arglen;
 					p->fn(&from);
@@ -477,7 +477,7 @@ static void __init parse_cmdline(char **cmdline_p, char *from)
 		*to++ = c;
 	}
 	*to = '\0';
-	*cmdline_p = command_line;
+	*cmdline_p = cmd_line;
 }
 
 static void __init
