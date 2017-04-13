From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 13 Apr 2017 15:35:49 -0700
Subject: [PATCH] ARM: zImage: fix warning in merge_fdt_bootargs()
Message-ID: <20170413223549.18082-1-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc produces the following warning:
arch/arm/boot/compressed/atags_to_fdt.c: In function 'merge_fdt_bootargs':
arch/arm/boot/compressed/atags_to_fdt.c:98:1: warning: the frame size of
1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Update merge_fdt_bootargs() so that instead of a 1k buffer on the
stack, it calls fdt_appendprop_string()

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
I tried testing this on my imx6 setup by adding bogus text to the
command line, but it appears that with my (recent) uboot
the codepath is not executed.
So this could be regarded as little more than compile-tested.

 arch/arm/boot/compressed/atags_to_fdt.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 9448aa0..fefb30a 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -66,35 +66,19 @@ static uint32_t get_cell_size(const void *fdt)
 	return cell_size;
 }
 
-static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
+static void merge_fdt_bootargs(void *fdt, const char *cmdline)
 {
-	char cmdline[COMMAND_LINE_SIZE];
 	const char *fdt_bootargs;
-	char *ptr = cmdline;
+	int offset = node_offset(fdt, "/chosen");
 	int len = 0;
 
-	/* copy the fdt command line into the buffer */
-	fdt_bootargs = getprop(fdt, "/chosen", "bootargs", &len);
-	if (fdt_bootargs)
-		if (len < COMMAND_LINE_SIZE) {
-			memcpy(ptr, fdt_bootargs, len);
-			/* len is the length of the string
-			 * including the NULL terminator */
-			ptr += len - 1;
-		}
-
-	/* and append the ATAG_CMDLINE */
-	if (fdt_cmdline) {
-		len = strlen(fdt_cmdline);
-		if (ptr - cmdline + len + 2 < COMMAND_LINE_SIZE) {
-			*ptr++ = ' ';
-			memcpy(ptr, fdt_cmdline, len);
-			ptr += len;
-		}
+	/* get the ftd command line length */
+	fdt_bootargs = fdt_getprop(fdt, offset, "bootargs", &len);
+	/* append the ATAG_CMDLINE if its not too big */
+	if (cmdline && ((len + strlen(cmdline)) < (COMMAND_LINE_SIZE - 2))) {
+		fdt_appendprop_string(fdt, offset, "bootargs", " ");
+		fdt_appendprop_string(fdt, offset, "bootargs", cmdline);
 	}
-	*ptr = '\0';
-
-	setprop_string(fdt, "/chosen", "bootargs", cmdline);
 }
 
 /*
-- 
2.9.3
