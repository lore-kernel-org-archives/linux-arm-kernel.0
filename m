From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 17:31:32 +0100
Subject: [PATCH] arm64: efi: add missing frame pointer assignment
Message-ID: <1457022692-14043-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prologue of the EFI entry point pushes x29 and x30 onto the stack but
fails to create the stack frame correctly by omitting the assignment of x29
to the new value of the stack pointer. So fix that.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 936022f0655e..e88c064b845c 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -35,6 +35,7 @@ ENTRY(entry)
 	 * for image_addr variable passed to efi_entry().
 	 */
 	stp	x29, x30, [sp, #-32]!
+	mov	x29, sp
 
 	/*
 	 * Call efi_entry to do the real work.
-- 
2.5.0
