From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 29 Jul 2013 21:24:01 +0000
Subject: [RFC PATCH 2/2] WIP: Get kernel and dtb addresses from command line
In-Reply-To: <cover.1375131816.git.jason@lakedaemon.net>
References: <cover.1375131816.git.jason@lakedaemon.net>
Message-ID: <9a3f873a28234e664fc2bfddce8218110c0d8dbd.1375131816.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow for detached kernel and dtb images.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile | 25 ++++++------------
 atags.h  |  6 +++++
 board.c  | 88 ----------------------------------------------------------------
 board.h  | 13 ----------
 led.c    | 54 ---------------------------------------
 led.h    |  6 -----
 main.c   | 52 +++++++++++++++++++++-----------------
 string.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 string.h |  8 ++++++
 9 files changed, 134 insertions(+), 201 deletions(-)
 delete mode 100644 board.c
 delete mode 100644 board.h
 delete mode 100644 led.c
 delete mode 100644 led.h
 create mode 100644 string.c
 create mode 100644 string.h

diff --git a/Makefile b/Makefile
index daeafa4..deb76b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,10 @@
-CFLAGS=-Wall -ffreestanding
+ifeq ($(origin APPEND_IMAGE), undefined)
+DOAPPEND=
+else
+DOAPPEND=-DAPPENDED_IMAGE=1
+endif
+
+CFLAGS=-Wall -ffreestanding $(DOAPPEND)
 LDFLAGS=-static -nostdlib
 GCC=$(CROSS_COMPILE)gcc
 OBJCOPY=$(CROSS_COMPILE)objcopy
@@ -6,30 +12,15 @@ LD=$(CROSS_COMPILE)ld
 LOADADDR=0xa0008000
 BINFMT=elf32-littlearm
 
-INPUT_OBJS = \
-	zimage.o		\
-	dtb-raumfeld-controller-0.o	\
-	dtb-raumfeld-controller-1.o	\
-	dtb-raumfeld-controller-2.o	\
-	dtb-raumfeld-connector-0.o	\
-	dtb-raumfeld-connector-1.o	\
-	dtb-raumfeld-connector-2.o	\
-	dtb-raumfeld-speaker-0.o	\
-	dtb-raumfeld-speaker-1.o	\
-	dtb-raumfeld-speaker-2.o
-
 all: uImage
 
-dtb-%.o: input/%.dtb
-	$(OBJCOPY) -I binary -O $(BINFMT) -B arm $^ $@
-
 zimage.o: input/zImage
 	$(OBJCOPY) -I binary -O $(BINFMT) -B arm $^ $@
 
 %.o: %.c
 	$(GCC) $(CFLAGS) -c $^
 
-matcher: main.o print.o board.o led.o $(INPUT_OBJS)
+matcher: main.o print.o string.o $(APPEND_IMAGE)
 	$(LD) $(LDFLAGS) -T matcher.lds -o $@ $^
 
 matcher.bin: matcher
