From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:44 +0200
Subject: [PULL 34/79] arm: KVM: Make unexpected register accesses inject an
 undef
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-35-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Reads from write-only system registers are generally confined to
EL1 and not propagated to EL2 (that's what the architecture
mantates). In order to be sure that we have a sane behaviour
even in the unlikely event that we have a broken system, we still
handle it in KVM. Same goes for write to RO registers.

In that case, let's inject an undef into the guest.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 18 ++++++++++++++++++
 arch/arm/kvm/coproc.h | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 3e5e419..519aac1 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -40,6 +40,24 @@
  * Co-processor emulation
  *****************************************************************************/
 
+static bool write_to_read_only(struct kvm_vcpu *vcpu,
+			       const struct coproc_params *params)
+{
+	WARN_ONCE(1, "CP15 write to read-only register\n");
+	print_cp_instr(params);
+	kvm_inject_undefined(vcpu);
+	return false;
+}
+
+static bool read_from_write_only(struct kvm_vcpu *vcpu,
+				 const struct coproc_params *params)
+{
+	WARN_ONCE(1, "CP15 read to write-only register\n");
+	print_cp_instr(params);
+	kvm_inject_undefined(vcpu);
+	return false;
+}
+
 /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
 static u32 cache_levels;
 
diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
index eef1759..3a41b7d 100644
--- a/arch/arm/kvm/coproc.h
+++ b/arch/arm/kvm/coproc.h
@@ -81,24 +81,6 @@ static inline bool read_zero(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
-				      const struct coproc_params *params)
-{
-	kvm_debug("CP15 write to read-only register at: %08lx\n",
-		  *vcpu_pc(vcpu));
-	print_cp_instr(params);
-	return false;
-}
-
-static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
-					const struct coproc_params *params)
-{
-	kvm_debug("CP15 read to write-only register at: %08lx\n",
-		  *vcpu_pc(vcpu));
-	print_cp_instr(params);
-	return false;
-}
-
 /* Reset functions */
 static inline void reset_unknown(struct kvm_vcpu *vcpu,
 				 const struct coproc_reg *r)
-- 
2.9.0
