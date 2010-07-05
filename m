From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Jul 2010 16:15:28 +0200
Subject: [PATCH 10/11] ARM: Remove unused PARAMS_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <20100705141344.GA25407@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
Message-ID: <1278339329-23739-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.y.miao@gmail.com>

The only reference in arch/arm/boot/compressed to PARAMS_PHYS is
params() in head.S, which can be directly converted to the exact
address as specified by arch/arm/mach-rpc/Makefile.boot.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/Makefile |    7 +------
 arch/arm/boot/compressed/head.S   |    2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5419448..2a80c9d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -79,16 +79,11 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
-# Supply ZRELADDR and PARAMS_PHYS to the decompressor via linker symbols.  We
-# only define params_phys if the machine class defined the corresponding
-# makefile variable.
+# Supply ZRELADDR to the decompressor via a linker symbol.
 LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-ifneq ($(PARAMS_PHYS),)
-LDFLAGS_vmlinux += --defsym params_phys=$(PARAMS_PHYS)
-endif
 # ?
 LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index f61c76e..d27faa1 100644
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
1.7.1
