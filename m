From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 11:52:57 +0100
Subject: [PATCH] ARM: kvm: implement replacement for ld's LOG2CEIL()
Message-ID: <1427107977-18591-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 06f75a1f6200 ("ARM, arm64: kvm: get rid of the bounce
page") uses ld's builtin function LOG2CEIL() to align the
KVM init code to a log2 upper bound of its size. However,
this function turns out to be a fairly recent addition to
binutils, which breaks the build for older toolchains.

So instead, implement a replacement LOG2_ROUNDUP() using
the C preprocessor.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Linker map output after applying this patch:

                0xc09a2590                __idmap_text_end = .
                [...]
 *fill*         0xc09a2590       0x70 
                0xc09a2600                __hyp_idmap_text_start = .
 *(.hyp.idmap.text)
 .hyp.idmap.text
                0xc09a2600      0x100 arch/arm/kvm/built-in.o
                0xc09a2600                __kvm_hyp_init
                0xc09a26ec                __kvm_hyp_init_end
                0xc09a2700                __hyp_idmap_text_end = .

which confirms that the alignemnt is correct. The size of the region
is 0xec bytes, and 0x70 bytes of padding are emitted to align it at
a 0x100 byte boundary

 arch/arm/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index ba65f1217310..2d760df0d57d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -11,7 +11,27 @@
 #ifdef CONFIG_ARM_KERNMEM_PERMS
 #include <asm/pgtable.h>
 #endif
-	
+
+/*
+ * Poor man's version of LOG2CEIL(), which is
+ * not available in binutils before v2.24.
+ */
+#define LOG2_ROUNDUP(size) (		\
+	__LOG2_ROUNDUP(size,  2)	\
+	__LOG2_ROUNDUP(size,  3)	\
+	__LOG2_ROUNDUP(size,  4)	\
+	__LOG2_ROUNDUP(size,  5)	\
+	__LOG2_ROUNDUP(size,  6)	\
+	__LOG2_ROUNDUP(size,  7)	\
+	__LOG2_ROUNDUP(size,  8)	\
+	__LOG2_ROUNDUP(size,  9)	\
+	__LOG2_ROUNDUP(size, 10)	\
+	__LOG2_ROUNDUP(size, 11)	\
+	12)
+
+#define __LOG2_ROUNDUP(size, order)	\
+	(size) <= (1 << order) ? order :
+
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
@@ -23,7 +43,7 @@
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
-	. = ALIGN(1 << LOG2CEIL(__hyp_idmap_size));			\
+	. = ALIGN(1 << LOG2_ROUNDUP(__hyp_idmap_size));			\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
-- 
1.8.3.2
