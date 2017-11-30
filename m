From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:38:59 -0800
Subject: [PATCH v2 1/7] kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-2-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't remove .head.text or .exitcall.exit when linking with --gc-sections,
and include .init.text.* in .init.text and .init.rodata.* in .init.rodata.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ee8b707d9fa9..eb4199c12bd2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -515,7 +515,7 @@
 		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
 
 /* Section used for early init (in .S files) */
-#define HEAD_TEXT  *(.head.text)
+#define HEAD_TEXT  KEEP(*(.head.text))
 
 #define HEAD_TEXT_SECTION							\
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
@@ -560,7 +560,7 @@
 	MEM_DISCARD(init.data)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
-	*(.init.rodata)							\
+	*(.init.rodata .init.rodata.*)					\
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
@@ -579,7 +579,7 @@
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
-	*(.init.text)							\
+	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
 	MEM_DISCARD(init.text)
 
@@ -596,7 +596,7 @@
 	MEM_DISCARD(exit.text)
 
 #define EXIT_CALL							\
-	*(.exitcall.exit)
+	KEEP(*(.exitcall.exit))
 
 /*
  * bss (Block Started by Symbol) - uninitialized data
-- 
2.15.0.531.g2ccb3012c9-goog
