From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:16 +0000
Subject: [RFC PATCH V2 9/9] appended dtbs works!
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <ecbf213c41cfd68781dd362e01ee1e42e3d7dba9.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this commit, the user can build a single binary with the zImage
linked in and the dtbs appended.

The user needs to provide a board-*.c file, address of the uart, then:

  make MFG=boardname APPEND_KERNEL=/tmp/zImage APPEND_DTBS=/tmp/*.dtb \
	uImage

Look at board-raumfeld.c for an example of how to determine the board
you are on and set the desired compatible string.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile          |  1 +
 board-dreamplug.c | 28 ++++++++++++++++++++++++
 board-raumfeld.c  | 49 ++++++++++++++++++++----------------------
 board.h           |  2 --
 dtbs.c            | 36 +++++++++++++++++++++++++++++++
 dtbs.h            |  6 ++++++
 endian.h          | 12 +++++++++++
 fdt.h             | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 string.c          | 10 +++++++++
 string.h          |  1 +
 types.h           |  1 +
 11 files changed, 182 insertions(+), 28 deletions(-)
 create mode 100644 board-dreamplug.c
 create mode 100644 dtbs.c
 create mode 100644 dtbs.h
 create mode 100644 endian.h
 create mode 100644 fdt.h

diff --git a/Makefile b/Makefile
index c9b2381..7829a01 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,7 @@ BOARD_OBJ = board-$(MFG).o
 UART_OBJ = serial-$(UART).o
 
 COMMON_OBJS = \
+	dtbs.o \
 	main.o \
 	print.o \
 	register.o \
diff --git a/board-dreamplug.c b/board-dreamplug.c
new file mode 100644
index 0000000..123c0f4
--- /dev/null
+++ b/board-dreamplug.c
@@ -0,0 +1,28 @@
+#include "board.h"
+#include "dtbs.h"
+#include "print.h"
+#include "register.h"
+#include "types.h"
+
+/*
+ * this code is just a quick PoC for appending multiple dtbs.  I don't have
+ * any boards handy with stock, non-DT bootloaders, so I have no machids to
+ * trigger off of.
+ */
+
+extern __u32 _binary_input_zImage_start;
+extern __u32 __end_of_image;
+
+struct board board;
+const char *compat = "globalscale,dreamplug";
+
+struct board *match_board(__u32 machid, const struct tag *tags)
+{
+
+	/* testing zImage linked in and dtbs appended */
+	board.kernel = &_binary_input_zImage_start;
+	board.compatible = compat;
+	board.dtb = find_dtb(&__end_of_image, compat);
+
+	return &board;
+}
diff --git a/board-raumfeld.c b/board-raumfeld.c
index e5d4702..90fffeb 100644
--- a/board-raumfeld.c
+++ b/board-raumfeld.c
@@ -1,38 +1,36 @@
 #include "atags.h"
 #include "board.h"
+#include "dtbs.h"
 #include "print.h"
 #include "register.h"
 #include "types.h"
 
 extern __u32 _binary_input_zImage_start;
