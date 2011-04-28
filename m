From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:16 -0400
Subject: [PATCH 1/9] ARM: zImage: make sure the stack is 64-bit aligned
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

With ARMv5+ and EABI, the compiler expects a 64-bit aligned stack so
instructions like STRD and LDRD can be used.  Without this, mysterious
boot failures were seen semi randomly with the LZMA decompressor.

While at it, let's align .bss as well.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
CC: stable at kernel.org
---
 arch/arm/boot/compressed/Makefile       |    2 +-
 arch/arm/boot/compressed/vmlinux.lds.in |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 8ebbb51..0c6852d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -74,7 +74,7 @@ ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
 ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
 else
 ZTEXTADDR	:= 0
-ZBSSADDR	:= ALIGN(4)
+ZBSSADDR	:= ALIGN(8)
 endif
 
 SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 5309909..ea80abe 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -54,6 +54,7 @@ SECTIONS
   .bss			: { *(.bss) }
   _end = .;
 
+  . = ALIGN(8);		/* the stack must be 64-bit aligned */
   .stack		: { *(.stack) }
 
   .stab 0		: { *(.stab) }
-- 
1.7.4
