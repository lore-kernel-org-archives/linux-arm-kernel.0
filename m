From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:10 +0000
Subject: [RFC PATCH V2 3/9] rename board.c to board-raumfeld.c
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <31d8fb76052462b837e972828fd312d2f9d91739.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile         |   6 ++-
 board-raumfeld.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 board.c          | 153 -------------------------------------------------------
 3 files changed, 158 insertions(+), 154 deletions(-)
 create mode 100644 board-raumfeld.c
 delete mode 100644 board.c

diff --git a/Makefile b/Makefile
index 814326d..bb3a154 100644
--- a/Makefile
+++ b/Makefile
@@ -6,6 +6,10 @@ LD=$(CROSS_COMPILE)ld
 LOADADDR=0xa0008000
 BINFMT=elf32-littlearm
 
+MFG=raumfeld
+
+BOARD_OBJ = board-$(MFG).o
+
 COMMON_OBJS = \
 	main.o \
 	print.o \
@@ -34,7 +38,7 @@ zimage.o: input/zImage
 %.o: %.c
 	$(GCC) $(CFLAGS) -c $^
 
-matcher: $(COMMON_OBJS) board.o $(INPUT_OBJS)
+matcher: $(COMMON_OBJS) $(BOARD_OBJ) $(INPUT_OBJS)
 	$(LD) $(LDFLAGS) -T matcher.lds -o $@ $^
 
 matcher.bin: matcher
diff --git a/board-raumfeld.c b/board-raumfeld.c
new file mode 100644
index 0000000..fe51bcb
--- /dev/null
+++ b/board-raumfeld.c
@@ -0,0 +1,153 @@
+#include "atags.h"
+#include "board.h"
+#include "print.h"
+#include "register.h"
+#include "types.h"
+
+extern __u32 _binary_input_zImage_start;
+extern __u32 _binary_input_raumfeld_controller_0_dtb_start;
+extern __u32 _binary_input_raumfeld_controller_1_dtb_start;
+extern __u32 _binary_input_raumfeld_controller_2_dtb_start;
+extern __u32 _binary_input_raumfeld_connector_0_dtb_start;
+extern __u32 _binary_input_raumfeld_connector_1_dtb_start;
+extern __u32 _binary_input_raumfeld_connector_2_dtb_start;
+extern __u32 _binary_input_raumfeld_speaker_0_dtb_start;
+extern __u32 _binary_input_raumfeld_speaker_1_dtb_start;
+extern __u32 _binary_input_raumfeld_speaker_2_dtb_start;
+
+static struct board boards[] = {
+	/* Controller */
+	{
+		.machid		= 2413,
+		.system_rev	= 0,
+		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
+		.name		= "Raumfeld Controller, revision 0",
+	},
+	{
+		.machid		= 2413,
+		.system_rev	= 1,
+		.dtb		= &_binary_input_raumfeld_controller_1_dtb_start,
+		.name		= "Raumfeld Controller, revision 1",
+	},
+	{
+		.machid		= 2413,
+		.system_rev	= 2,
+		.dtb		= &_binary_input_raumfeld_controller_2_dtb_start,
+		.name		= "Raumfeld Controller, revision 2",
+	},
+
+	/* Controller */
+	{
+		.machid		= 2414,
+		.system_rev	= 0,
+		.dtb		= &_binary_input_raumfeld_connector_0_dtb_start,
+		.name		= "Raumfeld Connector, revision 0",
+	},
+	{
+		.machid		= 2414,
+		.system_rev	= 1,
+		.dtb		= &_binary_input_raumfeld_connector_1_dtb_start,
+		.name		= "Raumfeld Connector, revision 1",
+	},
+	{
+		.machid		= 2414,
+		.system_rev	= 2,
+		.dtb		= &_binary_input_raumfeld_connector_2_dtb_start,
+		.name		= "Raumfeld Connector, revision 2",
+	},
+
+	/* Speaker */
+	{
+		.machid		= 2415,
+		.system_rev	= 0,
+		.dtb		= &_binary_input_raumfeld_speaker_0_dtb_start,
+		.name		= "Raumfeld Speaker, revision 0",
+	},
+	{
+		.machid		= 2415,
+		.system_rev	= 1,
+		.dtb		= &_binary_input_raumfeld_speaker_1_dtb_start,
+		.name		= "Raumfeld Speaker, revision 1",
+	},
+	{
+		.machid		= 2415,
+		.system_rev	= 2,
+		.dtb		= &_binary_input_raumfeld_speaker_2_dtb_start,
+		.name		= "Raumfeld Speaker, revision 2",
+	},
+	{ 0, 0, NULL, NULL }	/* sentinel */
+};
+
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
+{
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
+	struct board *board;
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
+
+	for (board = boards; board->machid; board++)
+		if (board->machid == machid && board->system_rev == system_rev)
+			break;
+
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
+
+	return board;
+}
diff --git a/board.c b/board.c
deleted file mode 100644
index fe51bcb..0000000
--- a/board.c
+++ /dev/null
@@ -1,153 +0,0 @@
-#include "atags.h"
-#include "board.h"
-#include "print.h"
-#include "register.h"
-#include "types.h"
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
-static void led_panic(void)
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
-struct board *match_board(__u32 machid, const struct tag *tags)
-{
-	const struct tag *t;
-	struct board *board;
-	__u32 system_rev = 0;
-
-	/* walk the atags to determine the system revision */
-	for_each_tag(t, tags)
-		switch (t->hdr.tag) {
-			case ATAG_REVISION:
-				system_rev = t->u.rev.rev;
-				break;
-		}
-
-
-	for (board = boards; board->machid; board++)
-		if (board->machid == machid && board->system_rev == system_rev)
-			break;
-
-	if (board->compatible == NULL) {
-		putstr("ERROR MATCHING BOARD!\n");
-		putstr("MACHID: 0x");
-		printhex(machid);
-		putstr("\n");
-		putstr("SYSTEM_REV: 0x");
-		printhex(system_rev);
-		putstr("\n");
-		led_panic(); /* doesn't return */
-	}
-
-	return board;
-}
-- 
1.8.3.2
