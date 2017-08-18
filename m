From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 18 Aug 2017 14:53:47 +0100
Subject: [PATCH] arm64: neon/efi: Make EFI fpsimd save/restore variables static
Message-ID: <1503064427-4352-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The percpu variables efi_fpsimd_state and efi_fpsimd_state_used,
used by the FPSIMD save/restore routines for EFI calls, are
unintentionally global.

There's no reason for anything outside fpsimd.c to touch these, so
this patch makes them static (as they should have been in the first
place).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 138fcfa..ceb0ff0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -320,8 +320,8 @@ void kernel_neon_end(void)
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-DEFINE_PER_CPU(struct fpsimd_state, efi_fpsimd_state);
-DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
+static DEFINE_PER_CPU(struct fpsimd_state, efi_fpsimd_state);
+static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 
 /*
  * EFI runtime services support functions
-- 
2.1.4
