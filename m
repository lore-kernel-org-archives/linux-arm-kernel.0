From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Apr 2016 14:46:31 +0100
Subject: [PATCHv3 2/5] arm64/efi: enable runtime call flag checking
In-Reply-To: <1461591994-14918-1-git-send-email-mark.rutland@arm.com>
References: <1461591994-14918-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1461591994-14918-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define ARCH_EFI_IRQ_FLAGS_MASK for arm64, which will enable the generic
runtime wrapper code to detect when firmware erroneously modifies flags
over a runtime services function call.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-efi at vger.kernel.org
---
 arch/arm64/include/asm/efi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index f4f71224..b44603e 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -4,6 +4,7 @@
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/neon.h>
+#include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
 #ifdef CONFIG_EFI
@@ -33,6 +34,8 @@ int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 	kernel_neon_end();						\
 })
 
+#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+
 /* arch specific definitions used by the stub code */
 
 /*
-- 
1.9.1
