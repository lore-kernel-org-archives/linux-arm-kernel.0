From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 21 Nov 2017 18:27:51 +0100
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
Message-ID: <20171121172751.29545-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On older versions of binutils, \sym points to an aligned address. On
newer versions of binutils, \sym sometimes points to the unaligned thumb
address in mysterious and buggy circumstances. In order to homogenize
this behavior, rather than adding 1, we simply OR in 1, so that already
unaligned instructions don't change. This fix is required for a
pedestrian THUMB2_KERNEL to boot without crashing when built with
non-old binutils.

While it works, the downside is that we have to add an `orr` instruction
to a fast path. The assembler can't do this at assemble time via "|1"
because "invalid operands (.text and *ABS* sections) for `|'", so we're
forced to do this. A better solution would be to have consistent
binutils behavior, or to have some kind of \sym feature detection that
won't turn into a maze of version comparisons. However, it's at the
moment unclear how to achieve this.

The rest of this commit message contains all of the relevant
information.

My tests concerned these versions:
    broken: GNU ld (Gentoo 2.29.1 p3) 2.29.1
    working: GNU ld (GNU Binutils for Ubuntu) 2.26.1

These produced the following code:
--- broken      2017-11-21 17:44:14.523416082 +0100
+++ working     2017-11-21 17:44:44.548461234 +0100
@@ -133,7 +133,7 @@
  160:  f01a 0ff0       tst.w   sl, #240        ; 0xf0
  164:  d111            bne.n   18a <__sys_trace>
  166:  f5b7 7fc8       cmp.w   r7, #400        ; 0x190
- 16a:  f2af 1e6a       subw    lr, pc, #362    ; 0x16a
+ 16a:  f2af 1e6b       subw    lr, pc, #363    ; 0x16b
  16e:  bf38            it      cc
  170:  f858 f027       ldrcc.w pc, [r8, r7, lsl #2]
  174:  a902            add     r1, sp, #8

The differing instruction corresponds with this actual line in
arch/arm/kernel/entry-common.S:
      badr    lr, ret_fast_syscall            @ return address

Running the broken kernel results in a runtime OOPS with:
    PC is at ret_fast_syscall+0x4/0x52
    LR is at ret_fast_syscall+0x2/0x52

The disassembly of that function for the crashing kernel is:
.text:00000000 ret_fast_syscall                        ; CODE XREF: sys_syscall+1C?j
.text:00000000                 CPSID           I       ; jumptable 00000840 cases 15,18-376
.text:00000002
.text:00000002 loc_2                                   ; DATA XREF: sys_syscall-6BA?o
.text:00000002                 LDR.W           R2, [R9,#8]
.text:00000006                 CMP.W           R2, #0xBF000000

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable at vger.kernel.org
---
 arch/arm/include/asm/assembler.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index ad301f107dd2..c62a3b6b0a3e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -194,10 +194,9 @@
  */
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
-#ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
-#else
 	adr\c	\rd, \sym
+#ifdef CONFIG_THUMB2_KERNEL
+	orr\c	\rd, \rd, 1
 #endif
 	.endm
 	.endr
-- 
2.15.0
