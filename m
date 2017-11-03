From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:46 -0700
Subject: [PATCH 02/15] kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION with GNU gold
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-3-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't remove .head.text or .exitcall.exit when linking with --gc-sections,
and include .init.text.* in .init.text and .init.rodata.* in .init.rodata.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8acfc1e099e1..d0070985c191 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -511,7 +511,7 @@
 		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
 
 /* Section used for early init (in .S files) */
-#define HEAD_TEXT  *(.head.text)
+#define HEAD_TEXT  KEEP(*(.head.text))
 
 #define HEAD_TEXT_SECTION							\
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
@@ -556,7 +556,7 @@
 	MEM_DISCARD(init.data)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
-	*(.init.rodata)							\
+	*(.init.rodata .init.rodata.*)					\
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
@@ -575,7 +575,7 @@
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
-	*(.init.text)							\
+	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
 	MEM_DISCARD(init.text)
 
@@ -592,7 +592,7 @@
 	MEM_DISCARD(exit.text)
 
 #define EXIT_CALL							\
-	*(.exitcall.exit)
+	KEEP(*(.exitcall.exit))
 
 /*
  * bss (Block Started by Symbol) - uninitialized data
-- 
2.15.0.403.gc27cc4dac6-goog
