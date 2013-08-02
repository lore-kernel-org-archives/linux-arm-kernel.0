From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:09 +0000
Subject: [RFC PATCH V2 2/9] separate common functions from board specific
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <b349cb8bd2d6e89f2edf85c0754ca3b7180b0da5.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile   |  7 +++++-
 board.c    | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 board.h    |  2 +-
 led.c      | 54 -------------------------------------------
 led.h      |  6 -----
 main.c     | 27 ++++------------------
 register.c | 11 +++++++++
 register.h |  9 ++++++++
 8 files changed, 103 insertions(+), 90 deletions(-)
 delete mode 100644 led.c
 delete mode 100644 led.h
 create mode 100644 register.c
 create mode 100644 register.h

diff --git a/Makefile b/Makefile
index da2982a..814326d 100644
--- a/Makefile
+++ b/Makefile
@@ -6,6 +6,11 @@ LD=$(CROSS_COMPILE)ld
 LOADADDR=0xa0008000
 BINFMT=elf32-littlearm
 
+COMMON_OBJS = \
+	main.o \
+	print.o \
+	register.o
+
 INPUT_OBJS = \
 	zimage.o		\
 	dtb-raumfeld-controller-0.o	\
@@ -29,7 +34,7 @@ zimage.o: input/zImage
 %.o: %.c
 	$(GCC) $(CFLAGS) -c $^
 
-matcher: main.o print.o board.o led.o $(INPUT_OBJS)
+matcher: $(COMMON_OBJS) board.o $(INPUT_OBJS)
 	$(LD) $(LDFLAGS) -T matcher.lds -o $@ $^
 
 matcher.bin: matcher
diff --git a/board.c b/board.c
index f9c2425..fe51bcb 100644
--- a/board.c
+++ b/board.c
@@ -1,5 +1,8 @@
-#include "types.h"
+#include "atags.h"
 #include "board.h"
+#include "print.h"
+#include "register.h"
+#include "types.h"
 
 extern __u32 _binary_input_zImage_start;
 extern __u32 _binary_input_raumfeld_controller_0_dtb_start;
@@ -75,14 +78,76 @@ static struct board boards[] = {
 	{ 0, 0, NULL, NULL }	/* sentinel */
 };
 
-struct board *match_board(__u32 machid, __u32 revision)
+static void wait(__u32 ticks)
+{
+	__u32 v;
+
+	/* OSCR */
+	writel(0, 0x40A00010);
+
+	do {
+		v = readl(0x40A00010);
+	} while (ticks > v);
+}
+
+static void led_init(void)
+{
+	writel(0, 0x40e10420);		/* GPIO35 */
+	writel(0, 0x40e10424);		/* GPIO36 */
+	writel(0x18, 0x40e00010);	/* GPDR1 */
+}
+
+static void led_set(__u32 index, __u32 state)
+{
+	__u32 v = 1 << (index ? 3 : 4);
+
+	if (state)
+		writel(v, 0x40e0001c);
+	else
+		writel(v, 0x40e00028);
+}
+
+static void led_panic(void)
 {
+	int i;
+
+	led_init();
+
+	for (i = 0;; i++) {
+		led_set(0, i & 1);
+		led_set(1, ~i & 1);
+		wait(500000);
+	}
+}
+struct board *match_board(__u32 machid, const struct tag *tags)
+{
+	const struct tag *t;
 	struct board *board;
+	__u32 system_rev = 0;
+
+	/* walk the atags to determine the system revision */
+	for_each_tag(t, tags)
+		switch (t->hdr.tag) {
+			case ATAG_REVISION:
+				system_rev = t->u.rev.rev;
+				break;
+		}
+
 
 	for (board = boards; board->machid; board++)
-		if (board->machid == machid && board->system_rev == revision)
-			return board;
+		if (board->machid == machid && board->system_rev == system_rev)
+			break;
 
-	return NULL;
-}
+	if (board->compatible == NULL) {
+		putstr("ERROR MATCHING BOARD!\n");
+		putstr("MACHID: 0x");
+		printhex(machid);
+		putstr("\n");
+		putstr("SYSTEM_REV: 0x");
+		printhex(system_rev);
+		putstr("\n");
+		led_panic(); /* doesn't return */
+	}
 
+	return board;
+}
diff --git a/board.h b/board.h
index b256a6c..ec2b79e 100644
--- a/board.h
+++ b/board.h
@@ -8,6 +8,6 @@ struct board {
 	const char	*name;
 };
 
-struct board *match_board(__u32 machid, __u32 revision);
+struct board *match_board(__u32 machid, const struct tag *);
 
 #endif
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
index 3dd6636..65ec9a7 100644
--- a/main.c
+++ b/main.c
@@ -2,39 +2,22 @@
 #include "atags.h"
 #include "print.h"
 #include "board.h"
-#include "led.h"
 
 extern __u32 _binary_input_zImage_start;
 
 void main(__u32 dummy, __u32 machid, const struct tag *tags)
 {
-	const struct tag *t;
 	struct board *board;
-	__u32 system_rev = 0;
 	void (*start_kernel)(__u32 dummy, __u32 machid, void *dtb) =
 		(void *) &_binary_input_zImage_start;
 
 	putstr("++ Impedance Matcher (3rd stage loader) ++\n");
 
-	/* walk the atags to determine the system revision */
-	for_each_tag(t, tags)
-		switch (t->hdr.tag) {
-			case ATAG_REVISION:
-				system_rev = t->u.rev.rev;
-				break;
-		}
-
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
+	/*
+	 * error resp. is board-specific, so won't return on error
+	 * eg - raumfeld boards blink a led indefinitely
+	 */
+	board = match_board(machid, tags);
 
 	putstr("Detected board: ");
 	putstr(board->name);
diff --git a/register.c b/register.c
new file mode 100644
index 0000000..5090f63
--- /dev/null
+++ b/register.c
@@ -0,0 +1,11 @@
+#include "types.h"
+
+inline void writel(__u32 val, __u32 addr)
+{
+	*(volatile __u32 *) addr = val;
+}
+
+inline __u32 readl(__u32 addr)
+{
+	return *(volatile __u32 *) addr;
+}
diff --git a/register.h b/register.h
new file mode 100644
index 0000000..2e5c10f
--- /dev/null
+++ b/register.h
@@ -0,0 +1,9 @@
+#ifndef _REGISTER_H
+#define _REGISTER_H
+
+#include "types.h"
+
+void writel(__u32, __u32);
+__u32 readl(__u32);
+
+#endif
-- 
1.8.3.2
