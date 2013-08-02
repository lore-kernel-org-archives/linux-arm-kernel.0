From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:14 +0000
Subject: [RFC PATCH V2 7/9] add generic board code
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <9234c0e5648f94339b3976836216ffcfd13fc31c.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile        |  3 +-
 atags.h         |  8 ++++++
 board-generic.c | 39 +++++++++++++++++++++++++
 board.h         |  1 +
 main.c          |  5 +++-
 string.c        | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 string.h        |  8 ++++++
 7 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 board-generic.c
 create mode 100644 string.c
 create mode 100644 string.h

diff --git a/Makefile b/Makefile
index c799012..65e9f3b 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,8 @@ UART_OBJ = serial-$(UART).o
 COMMON_OBJS = \
 	main.o \
 	print.o \
-	register.o
+	register.o \
+	string.o
 
 INPUT_OBJS = \
 	zimage.o		\
diff --git a/atags.h b/atags.h
index 83f93a1..31ed999 100644
--- a/atags.h
+++ b/atags.h
@@ -17,10 +17,18 @@ struct tag_revision {
 	__u32 rev;
 };
 
+/* command line */
+#define ATAG_CMDLINE	0x54410009
+
+struct tag_cmdline {
+	char cmdline[1];	/* this is the minimum size */
+};
+
 struct tag {
 	struct tag_header hdr;
 	union {
 		struct tag_revision	rev;
+		struct tag_cmdline	cmdline;
 	} u;
 };
 
diff --git a/board-generic.c b/board-generic.c
new file mode 100644
index 0000000..4fa25ca
--- /dev/null
+++ b/board-generic.c
@@ -0,0 +1,39 @@
+#include "atags.h"
+#include "board.h"
+#include "print.h"
+#include "types.h"
+#include "string.h"
+
+struct board genboard;
+
+struct board *match_board(__u32 machid, const struct tag *tags)
+{
+	const struct tag *t;
+
+	/* walk the atags to get the command line */
+	for_each_tag(t, tags)
+		switch (t->hdr.tag) {
+			case ATAG_CMDLINE:
+				getaddrs(&genboard.kernel, &genboard.dtb,
+					t->u.cmdline.cmdline);
+				break;
+		}
+
+	if (genboard.kernel) {
+		putstr("Kernel: 0x");
+		printhex((__u32)genboard.kernel);
+	} else
+		putstr("Kernel: Appended");
+	putstr("\n");
+
+	if (genboard.dtb) {
+		putstr("DTB:    0x");
+		printhex((__u32)genboard.dtb);
+	} else
+		putstr("** DTB Not Found! **");
+	putstr("\n");
+
+	genboard.compatible = NULL;
+
+	return &genboard;
+}
diff --git a/board.h b/board.h
index af64e94..a28fb06 100644
--- a/board.h
+++ b/board.h
@@ -8,6 +8,7 @@ struct board {
 	__u32		machid;
 	__u32		system_rev;
 	void		*dtb;
+	void		*kernel;
 	const char	*compatible;
 };
 
diff --git a/main.c b/main.c
index 8673703..ed25842 100644
--- a/main.c
+++ b/main.c
@@ -20,7 +20,10 @@ void main(__u32 dummy, __u32 machid, const struct tag *tags)
 	board = match_board(machid, tags);
 
 	putstr("Detected board: ");
-	putstr(board->compatible);
+	if (board->compatible)
+		putstr(board->compatible);
+	else
+		putstr("Not given.");
 	putstr("\n");
 
 	putstr("Booting into Linux kernel ...\n");
diff --git a/string.c b/string.c
new file mode 100644
index 0000000..6584378
--- /dev/null
+++ b/string.c
@@ -0,0 +1,89 @@
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
+	while ((a - stra) < len)
+		diff += *(a++) - *(b++);
+
+	return diff;
+}
+
+void *gethexaddr(const char *str, const char **end)
+{
+	const char *s = str;
+	char *e;
+	void *addr = NULL;
+	int shift = 0;
+
+	/* set the end */
+	while (*s) {
+		if (*s == ' ' || *s == '\t' || *s == ',')
+			break;
+		s++;
+	}
+
+	if (!*s)
+		return NULL;
+
+	e = (char *)s;
+	s = (const char *)(e - 1);
+
+	while (s >= str && *s != 'x') {
+		/* we assume base16! */
+		int off = (*s > 'F') ? 0x20 : 0x0;
+		addr += hexlut[*s - ('0' + off)] << shift;
+		shift += 4;
+		s--;
+	}
+
+	if (end)
+		*end = e;
+
+	return addr;
+}
+
+int getaddrs(void **k, void **d, const char *str)
+{
+	const char *s = str;
+	const char *end;
+
+	while (*s) {
+		if (*s == 'l')
+			if (strncmp(s, "loadaddrs=", 10) == 0)
+				break;
+
+		s++;
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
index 0000000..59f5f0c
--- /dev/null
+++ b/string.h
@@ -0,0 +1,8 @@
+#ifndef _STRING_H
+#define _STRING_H
+
+int strncmp(const char *, const char *, int);
+void *gethexaddr(const char *, const char **);
+int getaddrs(void **, void **, const char *);
+
+#endif
-- 
1.8.3.2
