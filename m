From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:50 +0100
Subject: [PATCH 15/26] kvm: arm64: Add 52bit support for PAR to HPFAR
 conversoin
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for handling 52bit addresses in PAR to HPFAR
conversion. Instead of hardcoding the address limits, we
now use PHYS_MASK_SHIFT.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 7 +++++++
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index e4240568cc18..f1330284720d 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -311,6 +311,13 @@
 
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
index 9d5ce1a3039a..7cc175c88a37 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -263,7 +263,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 		return false; /* Translation failed, back to guest */
 
 	/* Convert PAR to HPFAR format */
-	*hpfar = ((tmp >> 12) & ((1UL << 36) - 1)) << 4;
+	*hpfar = PAR_TO_HPFAR(tmp);
 	return true;
 }
 
-- 
2.19.1
