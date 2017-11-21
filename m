From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Nov 2017 17:38:57 +0000
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <20171121172751.29545-1-Jason@zx2c4.com>
References: <20171121172751.29545-1-Jason@zx2c4.com>
Message-ID: <20171121173857.GJ31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 06:27:51PM +0100, Jason A. Donenfeld wrote:
> On older versions of binutils, \sym points to an aligned address. On
> newer versions of binutils, \sym sometimes points to the unaligned thumb
> address in mysterious and buggy circumstances. In order to homogenize
> this behavior, rather than adding 1, we simply OR in 1, so that already
> unaligned instructions don't change. This fix is required for a
> pedestrian THUMB2_KERNEL to boot without crashing when built with
> non-old binutils.
> 
> While it works, the downside is that we have to add an `orr` instruction
> to a fast path. The assembler can't do this at assemble time via "|1"
> because "invalid operands (.text and *ABS* sections) for `|'", so we're
> forced to do this. A better solution would be to have consistent
> binutils behavior, or to have some kind of \sym feature detection that
> won't turn into a maze of version comparisons. However, it's at the
> moment unclear how to achieve this.
> 
> The rest of this commit message contains all of the relevant
> information.
> 
> My tests concerned these versions:
>     broken: GNU ld (Gentoo 2.29.1 p3) 2.29.1
>     working: GNU ld (GNU Binutils for Ubuntu) 2.26.1
> 
> These produced the following code:
> --- broken      2017-11-21 17:44:14.523416082 +0100
> +++ working     2017-11-21 17:44:44.548461234 +0100
> @@ -133,7 +133,7 @@
>   160:  f01a 0ff0       tst.w   sl, #240        ; 0xf0
>   164:  d111            bne.n   18a <__sys_trace>
>   166:  f5b7 7fc8       cmp.w   r7, #400        ; 0x190
> - 16a:  f2af 1e6a       subw    lr, pc, #362    ; 0x16a
> + 16a:  f2af 1e6b       subw    lr, pc, #363    ; 0x16b
>   16e:  bf38            it      cc
>   170:  f858 f027       ldrcc.w pc, [r8, r7, lsl #2]
>   174:  a902            add     r1, sp, #8
> 
> The differing instruction corresponds with this actual line in
> arch/arm/kernel/entry-common.S:
>       badr    lr, ret_fast_syscall            @ return address
> 
> Running the broken kernel results in a runtime OOPS with:
>     PC is at ret_fast_syscall+0x4/0x52
>     LR is at ret_fast_syscall+0x2/0x52
> 
> The disassembly of that function for the crashing kernel is:
> .text:00000000 ret_fast_syscall                        ; CODE XREF: sys_syscall+1C?j
> .text:00000000                 CPSID           I       ; jumptable 00000840 cases 15,18-376
> .text:00000002
> .text:00000002 loc_2                                   ; DATA XREF: sys_syscall-6BA?o
> .text:00000002                 LDR.W           R2, [R9,#8]
> .text:00000006                 CMP.W           R2, #0xBF000000
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

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
@@ -319,16 +319,19 @@ all:	$(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/arm/tools uapi
 
-archprepare:
+archprepare: toolcheck
 	$(Q)$(MAKE) $(build)=arch/arm/tools kapi
 
+toolcheck:
+	$(Q)$(MAKE) $(build)=arch/arm/tools $@
+
 # Convert bzImage to zImage
 bzImage: zImage
 
 BOOT_TARGETS	= zImage Image xipImage bootpImage uImage
 INSTALL_TARGETS	= zinstall uinstall install
 
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
 
 kapi:	$(kapi-hdrs-y) $(gen-y)
 
 uapi:	$(uapi-hdrs-y)
 
+toolcheck:
+	@$(CONFIG_SHELL) '$(srctree)/$(src)/toolcheck'
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
+	.syntax unified
+	.thumb
+	.macro	badr, reg, sym
+	adr	\reg, \sym + 1
+	.endm
+
+test:
+	mov	r0, #0
+	badr	lr, test
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


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
