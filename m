From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 23 Nov 2016 18:31:56 +0530
Subject: [PATCH v9 09/11] arm: coproc: Drop const from coproc reg access
 function
In-Reply-To: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1479906118-15832-10-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

In order to read or write to coproc regiter, the
access function is should allow the coproc_param to be non
constant.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 arch/arm/kvm/coproc.c | 20 ++++++++++----------
 arch/arm/kvm/coproc.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 3e5e419..5753926 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -113,7 +113,7 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
 
 /* TRM entries A7:4.3.31 A15:4.3.28 - RO WI */
 static bool access_actlr(struct kvm_vcpu *vcpu,
-			 const struct coproc_params *p,
+			 struct coproc_params *p,
 			 const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -125,7 +125,7 @@ static bool access_actlr(struct kvm_vcpu *vcpu,
 
 /* TRM entries A7:4.3.56, A15:4.3.60 - R/O. */
 static bool access_cbar(struct kvm_vcpu *vcpu,
-			const struct coproc_params *p,
+			struct coproc_params *p,
 			const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -135,7 +135,7 @@ static bool access_cbar(struct kvm_vcpu *vcpu,
 
 /* TRM entries A7:4.3.49, A15:4.3.48 - R/O WI */
 static bool access_l2ctlr(struct kvm_vcpu *vcpu,
-			  const struct coproc_params *p,
+			  struct coproc_params *p,
 			  const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -181,7 +181,7 @@ static void reset_actlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
  * R/O WI (even if NSACR.NS_L2ERR, a write of 1 is ignored).
  */
 static bool access_l2ectlr(struct kvm_vcpu *vcpu,
-			   const struct coproc_params *p,
+			   struct coproc_params *p,
 			   const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -195,7 +195,7 @@ static bool access_l2ectlr(struct kvm_vcpu *vcpu,
  * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
  */
 static bool access_dcsw(struct kvm_vcpu *vcpu,
-			const struct coproc_params *p,
+			struct coproc_params *p,
 			const struct coproc_reg *r)
 {
 	if (!p->is_write)
@@ -213,7 +213,7 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
  * Used by the cpu-specific code.
  */
 bool access_vm_reg(struct kvm_vcpu *vcpu,
-		   const struct coproc_params *p,
+		   struct coproc_params *p,
 		   const struct coproc_reg *r)
 {
 	bool was_enabled = vcpu_has_cache_enabled(vcpu);
@@ -229,7 +229,7 @@ bool access_vm_reg(struct kvm_vcpu *vcpu,
 }
 
 static bool access_gic_sgi(struct kvm_vcpu *vcpu,
-			   const struct coproc_params *p,
+			   struct coproc_params *p,
 			   const struct coproc_reg *r)
 {
 	u64 reg;
@@ -246,7 +246,7 @@ static bool access_gic_sgi(struct kvm_vcpu *vcpu,
 }
 
 static bool access_gic_sre(struct kvm_vcpu *vcpu,
-			   const struct coproc_params *p,
+			   struct coproc_params *p,
 			   const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -267,7 +267,7 @@ static bool access_gic_sre(struct kvm_vcpu *vcpu,
  * all PM registers, which doesn't crash the guest kernel at least.
  */
 static bool pm_fake(struct kvm_vcpu *vcpu,
-		    const struct coproc_params *p,
+		    struct coproc_params *p,
 		    const struct coproc_reg *r)
 {
 	if (p->is_write)
@@ -480,7 +480,7 @@ static const struct coproc_reg *find_reg(const struct coproc_params *params,
 }
 
 static int emulate_cp15(struct kvm_vcpu *vcpu,
-			const struct coproc_params *params)
+			struct coproc_params *params)
 {
 	size_t num;
 	const struct coproc_reg *table, *r;
diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
index eef1759..bbeff2a 100644
--- a/arch/arm/kvm/coproc.h
+++ b/arch/arm/kvm/coproc.h
@@ -41,7 +41,7 @@ struct coproc_reg {
 
 	/* Trapped access from guest, if non-NULL. */
 	bool (*access)(struct kvm_vcpu *,
-		       const struct coproc_params *,
+		       struct coproc_params *,
 		       const struct coproc_reg *);
 
 	/* Initialization for vcpu. */
@@ -154,7 +154,7 @@ static inline int cmp_reg(const struct coproc_reg *i1,
 #define is32		.is_64bit = false
 
 bool access_vm_reg(struct kvm_vcpu *vcpu,
-		   const struct coproc_params *p,
+		   struct coproc_params *p,
 		   const struct coproc_reg *r);
 
 #endif /* __ARM_KVM_COPROC_LOCAL_H__ */
-- 
1.9.1
