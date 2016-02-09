From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  9 Feb 2016 16:13:46 +0100
Subject: [PATCH v4 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <1455030828-6416-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455030828-6416-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455030828-6416-2-git-send-email-ard.biesheuvel@linaro.org>
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
addresses are below it are filtered out. Note that this special case only
applies to CONFIG_XIP_KERNEL=n, not because the issue the patch addresses
exists only in that case, but because finding a limit below which to apply
the filtering is not entirely straightforward.

Since the .vectors and .stubs sections contain position independent code
that is never executed in place, we can emit it at its most likely runtime
VMA (for more recent CPUs), which is 0xffff0000 for the vector table and
0xffff1000 for the stubs. Not only does this fix the perf issue with
kallsyms, allowing us to drop the special case in scripts/kallsyms
entirely, it also gives debuggers a more realistic view of the address
space, and setting breakpoints or single stepping through code in the
vector table or the stubs is more likely to work as expected on CPUs that
use a high vector address. E.g.,

  00001240 A vector_fiq_offset
  ...
  c0c35000 T __init_begin
  c0c35000 T __vectors_start
  c0c35020 T __stubs_start
  c0c35020 T __vectors_end
  c0c352e0 T _sinittext
  c0c352e0 T __stubs_end
  ...
  ffff1004 t vector_rst
  ffff1020 t vector_irq
  ffff10a0 t vector_dabt
  ffff1120 t vector_pabt
  ffff11a0 t vector_und
  ffff1220 t vector_addrexcptn
  ffff1240 T vector_fiq

(Note that vector_fiq_offset is now an absolute symbol, which kallsyms
already ignores by default)

The LMA footprint is identical with or without this change, only the VMAs
are different:

  Before:
  Idx Name          Size      VMA       LMA       File off  Algn
   ...
   14 .notes        00000024  c0c34020  c0c34020  00a34020  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   15 .vectors      00000020  00000000  c0c35000  00a40000  2**1
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   16 .stubs        000002c0  00001000  c0c35020  00a41000  2**5
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   17 .init.text    0006b1b8  c0c352e0  c0c352e0  00a452e0  2**5
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   ...

  After:
  Idx Name          Size      VMA       LMA       File off  Algn
   ...
   14 .notes        00000024  c0c34020  c0c34020  00a34020  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   15 .vectors      00000020  ffff0000  c0c35000  00a40000  2**1
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   16 .stubs        000002c0  ffff1000  c0c35020  00a41000  2**5
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   17 .init.text    0006b1b8  c0c352e0  c0c352e0  00a452e0  2**5
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
   ...

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/entry-armv.S      | 3 +--
 arch/arm/kernel/vmlinux-xip.lds.S | 6 ++++--
 arch/arm/kernel/vmlinux.lds.S     | 6 ++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 788e40c1254f..e2550500486d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1201,8 +1201,7 @@ vector_addrexcptn:
 	.long	__fiq_svc			@  e
 	.long	__fiq_svc			@  f
 
-	.globl	vector_fiq_offset
-	.equ	vector_fiq_offset, vector_fiq
+	.globl	vector_fiq
 
 	.section .vectors, "ax", %progbits
 .L__vectors_start:
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 6f59ef290289..7b1ded6fb628 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -154,19 +154,21 @@ SECTIONS
 	 * only thing that matters is their relative offsets
 	 */
 	__vectors_start = .;
-	.vectors 0 : AT(__vectors_start) {
+	.vectors 0xffff0000 : AT(__vectors_start) {
 		*(.vectors)
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
-	.stubs 0x1000 : AT(__stubs_start) {
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
 		*(.stubs)
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
 
+	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
+
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index cdc84693091b..e087a2ed112b 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -164,19 +164,21 @@ SECTIONS
 	 * only thing that matters is their relative offsets
 	 */
 	__vectors_start = .;
-	.vectors 0 : AT(__vectors_start) {
+	.vectors 0xffff0000 : AT(__vectors_start) {
 		*(.vectors)
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
 
 	__stubs_start = .;
-	.stubs 0x1000 : AT(__stubs_start) {
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
 		*(.stubs)
 	}
 	. = __stubs_start + SIZEOF(.stubs);
 	__stubs_end = .;
 
+	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
+
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
-- 
2.5.0
