From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:23:30 +0100
Subject: [PATCH 2/7] ARM: decompressor: use better output sections
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePGU-0004zd-9e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place read-only data in a .rodata output section, and the compressed
piggy data in .piggydata.  Place the .got.plt section before the .got
section as is standard ELF practise.

This allows the piggydata to be more easily extracted from the
compressed vmlinux file for verification purposes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/compressed/vmlinux.lds.in |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index ea80abe..4e72883 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -33,20 +33,24 @@ SECTIONS
     *(.text.*)
     *(.fixup)
     *(.gnu.warning)
+    *(.glue_7t)
+    *(.glue_7)
+  }
+  .rodata : {
     *(.rodata)
     *(.rodata.*)
-    *(.glue_7)
-    *(.glue_7t)
+  }
+  .piggydata : {
     *(.piggydata)
-    . = ALIGN(4);
   }
 
+  . = ALIGN(4);
   _etext = .;
 
+  .got.plt		: { *(.got.plt) }
   _got_start = .;
   .got			: { *(.got) }
   _got_end = .;
-  .got.plt		: { *(.got.plt) }
   _edata = .;
 
   . = BSS_START;
-- 
1.7.4.4
