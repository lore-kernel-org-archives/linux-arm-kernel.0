From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Thu, 23 Nov 2017 11:47:56 +0100
Subject: Fwd: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <20171123103518.GL31757@n2100.armlinux.org.uk>
References: <20171121172751.29545-1-Jason@zx2c4.com>
 <20171121173857.GJ31757@n2100.armlinux.org.uk>
 <CAHmME9quDFbdOR9hKRz-Px=Mh3FvYEyhVrs4V_+JT+GjDajMrA@mail.gmail.com>
 <20171121174942.GK31757@n2100.armlinux.org.uk>
 <CAHmME9oMTNJFnOwfhu26QSRSP92Axbc-+v9cCPsTKxekZvGvxg@mail.gmail.com>
 <20171123103518.GL31757@n2100.armlinux.org.uk>
Message-ID: <CAHmME9qBxgDV-HGeqj75ohr=4Bf+TD73PcC0DUqTRh5PTOKyhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nick & Binutils developers,

It would appear that recent changes in the binutils assembler (perhaps
52a86f843b6dee1de9977293da9786649b146b05? perhaps not?) have broken
the kernel when compiled in thumb2 mode. We currently do not have a
way of working around your breaking changes without adding additional
runtime instructions, which isn't acceptable for us. Details are
included in the thread below.

Thanks,
Jason

Forwarded conversation
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
------------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue, Nov 21, 2017 at 6:27 PM
To: linux at armlinux.org.uk, linux-arm-kernel at lists.infradead.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable at vger.kernel.org


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
.text:00000000 ret_fast_syscall                        ; CODE XREF:
sys_syscall+1C?j
.text:00000000                 CPSID           I       ; jumptable
00000840 cases 15,18-376
.text:00000002
.text:00000002 loc_2                                   ; DATA XREF:
sys_syscall-6BA?o
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
        .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
        .macro  badr\c, rd, sym
-#ifdef CONFIG_THUMB2_KERNEL
-       adr\c   \rd, \sym + 1
-#else
        adr\c   \rd, \sym
+#ifdef CONFIG_THUMB2_KERNEL
+       orr\c   \rd, \rd, 1
 #endif
        .endm
        .endr
--
2.15.0


----------
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Tue, Nov 21, 2017 at 6:38 PM
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org, lkml at vger.kernel.org,
stable at vger.kernel.org


As it just seems to be a limited range of binutils versions that are
affected, I'd rather not impact the kernel fast-paths with extra
cycles just because binutils decided to change behaviour.  I'd prefer
to inform people about the problem and get them to change to a non-
buggy binutils.

This seems to be the second binutils bug that's biting us within the
last month... what's going on with binutils QA?

 arch/arm/Makefile        |  7 +++++--
 arch/arm/tools/Makefile  |  5 ++++-
 arch/arm/tools/toolcheck | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1cfac5119545..9e70d0435121 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -319,16 +319,19 @@ all:      $(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
 archheaders:
        $(Q)$(MAKE) $(build)=arch/arm/tools uapi

-archprepare:
+archprepare: toolcheck
        $(Q)$(MAKE) $(build)=arch/arm/tools kapi

+toolcheck:
+       $(Q)$(MAKE) $(build)=arch/arm/tools $@
+
 # Convert bzImage to zImage
 bzImage: zImage

 BOOT_TARGETS   = zImage Image xipImage bootpImage uImage
 INSTALL_TARGETS        = zinstall uinstall install

-PHONY += bzImage $(BOOT_TARGETS) $(INSTALL_TARGETS)
+PHONY += bzImage $(BOOT_TARGETS) $(INSTALL_TARGETS) toolcheck

 bootpImage uImage: zImage
 zImage: Image
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index ddb89a7db36f..fa77351ccefd 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -23,12 +23,15 @@ uapi-hdrs-y += $(uapi)/unistd-eabi.h

 targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))

-PHONY += kapi uapi
+PHONY += kapi uapi toolcheck

 kapi:  $(kapi-hdrs-y) $(gen-y)

 uapi:  $(uapi-hdrs-y)

+toolcheck:
+       @$(CONFIG_SHELL) '$(srctree)/$(src)/toolcheck'
+
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
           $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
