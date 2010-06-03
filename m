From: eric.miao@canonical.com (Eric Miao)
Date: Thu,  3 Jun 2010 15:36:49 +0800
Subject: [PATCH 1/5] [ARM] Remove unused PARAMS_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1275550613-9553-2-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.y.miao@gmail.com>

The only reference in arch/arm/boot/compressed to PARAMS_PHYS is
params() in head.S, which can be directly converted to the exact
address as specified by arch/arm/mach-rpc/Makefile.boot.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/boot/compressed/Makefile |    7 ++-----
 arch/arm/boot/compressed/head.S   |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 53faa90..b58a589 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -79,8 +79,8 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
-# Supply ZRELADDR, INITRD_PHYS and PARAMS_PHYS to the decompressor via
-# linker symbols.  We only define initrd_phys and params_phys if the
+# Supply ZRELADDR, INITRD_PHYS to the decompressor via
+# linker symbols.  We only define initrd_phys if the
 # machine class defined the corresponding makefile variable.
 LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
@@ -89,9 +89,6 @@ endif
 ifneq ($(INITRD_PHYS),)
 LDFLAGS_vmlinux += --defsym initrd_phys=$(INITRD_PHYS)
 endif
-ifneq ($(PARAMS_PHYS),)
-LDFLAGS_vmlinux += --defsym params_phys=$(PARAMS_PHYS)
-endif
 # ?
 LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c5191b1..0765990 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -321,7 +321,7 @@ LC1:		.word	reloc_end - reloc_start
 
 #ifdef CONFIG_ARCH_RPC
 		.globl	params
-params:		ldr	r0, =params_phys
+params:		ldr	r0, =0x10000100		@ params_phys for RPC
 		mov	pc, lr
 		.ltorg
 		.align
-- 
1.7.0.4