diff --git a/atags.h b/atags.h
index 30e6ee7..67d3d01 100644
--- a/atags.h
+++ b/atags.h
@@ -10,15 +10,21 @@ struct tag_header {
 
 /* board revision */
 #define ATAG_REVISION   0x54410007
+#define ATAG_CMDLINE	0x54410009
 
 struct tag_revision {
 	__u32 rev;
 };
 
+struct tag_cmdline {
+	char cmdline[1];     /* this is the minimum size */
+};
+
 struct tag {
 	struct tag_header hdr;
 	union {
 		struct tag_revision	rev;
+		struct tag_cmdline	cmdline;
 	} u;
 };
 
diff --git a/board.c b/board.c
deleted file mode 100644
index f9c2425..0000000
--- a/board.c
+++ /dev/null
@@ -1,88 +0,0 @@
-#include "types.h"
-#include "board.h"
-
-extern __u32 _binary_input_zImage_start;
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
-	/* Controller */
-	{
-		.machid		= 2413,
-		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
-		.name		= "Raumfeld Controller, revision 0",
-	},
-	{
-		.machid		= 2413,
-		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_controller_1_dtb_start,
-		.name		= "Raumfeld Controller, revision 1",
-	},
-	{
-		.machid		= 2413,
-		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_controller_2_dtb_start,
-		.name		= "Raumfeld Controller, revision 2",
-	},
-
-	/* Controller */
-	{
-		.machid		= 2414,
-		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_connector_0_dtb_start,
-		.name		= "Raumfeld Connector, revision 0",
-	},
-	{
-		.machid		= 2414,
-		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_connector_1_dtb_start,
-		.name		= "Raumfeld Connector, revision 1",
-	},
-	{
-		.machid		= 2414,
-		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_connector_2_dtb_start,
-		.name		= "Raumfeld Connector, revision 2",
-	},
-
-	/* Speaker */
-	{
-		.machid		= 2415,
-		.system_rev	= 0,
-		.dtb		= &_binary_input_raumfeld_speaker_0_dtb_start,
-		.name		= "Raumfeld Speaker, revision 0",
-	},
-	{
-		.machid		= 2415,
-		.system_rev	= 1,
-		.dtb		= &_binary_input_raumfeld_speaker_1_dtb_start,
-		.name		= "Raumfeld Speaker, revision 1",
-	},
-	{
-		.machid		= 2415,
-		.system_rev	= 2,
-		.dtb		= &_binary_input_raumfeld_speaker_2_dtb_start,
-		.name		= "Raumfeld Speaker, revision 2",
-	},
-	{ 0, 0, NULL, NULL }	/* sentinel */
-};
-
-struct board *match_board(__u32 machid, __u32 revision)
-{
-	struct board *board;
-
-	for (board = boards; board->machid; board++)
-		if (board->machid == machid && board->system_rev == revision)
-			return board;
-
-	return NULL;
-}
-
diff --git a/board.h b/board.h
deleted file mode 100644
index b256a6c..0000000
--- a/board.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _BOARD_H
-#define _BOARD_H
-
-struct board {
-	__u32		machid;
-	__u32		system_rev;
-	void		*dtb;
-	const char	*name;
-};
-
-struct board *match_board(__u32 machid, __u32 revision);
-
-#endif
diff --git a/led.c b/led.c
deleted file mode 100644
index 837d961..0000000
--- a/led.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "types.h"
-#include "led.h"
-
-static inline void writel(__u32 val, __u32 addr)
-{
-	*(volatile __u32 *) addr = val;
-}
-
-static inline __u32 readl(__u32 addr)
-{
-	return *(volatile __u32 *) addr;
-}
-
-static void wait(__u32 ticks)
-{
-	__u32 v;
-
-	/* OSCR */
-	writel(0, 0x40A00010);
-
-	do {
-		v = readl(0x40A00010);
-	} while (ticks > v);
-}
-
-static void led_init(void)
-{
-	writel(0, 0x40e10420);		/* GPIO35 */
-	writel(0, 0x40e10424);		/* GPIO36 */
-	writel(0x18, 0x40e00010);	/* GPDR1 */
-}
-
-static void led_set(__u32 index, __u32 state)
-{
-	__u32 v = 1 << (index ? 3 : 4);
-
-	if (state)
-		writel(v, 0x40e0001c);
-	else
-		writel(v, 0x40e00028);
-}
-
-void led_panic(void)
-{
-	int i;
-
-	led_init();
-
-	for (i = 0;; i++) {
-		led_set(0, i & 1);
-		led_set(1, ~i & 1);
-		wait(500000);
-	}
-}
diff --git a/led.h b/led.h
deleted file mode 100644
index 0cdcf31..0000000
--- a/led.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _LED_H_
-#define _LED_H_
-
-void led_panic(void);
-
-#endif
diff --git a/main.c b/main.c
index 3dd6636..af2b6c8 100644
--- a/main.c
+++ b/main.c
@@ -1,45 +1,51 @@
 #include "types.h"
 #include "atags.h"
 #include "print.h"
-#include "board.h"
-#include "led.h"
+#include "string.h"
 
+#ifdef DOAPPENDED
 extern __u32 _binary_input_zImage_start;