diff --git a/arch/arm/tools/toolcheck b/arch/arm/tools/toolcheck
index e69de29bb2d1..97bbeeb691da 100644
--- a/arch/arm/tools/toolcheck
+++ b/arch/arm/tools/toolcheck
@@ -0,0 +1,24 @@
+#!/bin/sh -ex
+if grep -q 'CONFIG_THUMB2_KERNEL=y' .config; then
+   tmp=$(mktemp -d /tmp/binutils-test.XXXXXXXXXX)
+   cat <<EOF | $AS $ASFLAGS -o $tmp/test.o
+       .syntax unified
+       .thumb
+       .macro  badr, reg, sym
+       adr     \reg, \sym + 1
+       .endm
+
+test:
+       mov     r0, #0
+       badr    lr, test
+EOF
+   if ! $OBJDUMP -d $tmp/test.o | grep -q '4:\s*f2af 0e07'; then
+      echo "Error: your assembler version produces buggy kernels" >&2
+      $AS --version | head -n1 >&2
+      rm $tmp/*.o
+      rmdir $tmp
+      exit 1
+   fi
+   rm $tmp/*.o
+   rmdir $tmp
+fi

----------
From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue, Nov 21, 2017 at 6:46 PM
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>,
linux-arm-kernel at lists.infradead.org, lkml at vger.kernel.org,
stable at vger.kernel.org


Hi Russell,

This doesn't actually catch the issues. In the buggy binutils, it
appears that sometimes adr grabs the right symbol and sometimes it
doesn't. I'm not yet able to figure out a minimal condition for it
going one way or the other.

Jason

----------
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Thu, Nov 23, 2017 at 11:35 AM
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Will Deacon <will.deacon@arm.com>,
linux-arm-kernel at lists.infradead.org, lkml at vger.kernel.org,
stable at vger.kernel.org


On Thu, Nov 23, 2017 at 12:34:08AM +0100, Jason A. Donenfeld wrote:
> On Tue, Nov 21, 2017 at 6:49 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > What if we locate the "badr" instruction to the same offset - does
> > that trigger the binutils bug?  Note that the grep expression will
> > need updating...
>
> Nope, this too does not reproduce it. I'm having a bit of trouble
> making a minimal test case to reproduce it. But I can reproduce it
> everytime by simply assembling the file in question using that
> binutils.

If it's that hard to reproduce it, it makes me wonder if it's being
caused by some memory allocation being re-used without full
initialisation, and it's reading stale data.

We can't easily build entry-common.o and check it for the problem as the
position of the "local_restart" code depends on various configuration
options.

I found this URL:

https://fossies.org/diffs/binutils/2.28_vs_2.29/gas/config/tc-arm.c-diff.html

and if you search down to around "line 8358", which is in do_adr(),
there is this new code added:

      if (inst.reloc.exp.X_op == O_symbol
          && inst.reloc.exp.X_add_symbol != NULL
          && S_IS_DEFINED (inst.reloc.exp.X_add_symbol)
          && THUMB_IS_FUNC (inst.reloc.exp.X_add_symbol))
        inst.reloc.exp.X_add_number += 1;

which would account for the issue you're seeing.

Given that this change breaks openssl, and breaks the kernel, and
this behaviour is something that we've come to rely upon in the
kernel since T2 was introduced, and there's no way around it without
adding additional instructions, I have to ask what the hell binutils
people think they are doing changing the behaviour of the assembler
in such a gratuitous way, and how they think that users of their
crapware are going to be able to write code that assembles correctly
on both pre-2.29 assemblers and post-2.29 assemblers.

Sorry, but gratuitous changes like this in the toolchain really
annoy me, and just give me more reason to stick with my old known
working versions (binutils 2.25, gcc 4.7.4!) rather than move
forward and then not know whether bugs are due to crappy toolchains
or really something wrong in the program.

binutils people need to realise that what they offer is an interface
for converting assembly code into opcodes and if they change the
translation of that in a visible way, people are going to get
annoyed - just like if we in the kernel change the kernel's user
visible API.

IMHO, binutils should have exactly the same rules - if a change causes
a regression for a user, the change is wrong and should be reverted.
