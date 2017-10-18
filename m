From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 18 Oct 2017 13:01:07 +0800
Subject: [PATCH] ARM: Fix zImage file size not aligned with CONFIG_EFI_STUB
 enabled
Message-ID: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zImage file size should be aligned.

Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate PE/COFF sections")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm/boot/compressed/vmlinux.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index b38dcef90756..1636fa259577 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -70,10 +70,6 @@ SECTIONS
   .got			: { *(.got) }
   _got_end = .;
 
-  /* ensure the zImage file size is always a multiple of 64 bits */
-  /* (without a dummy byte, ld just ignores the empty section) */
-  .pad			: { BYTE(0); . = ALIGN(8); }
-
 #ifdef CONFIG_EFI_STUB
   .data : ALIGN(4096) {
     __pecoff_data_start = .;
@@ -93,6 +89,10 @@ SECTIONS
   __pecoff_data_rawsize = . - ADDR(.data);
 #endif
 
+  /* ensure the zImage file size is always a multiple of 64 bits */
+  /* (without a dummy byte, ld just ignores the empty section) */
+  .pad			: { BYTE(0); . = ALIGN(8); }
+
   _edata = .;
 
   _magic_sig = ZIMAGE_MAGIC(0x016f2818);
-- 
2.11.0