+#endif
 
 void main(__u32 dummy, __u32 machid, const struct tag *tags)
 {
 	const struct tag *t;
-	struct board *board;
-	__u32 system_rev = 0;
-	void (*start_kernel)(__u32 dummy, __u32 machid, void *dtb) =
-		(void *) &_binary_input_zImage_start;
+	void *kernel=NULL;
+	void *dtb=NULL;
+	void (*start_kernel)(__u32 dummy, __u32 machid, void *dtb);
+
+#ifdef DOAPPENDED
+	start_kernel = (void *) &_binary_input_zImage_start;
+#endif
 
 	putstr("++ Impedance Matcher (3rd stage loader) ++\n");
 
 	/* walk the atags to determine the system revision */
 	for_each_tag(t, tags)
 		switch (t->hdr.tag) {
-			case ATAG_REVISION:
-				system_rev = t->u.rev.rev;
+			case ATAG_CMDLINE:
+				/*
+				 * look for load addresses
+				 * eg: loadaddrs=0x0800000,0x0700000
+				 * for           kernel    dtb
+				 */
+				getaddrs(&kernel, &dtb, t->u.cmdline.cmdline);
 				break;
 		}
 
-	board = match_board(machid, system_rev & 0xff);
-	if (!board) {
-		putstr("ERROR MATCHING BOARD!\n");
-		putstr("MACHID: 0x");
-		printhex(machid);
-		putstr("\n");
-		putstr("SYSTEM_REV: 0x");
-		printhex(system_rev);
-		putstr("\n");
-		led_panic();
-	}
-
-	putstr("Detected board: ");
-	putstr(board->name);
+	if (kernel) {
+		putstr("Kernel: 0x");
+		printhex((__u32)kernel);
+		start_kernel = kernel;
+	} else
+		putstr("Kernel: Appended");
+	putstr("\n");
+
+	putstr("DTB:    0x");
+	printhex((__u32)dtb);
 	putstr("\n");
 
 	putstr("Booting into Linux kernel ...\n");
-	start_kernel(0, 0xffffffff, board->dtb);
+	start_kernel(0, 0xffffffff, dtb);
+
 }
diff --git a/string.c b/string.c
new file mode 100644
index 0000000..8eb459f
--- /dev/null
+++ b/string.c
@@ -0,0 +1,83 @@
+#include "types.h"
+#include "string.h"
+
+int hexlut[1 + 'F' - '0'] = {
+	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, /* 0 - 9 */
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0xa, 0xb, 0xc, 0xd, 0xe, 0xf                      /* A - F */
+};
+
+int strncmp(const char *stra, const char *strb, int len)
+{
+	int diff=0;
+	const char *a = stra;
+	const char *b = strb;
+
+	while ((a - stra) <= len)
+		diff += *(a++) - *(b++);
+
+	return diff;
+}
+
+void *gethexaddr(const char *str, const char **end)
+{
+	const char *s = str;
+	void *addr = NULL;
+	int shift = 0;
+
+	/* set the end */
+	while (*s) {
+		if (*s != ' ' && *s != '\t' && *s != ',')
+			break;
+		s++;
+	}
+
+	if (!*s)
+		return NULL;
+
+	*end = s;
+	s = *end - 1;
+
+	while (s >= str && *s != 'x') {
+		/* we assume base16! */
+		int off = (*s > 'F') ? 0x20 : 0x0;
+		addr += hexlut[*s - ('0' + off)] << shift;
+		shift += 4;
+		s--;
+	}
+
+	return addr;
+}
+
+int getaddrs(void **k, void **d, const char *str)
+{
+	const char *s = str;
+	const char *end;
+
+	while (*(s++)) {
+		if (*s == 'l')
+			if (strncmp(s, "loadaddrs=", 10) == 0)
+				break;
+	}
+
+	if (!*s)
+		return -1;
+
+	s += 10; /* skip over 'loadaddrs=' */
+
+	/* allow address to be 'appended' for some use cases */
+	if (strncmp(s, "appended", 8) == 0) {
+		*k = NULL;
+		end = s + 8;
+	} else
+		*k = gethexaddr(s, &end);
+
+	if (*end == ',')
+		s = end + 1;
+	else
+		return -1;
+
+	*d = gethexaddr(s, NULL);
+
+	return 0;
+}
diff --git a/string.h b/string.h
new file mode 100644
index 0000000..14d6764
--- /dev/null
+++ b/string.h
@@ -0,0 +1,8 @@
+#ifndef _STRING_H_
+
+#include "types.h"
+
+int strncmp(const char *, const char *, int);
+void *gethexaddr(const char *, const char **);
+int getaddrs(void **, void **, const char *);
+#endif
-- 
1.8.3.2
