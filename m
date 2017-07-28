From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Jul 2017 15:02:09 +0100
Subject: [PATCH] squash! arm64: neon: Allow EFI runtime services to use FPSIMD
 in irq context
In-Reply-To: <1501249824-18913-6-git-send-email-Dave.Martin@arm.com>
References: <1501249824-18913-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <1501250529-23303-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix misleading usage of efi_fpsimd_state_used.

Currently it's used to mean "efi_fpsimd_state not used", which is
confusing to say the least.  This patch inverts the sense of usage.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 601063c..138fcfa 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -347,11 +347,12 @@ void __efi_fpsimd_begin(void)
 
 	WARN_ON(preemptible());
 
-	if (may_use_simd()) {
+	if (may_use_simd())
 		kernel_neon_begin();
-		__this_cpu_write(efi_fpsimd_state_used, true);
-	} else
+	else {
 		fpsimd_save_state(this_cpu_ptr(&efi_fpsimd_state));
+		__this_cpu_write(efi_fpsimd_state_used, true);
+	}
 }
 
 /*
@@ -363,9 +364,9 @@ void __efi_fpsimd_end(void)
 		return;
 
 	if (__this_cpu_xchg(efi_fpsimd_state_used, false))
-		kernel_neon_end();
-	else
 		fpsimd_load_state(this_cpu_ptr(&efi_fpsimd_state));
+	else
+		kernel_neon_end();
 }
 
 #endif /* CONFIG_KERNEL_MODE_NEON */
-- 
2.1.4
