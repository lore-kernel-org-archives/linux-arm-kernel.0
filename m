From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 23 Oct 2017 11:48:57 +0800
Subject: [PATCH v2] ARM: Remove .pad section when CONFIG_EFI_STUB enabled
Message-ID: <20171023034857.19435-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are using the .pad section to ensure the zImage file size
aligned to 8 bytes.

But that is not needed when CONFIG_EFI_STUB enabled, as it would
followed by a 512 bytes aligned .data section.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Remove .pad section when CONFIG_EFI_STUB enabled as Russell King <linux@armlinux.org.uk> suggested.

 arch/arm/boot/compressed/vmlinux.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index b38dcef90756..394b2bf5d28a 100644
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
@@ -91,6 +87,10 @@ SECTIONS
     . = ALIGN(512);
   }
   __pecoff_data_rawsize = . - ADDR(.data);
+#else
+  /* ensure the zImage file size is always a multiple of 64 bits */
+  /* (without a dummy byte, ld just ignores the empty section) */
+  .pad			: { BYTE(0); . = ALIGN(8); }
 #endif
 
   _edata = .;
-- 
2.11.0
