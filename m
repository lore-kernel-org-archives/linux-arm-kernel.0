From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 18 Jul 2018 10:18:59 +0100
Subject: [PATCH v4 16/20] kvm: arm64: Add 52bit support for PAR to HPFAR
 conversoin
In-Reply-To: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531905547-25478-17-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for handling 52bit addresses in PAR to HPFAR
conversion. Instead of hardcoding the address limits, we
now use PHYS_MASK_SHIFT.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 7 +++++++
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d7b6226..c18c3b2 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -307,6 +307,13 @@
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~UL(0xf))
+/*
+ * We have
+ *	PAR	[PA_Shift - 1	: 12] = PA	[PA_Shift - 1 : 12]
+ *	HPFAR	[PA_Shift - 9	: 4]  = FIPA	[PA_Shift - 1 : 12]
+ */
+#define PAR_TO_HPFAR(par)		\
+	(((par) & GENMASK_ULL(PHYS_MASK_SHIFT - 1, 12)) >> 8)
 
 #define kvm_arm_exception_type	\
 	{0, "IRQ" }, 		\
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 355fb25..fb66320 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -260,7 +260,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 		return false; /* Translation failed, back to guest */
 
 	/* Convert PAR to HPFAR format */
-	*hpfar = ((tmp >> 12) & ((1UL << 36) - 1)) << 4;
+	*hpfar = PAR_TO_HPFAR(tmp);
 	return true;
 }
 
-- 
2.7.4
