From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 16 Jul 2017 23:43:15 +0200 (CEST)
Subject: [PATCH] ARM: zImage: Fix stack overflow in merge_fdt_bootargs()
Message-ID: <257f11e3b0010a3a44c28b34a048278f7b960f3b.1500238579.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is called very early on from head.S and currently sets up a
stack frame of more than 1024 bytes:

atags_to_fdt.c: In function ?merge_fdt_bootargs?:
atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This causes a crash and failure to boot with some combinations of kernel
version, gcc version and dtb, such as kernel version 4.1-rc1 of 4.1.0,
gcc version 5.4.1 20161019 (Debian 5.4.1-3) and tegra20-trimslice.dtb.

With this patch, merge_fdt_bootargs() is rewritten to not use a large buffer,
thereby solving the problem of the stack overflow.

As a side effect of this rewrite, you no longer get a space added in front
of the kernel command line when no bootargs property was found in the fdt.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Fixes: d0f34a11ddab ("ARM: 7437/1: zImage: Allow DTB command line concatenation with ATAG_CMDLINE")
---

I have tested that this works properly when
a) only the FDT bootargs are provided,
b) only the ATAG command line is provided, and
c) both the FDT bootargs and the ATAG command line are provided.

 arch/arm/boot/compressed/atags_to_fdt.c | 59 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 9448aa0c6686..ede23ef2e889 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -55,6 +55,27 @@ static const void *getprop(const void *fdt, const char *node_path,
 	return fdt_getprop(fdt, offset, property, len);
 }
 
+static void *getprop_w(void *fdt, const char *node_path,
+		       const char *property, int *len)
+{
+	int offset = fdt_path_offset(fdt, node_path);
+
+	if (offset == -FDT_ERR_NOTFOUND)
+		return NULL;
+
+	return fdt_getprop_w(fdt, offset, property, len);
+}
+
+static int appendprop_string(void *fdt, const char *node_path,
+			     const char *property, const char *string)
+{
+	int offset = node_offset(fdt, node_path);
+
+	if (offset < 0)
+		return offset;
+	return fdt_appendprop_string(fdt, offset, property, string);
+}
+
 static uint32_t get_cell_size(const void *fdt)
 {
 	int len;
@@ -66,35 +87,25 @@ static uint32_t get_cell_size(const void *fdt)
 	return cell_size;
 }
 
-static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
-{
-	char cmdline[COMMAND_LINE_SIZE];
-	const char *fdt_bootargs;
-	char *ptr = cmdline;
-	int len = 0;
-
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
-	}
-	*ptr = '\0';
-
-	setprop_string(fdt, "/chosen", "bootargs", cmdline);
+/* This is called early on from head.S, so it can't use much stack. */
+static void merge_fdt_bootargs(void *fdt, const char *atag_cmdline)
+{
+	char *fdt_bootargs;
+	int len = 0;
+
+	/* With no ATAG command line or an empty one, there is nothing to do. */
+	if (!atag_cmdline || strlen(atag_cmdline) == 0)
+		return;
+
+	fdt_bootargs = getprop_w(fdt, "/chosen", "bootargs", &len);
+
+	/* With no FDT command line or an empty one, just use the ATAG one. */
+	if (!fdt_bootargs || len <= 1) {
+		setprop_string(fdt, "/chosen", "bootargs", atag_cmdline);
+		return;
+	}
+	fdt_bootargs[len - 1] = ' ';
+	appendprop_string(fdt, "/chosen", "bootargs", atag_cmdline);
 }
 
 /*
-- 
2.13.2