-extern __u32 _binary_input_raumfeld_controller_0_dtb_start;
-extern __u32 _binary_input_raumfeld_controller_1_dtb_start;
-extern __u32 _binary_input_raumfeld_controller_2_dtb_start;
-extern __u32 _binary_input_raumfeld_connector_0_dtb_start;
-extern __u32 _binary_input_raumfeld_connector_1_dtb_start;
-extern __u32 _binary_input_raumfeld_connector_2_dtb_start;
-extern __u32 _binary_input_raumfeld_speaker_0_dtb_start;
-extern __u32 _binary_input_raumfeld_speaker_1_dtb_start;
-extern __u32 _binary_input_raumfeld_speaker_2_dtb_start;
-
-static struct board boards[] = {
+extern __u32 __end_of_image;
+
+struct board board;
+
+struct raum_board {
+	__u32		machid;
+	__u32		system_rev;
+	const char	*compatible;
+};
+
+static struct raum_board rboards[] = {
 	/* Controller */
 	{
 		.machid		= 2413,
 		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
 		.compatible	= "Raumfeld Controller, revision 0",
 	},
 	{
 		.machid		= 2413,
 		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_controller_1_dtb_start,
 		.compatible	= "Raumfeld Controller, revision 1",
 	},
 	{
 		.machid		= 2413,
 		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_controller_2_dtb_start,
 		.compatible	= "Raumfeld Controller, revision 2",
 	},
 
@@ -40,19 +38,16 @@ static struct board boards[] = {
 	{
 		.machid		= 2414,
 		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_connector_0_dtb_start,
 		.compatible	= "Raumfeld Connector, revision 0",
 	},
 	{
 		.machid		= 2414,
 		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_connector_1_dtb_start,
 		.compatible	= "Raumfeld Connector, revision 1",
 	},
 	{
 		.machid		= 2414,
 		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_connector_2_dtb_start,
 		.compatible	= "Raumfeld Connector, revision 2",
 	},
 
@@ -60,22 +55,19 @@ static struct board boards[] = {
 	{
 		.machid		= 2415,
 		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_speaker_0_dtb_start,
 		.compatible	= "Raumfeld Speaker, revision 0",
 	},
 	{
 		.machid		= 2415,
 		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_speaker_1_dtb_start,
 		.compatible	= "Raumfeld Speaker, revision 1",
 	},
 	{
 		.machid		= 2415,
 		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_speaker_2_dtb_start,
 		.compatible	= "Raumfeld Speaker, revision 2",
 	},
-	{ 0, 0, NULL, NULL }	/* sentinel */
+	{ 0, 0, NULL }	/* sentinel */
 };
 
 static void wait(__u32 ticks)
@@ -122,7 +114,7 @@ static void led_panic(void)
 struct board *match_board(__u32 machid, const struct tag *tags)
 {
 	const struct tag *t;
-	struct board *board;
+	struct raum_board *rboard;
 	__u32 system_rev = 0;
 
 	/* walk the atags to determine the system revision */
@@ -134,11 +126,12 @@ struct board *match_board(__u32 machid, const struct tag *tags)
 		}
 
 
-	for (board = boards; board->machid; board++)
-		if (board->machid == machid && board->system_rev == system_rev)
+	for (rboard = rboards; rboard->machid; rboard++)
+		if (rboard->machid == machid &&
+		    rboard->system_rev == system_rev)
 			break;
 
-	if (board->compatible == NULL) {
+	if (rboard->compatible == NULL) {
 		putstr("ERROR MATCHING BOARD!\n");
 		putstr("MACHID: 0x");
 		printhex(machid);
@@ -149,5 +142,9 @@ struct board *match_board(__u32 machid, const struct tag *tags)
 		led_panic(); /* doesn't return */
 	}
 
-	return board;
+	board.kernel = &_binary_input_zImage_start;
+	board.compatible = rboard->compatible;
+	board.dtb = find_dtb(&__end_of_image, rboard->compatible);
+
+	return &board;
 }
diff --git a/board.h b/board.h
index a28fb06..75931a1 100644
--- a/board.h
+++ b/board.h
@@ -5,8 +5,6 @@
 #include "atags.h"
 
 struct board {
-	__u32		machid;
-	__u32		system_rev;
 	void		*dtb;
 	void		*kernel;
 	const char	*compatible;
diff --git a/dtbs.c b/dtbs.c
new file mode 100644
index 0000000..a761ac4
--- /dev/null
+++ b/dtbs.c
@@ -0,0 +1,36 @@
+#include "endian.h"
+#include "fdt.h"
+#include "print.h"
+#include "string.h"
+#include "types.h"
+
+/* Yes, this is a dirty hack.  But it's simple, and fast. */
+
+int find_str(char *mem, __u32 memsz, const char *str)
+{
+	__u32 len = strlen(str);
+	const char *last = mem + memsz - len;
+	const char *p;
+
+	for (p = mem; p < last; p++) {
+		if (*p == *str)
+			if (strncmp(p, str, len) == 0)
+				return 1;
+	}
+
+	return 0;
+}
+
+void *find_dtb(void *dtbs, const char *compat)
+{
+	struct fdt_header *d = (struct fdt_header *)dtbs;
+
+	while (d->magic == be_to_cpu(FDT_MAGIC)) {
+		if (find_str((char *)d, be_to_cpu(d->totalsize), compat) == 1)
+			break;
+
+		d = (struct fdt_header *)((char *)d + be_to_cpu(d->totalsize));
+	}
+
+	return d;
+}
diff --git a/dtbs.h b/dtbs.h
new file mode 100644
index 0000000..4e14b32
--- /dev/null
+++ b/dtbs.h
@@ -0,0 +1,6 @@
+#ifndef _DTBS_H
+#define _DTBS_H
+
+void *find_dtb(void *, const char *);
+
+#endif
diff --git a/endian.h b/endian.h
new file mode 100644
index 0000000..531b6b1
--- /dev/null
+++ b/endian.h
@@ -0,0 +1,12 @@
+#ifndef _ENDIAN_H
+#define _ENDIAN_H
+
+#include "types.h"
+
+#define be_to_cpu(x) \
+	( ((0xFF000000UL & ((__u32)x)) >> 24) | \
+	  ((0x00FF0000UL & ((__u32)x)) >> 8)  | \
+	  ((0x0000FF00UL & ((__u32)x)) << 8)  | \
+	  ((0x000000FFUL & ((__u32)x)) << 24)    )
+
+#endif
diff --git a/fdt.h b/fdt.h
new file mode 100644
index 0000000..13a0354
--- /dev/null
+++ b/fdt.h
@@ -0,0 +1,64 @@
+#ifndef _FDT_H
+#define _FDT_H
+
+/* Copied from barebox, thanks! */
+
+#include "types.h"
+
+#ifndef __ASSEMBLY__
+
+struct fdt_header {
+	__u32 magic;			 /* magic word FDT_MAGIC */
+	__u32 totalsize;		 /* total size of DT block */
+	__u32 off_dt_struct;		 /* offset to structure */
+	__u32 off_dt_strings;	 /* offset to strings */
+	__u32 off_mem_rsvmap;	 /* offset to memory reserve map */
+	__u32 version;		 /* format version */
+	__u32 last_comp_version;	 /* last compatible version */
+
+	/* version 2 fields below */
+	__u32 boot_cpuid_phys;	 /* Which physical CPU id we're
+					    booting on */
+	/* version 3 fields below */
+	__u32 size_dt_strings;	 /* size of the strings block */
+
+	/* version 17 fields below */
+	__u32 size_dt_struct;	 /* size of the structure block */
+} __attribute__((packed));
+
+struct fdt_reserve_entry {
+	__u64 address;
+	__u64 size;
+};
+
+struct fdt_node_header {
+	__u32 tag;
+	char name[0];
+};
+
+struct fdt_property {
+	__u32 tag;
+	__u32 len;
+	__u32 nameoff;
+	char data[0];
+};
+
+#endif /* !__ASSEMBLY */
+
+#define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
+#define FDT_TAGSIZE	sizeof(__u32)
+
+#define FDT_BEGIN_NODE	0x1		/* Start node: full name */
+#define FDT_END_NODE	0x2		/* End node */
+#define FDT_PROP	0x3		/* Property: name off,
+					   size, content */
+#define FDT_NOP		0x4		/* nop */
+#define FDT_END		0x9
+
+#define FDT_V1_SIZE	(7*sizeof(__u32))
+#define FDT_V2_SIZE	(FDT_V1_SIZE + sizeof(__u32))
+#define FDT_V3_SIZE	(FDT_V2_SIZE + sizeof(__u32))
+#define FDT_V16_SIZE	FDT_V3_SIZE
+#define FDT_V17_SIZE	(FDT_V16_SIZE + sizeof(__u32))
+
+#endif /* _FDT_H */
diff --git a/string.c b/string.c
index 6584378..d13e22b 100644
--- a/string.c
+++ b/string.c
@@ -7,6 +7,16 @@ int hexlut[1 + 'F' - '0'] = {
 	0xa, 0xb, 0xc, 0xd, 0xe, 0xf                      /* A - F */
 };
 
+int strlen(const char *str)
+{
+	const char *c = str;
+
+	while (*(c++))
+		;
+
+	return c - str;
+}
+
 int strncmp(const char *stra, const char *strb, int len)
 {
 	int diff=0;
diff --git a/string.h b/string.h
index 59f5f0c..0b99785 100644
--- a/string.h
+++ b/string.h
@@ -1,6 +1,7 @@
 #ifndef _STRING_H
 #define _STRING_H
 
+int strlen(const char *);
 int strncmp(const char *, const char *, int);
 void *gethexaddr(const char *, const char **);
 int getaddrs(void **, void **, const char *);
diff --git a/types.h b/types.h
index 27ec08e..4c078a3 100644
--- a/types.h
+++ b/types.h
@@ -2,6 +2,7 @@
 #define _TYPES_H
 
 typedef unsigned int __u32;
+typedef unsigned long long __u64;
 #define NULL	((void *) 0)
 
 #endif /* _TYPES_H */
-- 
1.8.3.2
