From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Mar 2016 10:58:09 +0100
Subject: [PATCH] arm64/kernel: fix incorrect EL0 check in inv_entry macro
Message-ID: <1458295089-24447-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of macro inv_entry refers to its 'el' argument without
the required leading backslash, which results in an undefined symbol
'el' to be passed into the kernel_entry macro rather than the index of
the exception level as intended.

This undefined symbol strangely enough does not result in build failures,
although it is visible in vmlinux:

     $ nm -n vmlinux |head
                      U el
     0000000000000000 A _kernel_flags_le_hi32
     0000000000000000 A _kernel_offset_le_hi32
     0000000000000000 A _kernel_size_le_hi32
     000000000000000a A _kernel_flags_le_lo32
     .....

However, it does result in incorrect code being generated for invalid
exceptions taken from EL0, since the argument check in kernel_entry
assumes EL1 if its argument does not equal '0'.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1f7f5a2b61bf..12e8d2bcb3f9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -277,7 +277,7 @@ END(vectors)
  * Invalid mode handlers
  */
 	.macro	inv_entry, el, reason, regsize = 64
-	kernel_entry el, \regsize
+	kernel_entry \el, \regsize
 	mov	x0, sp
 	mov	x1, #\reason
 	mrs	x2, esr_el1
-- 
2.5.0
