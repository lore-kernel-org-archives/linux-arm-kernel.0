From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Thu, 23 Nov 2017 12:50:21 +0100
Subject: [PATCH v2] arm: detect buggy binutils when in thumb2 mode
In-Reply-To: <20171123114802.24942-1-Jason@zx2c4.com>
References: <20171123114802.24942-1-Jason@zx2c4.com>
Message-ID: <20171123115021.25213-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On older versions of binutils, \sym points to an aligned address. On
newer versions of binutils, \sym sometimes points to the unaligned thumb
address in certain circumstances. In order to homogenize this behavior,
rather than adding 1, we could simply OR in 1, so that already unaligned
instructions don't change. While that works, the downside is that we have
to add an `orr` instruction to a fast path. The assembler can't do this at
assemble time via "|1" because "invalid operands (.text and *ABS* sections)
for `|'". A better solution would be to have consistent binutils behavior,
but that ship has sailed.

So, this commit adds a detection mechanism, which began as a small thing
from Russell King that I then rewrote to use pure bash instead of
shelling out, so that it doesn't slow down the build process. The detection
mechanism _could_ be used to modify the assembly we generate, but for now
it's just being used to catch buggy binutils and abort the build process in
that case.

The rest of this commit message contains all of the relevant information
about the boot bug when compiled in thumb2 mode.

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
Cc: Russell King <linux@armlinux.org.uk>
Cc: nickc at redhat.com
Cc: stable at vger.kernel.org
---
Had the file mode wrong on the submission from a second ago, sorry about
that.

 arch/arm/Makefile        |  7 +++++--
 arch/arm/tools/Makefile  |  5 ++++-
 arch/arm/tools/toolcheck | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)
 create mode 100755 arch/arm/tools/toolcheck

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 80351e505fd5..bd4e248a7f8f 100644
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
index ddb89a7db36f..0a283756f1c5 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -23,12 +23,15 @@ uapi-hdrs-y += $(uapi)/unistd-eabi.h
 
 targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
 
-PHONY += kapi uapi
+PHONY += kapi uapi toolcheck
 
 kapi:	$(kapi-hdrs-y) $(gen-y)
 
 uapi:	$(uapi-hdrs-y)
 
+toolcheck:
+	@'$(srctree)/$(src)/toolcheck'
+
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
           $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
diff --git a/arch/arm/tools/toolcheck b/arch/arm/tools/toolcheck
new file mode 100755
index 000000000000..04fc44b750d2
--- /dev/null
+++ b/arch/arm/tools/toolcheck
@@ -0,0 +1,44 @@
+#!/bin/bash
+#
+# Copyright 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+#
+
+set -e
+
+cleanup() {
+	[[ ! -d $temp ]] || rm -rf "$temp"
+	exit
+}
+trap cleanup INT TERM EXIT
+temp="$(mktemp -d)"
+
+check_thumb2_address() {
+	local disassembly
+
+	$CC $KBUILD_AFLAGS -o "$temp/a.out" -c -xassembler - <<-_EOF
+		.syntax unified
+		.thumb
+		.macro	badr, reg, sym
+		adr	\reg, \sym + 1
+		.endm
+
+		.type test, %function
+		.thumb_func
+		test:
+		mov	r0, #0
+		badr	lr, test
+	_EOF
+	disassembly="$($OBJDUMP -d "$temp/a.out")"
+
+	[[ $disassembly =~ 4:[[:space:]]*f2af\ 0e07 ]] && return 0
+
+	echo "Error: your assembler version produces buggy kernels:" >&2
+	read < <($AS --version) && echo "$REPLY" >&2
+	[[ $disassembly =~ 4:[[:space:]].*$ ]] && echo "${BASH_REMATCH[0]}" >&2 || echo "$disassembly" >&2
+	return 1
+}
+
+config="$(< .config)"
+[[ $config == *CONFIG_THUMB2_KERNEL=y* ]] && check_thumb2_address
+
+exit 0
-- 
2.15.0
