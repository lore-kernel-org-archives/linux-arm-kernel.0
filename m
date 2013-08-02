From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:15 +0000
Subject: [RFC PATCH V2 8/9] make appending images/dtbs optional
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <4c634732b7e4cda4b56b57039b365af0e3ba4102.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 .gitignore     |  1 -
 Makefile       | 35 ++++++++++++++++-------------------
 append_dtbs.sh |  8 ++++++++
 main.c         | 15 +++++++++++++--
 matcher.lds    |  8 ++++++--
 5 files changed, 43 insertions(+), 24 deletions(-)
 create mode 100755 append_dtbs.sh

diff --git a/.gitignore b/.gitignore
index ac4198c..e0ebf62 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,3 @@
-*.sh
 *.o
 *.bin
 cscope.*
diff --git a/Makefile b/Makefile
index 65e9f3b..c9b2381 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,13 @@
-CFLAGS=-Wall -ffreestanding
+ifneq ($(origin APPEND_KERNEL), undefined)
+INPUT_OBJS=zimage.o
+CFLAGS+=-DAPPEND_KERNEL="$(APPEND_KERNEL)"
+endif
+
+ifneq ($(origin APPEND_DTBS), undefined)
+CFLAGS+=-DAPPEND_DTBS="$(APPEND_DTBS)"
+endif
+
+CFLAGS+=-Wall -ffreestanding
 LDFLAGS=-static -nostdlib
 GCC=$(CROSS_COMPILE)gcc
 OBJCOPY=$(CROSS_COMPILE)objcopy
@@ -21,34 +30,22 @@ COMMON_OBJS = \
 	register.o \
 	string.o
 
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
-zimage.o: input/zImage
+zimage.o: $(APPEND_KERNEL)
 	$(OBJCOPY) -I binary -O $(BINFMT) -B arm $^ $@
 
 %.o: %.c
 	$(GCC) $(CFLAGS) -c $^
 
 matcher: $(COMMON_OBJS) $(BOARD_OBJ) $(UART_OBJ) $(INPUT_OBJS)
-	$(LD) $(LDFLAGS) -T matcher.lds -o $@ $^
+	$(LD) $(LDFLAGS) -T matcher.lds -Ttext $(LOADADDR) -o $@ $^
 
 matcher.bin: matcher
-	$(OBJCOPY) -O binary $^ $@
+	$(OBJCOPY) -O binary --set-section-flags .bss=alloc,load,contents $^ $@
+ifneq ($(origin APPEND_DTBS), undefined)
+	./append_dtbs.sh $@ $(APPEND_DTBS)
+endif
 
 uImage: matcher.bin
 	mkimage -A arm -O linux -C none -T kernel \
diff --git a/append_dtbs.sh b/append_dtbs.sh
new file mode 100755
index 0000000..82bb463
--- /dev/null
+++ b/append_dtbs.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+OUT="$1"
+shift
+DTBS="$*"
+
+cat $DTBS >>$OUT
+dd if=/dev/zero of=$OUT oflag=append conv=notrunc bs=1 count=8 #sentinel
diff --git a/main.c b/main.c
index ed25842..c64a083 100644
--- a/main.c
+++ b/main.c
@@ -3,13 +3,21 @@
 #include "print.h"
 #include "board.h"
 
+#ifdef APPEND_KERNEL
 extern __u32 _binary_input_zImage_start;
+#endif
+
+void main(__u32 dummy, __u32 machid, const struct tag *tags)
+	__attribute__((section(".text_main")));
 
 void main(__u32 dummy, __u32 machid, const struct tag *tags)
 {
 	struct board *board;
-	void (*start_kernel)(__u32 dummy, __u32 machid, void *dtb) =
-		(void *) &_binary_input_zImage_start;
+	void (*start_kernel)(__u32 dummy, __u32 machid, void *dtb);
+
+#ifdef APPEND_KERNEL
+	start_kernel = (void *) &_binary_input_zImage_start;
+#endif
 
 	putstr("++ Impedance Matcher (3rd stage loader) ++\n");
 
@@ -26,6 +34,9 @@ void main(__u32 dummy, __u32 machid, const struct tag *tags)
 		putstr("Not given.");
 	putstr("\n");
 
+	if (board->kernel)
+		start_kernel = board->kernel;
+
 	putstr("Booting into Linux kernel ...\n");
 	start_kernel(0, 0xffffffff, board->dtb);
 }
diff --git a/matcher.lds b/matcher.lds
index 96eb16a..7b85010 100644
--- a/matcher.lds
+++ b/matcher.lds
@@ -1,6 +1,10 @@
 SECTIONS {
-	. = 0x10008000;
-	.text : { * (.text); }
+	.text : { * (.text_main); * (.text); }
 	.data : { * (.data); }
 	.rodata : { * (.rodata); }
+	.bss :
+	{
+		* (.bss);
+	}
+	PROVIDE (__end_of_image = .) ;
 }
-- 
1.8.3.2
