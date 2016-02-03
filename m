From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Feb 2016 20:04:54 +0100
Subject: [PATCH v2 1/4] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454526297-5269-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b9b32bf70f2f ("ARM: use linker magic for vectors and vector stubs")
updated the linker script to emit the .vectors and .stubs sections into a
VMA range that is zero based and disjoint from the normal static kernel
region. The reason for that was that this way, the sections can be placed
exactly 4 KB apart, while the payload of the .vectors section is only 32
bytes.

Since the symbols that are part of the .stubs section are emitted into the
kallsyms table, they appear with zero based addresses as well, e.g.,

  00000000 t __vectors_start
  00001000 t __stubs_start
  00001004 t vector_rst
  00001020 t vector_irq
  000010a0 t vector_dabt
  00001120 t vector_pabt
  000011a0 t vector_und
  00001220 t vector_addrexcptn
  00001240 t vector_fiq
  00001240 T vector_fiq_offset

As this confuses perf when it accesses the kallsyms tables, commit
7122c3e9154b ("scripts/link-vmlinux.sh: only filter kernel symbols for
arm") implemented a somewhat ugly special case for ARM, where the value
of CONFIG_PAGE_OFFSET is passed to scripts/kallsyms, and symbols whose
address is below it are filtered out. Note that this special case only
applies to CONFIG_XIP_KERNEL=n, not because the issue the patch addresses
exists only in that case, but because finding a limit below which to apply
the filtering is too difficult.

Since the constraint we are trying to meet here is that the .vectors
section lives exactly 4 KB before the .stubs section, regardless of the
absolute addresses of either (since relative branches are used to jump from
the vector table to the stubs), we can simply emit the .stubs section as
part of the kernel VMA, and place the .vectors section 4 KB before it using
an explicit VMA override. By doing that, and renaming the __vectors_start
symbol that is local to arch/arm/kernel/entry-armv.S (not the one in the
linker script), the kallsyms table looks somewhat sane, regardless of
whether CONFIG_XIP_KERNEL is set, and we can drop the special case in
scripts/kallsyms entirely. E.g.,

  00001240 A vector_fiq_offset
  ...
  c0c35000 T __init_begin
  c0c35000 t __stubs_start
  c0c35000 T __stubs_start
  c0c35004 t vector_rst
  c0c35020 t vector_irq
  c0c350a0 t vector_dabt
  c0c35120 t vector_pabt
  c0c351a0 t vector_und
  c0c35220 t vector_addrexcptn
  c0c35240 T vector_fiq
  c0c352c0 T __stubs_end
  c0c352c0 T __vectors_start
  c0c352e0 t __mmap_switched
  c0c352e0 T _sinittext
  c0c352e0 T __vectors_end

(Note that vector_fiq_offset is now an absolute symbol, which kallsyms
already ignores by default)

The sections themselves are emitted 4 KB apart, as required:
  ...
  [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
  [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
  ...

and the relative branches in the .vectors section still point to the
right place:

  c0c34000 <.vectors>:
  c0c34000:       f001 b800       b.w     c0c35004 <vector_rst>
  c0c34004:       f001 b8cc       b.w     c0c351a0 <vector_und>
  c0c34008:       f8df fff4       ldr.w   pc, [pc, #4084] ; c0c35000
  c0c3400c:       f001 b888       b.w     c0c35120 <vector_pabt>
  c0c34010:       f001 b846       b.w     c0c350a0 <vector_dabt>
  c0c34014:       f001 b904       b.w     c0c35220 <vector_addrexcptn>
  c0c34018:       f001 b802       b.w     c0c35020 <vector_irq>
  c0c3401c:       f001 b910       b.w     c0c35240 <vector_fiq>

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/entry-armv.S  |  7 +++----
 arch/arm/kernel/vmlinux.lds.S | 15 ++++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3ce377f7251f..8575ff42c0d4 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1202,14 +1202,13 @@ vector_addrexcptn:
 	.long	__fiq_svc			@  e
 	.long	__fiq_svc			@  f
 
-	.globl	vector_fiq_offset
-	.equ	vector_fiq_offset, vector_fiq
+	.globl	vector_fiq
 
 	.section .vectors, "ax", %progbits
-__vectors_start:
+.L__vectors_start:
 	W(b)	vector_rst
 	W(b)	vector_und
-	W(ldr)	pc, __vectors_start + 0x1000
+	W(ldr)	pc, .L__vectors_start + 0x1000
 	W(b)	vector_pabt
 	W(b)	vector_dabt
 	W(b)	vector_addrexcptn
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde5ce48..9f96a54c7d90 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -164,19 +164,20 @@ SECTIONS
 	 * The vectors and stubs are relocatable code, and the
 	 * only thing that matters is their relative offsets
 	 */
+	.stubs : {
+		__stubs_start = .;
+		*(.stubs)
+		__stubs_end = .;
+	}
+
 	__vectors_start = .;
-	.vectors 0 : AT(__vectors_start) {
+	.vectors ADDR(.stubs) - 0x1000 : AT(__vectors_start) {
 		*(.vectors)
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
-	__stubs_start = .;
-	.stubs 0x1000 : AT(__stubs_start) {
-		*(.stubs)
-	}
-	. = __stubs_start + SIZEOF(.stubs);
-	__stubs_end = .;
+	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
 
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
-- 
2.5.0
