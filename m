From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jan 2014 14:56:39 +0000
Subject: [PATCH v2 07/10] ARM: KVM: fix ordering of 64bit coprocessor accesses
In-Reply-To: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
References: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1390402602-22777-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 240e99cbd00a (ARM: KVM: Fix 64-bit coprocessor handling)
added an ordering dependency for the 64bit registers.

The order described is: CRn, CRm, Op1, Op2, 64bit-first.

Unfortunately, the implementation is: CRn, 64bit-first, CRm...

Move the 64bit test to be last in order to match the documentation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
index c5ad7ff..1a44bbe 100644
--- a/arch/arm/kvm/coproc.h
+++ b/arch/arm/kvm/coproc.h
@@ -135,13 +135,13 @@ static inline int cmp_reg(const struct coproc_reg *i1,
 		return -1;
 	if (i1->CRn != i2->CRn)
 		return i1->CRn - i2->CRn;
-	if (i1->is_64 != i2->is_64)
-		return i2->is_64 - i1->is_64;
 	if (i1->CRm != i2->CRm)
 		return i1->CRm - i2->CRm;
 	if (i1->Op1 != i2->Op1)
 		return i1->Op1 - i2->Op1;
-	return i1->Op2 - i2->Op2;
+	if (i1->Op2 != i2->Op2)
+		return i1->Op2 - i2->Op2;
+	return i2->is_64 - i1->is_64;
 }
 
 
@@ -153,4 +153,8 @@ static inline int cmp_reg(const struct coproc_reg *i1,
 #define is64		.is_64 = true
 #define is32		.is_64 = false
 
+bool access_sctlr(struct kvm_vcpu *vcpu,
+		  const struct coproc_params *p,
+		  const struct coproc_reg *r);
+
 #endif /* __ARM_KVM_COPROC_LOCAL_H__ */
-- 
1.8.3.4
