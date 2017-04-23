From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:40 +0200
Subject: [PULL 30/79] arm64: KVM: Make unexpected reads from WO registers
 inject an undef
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-31-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Reads from write-only system registers are generally confined to
EL1 and not propagated to EL2 (that's what the architecture
mantates). In order to be sure that we have a sane behaviour
even in the unlikely event that we have a broken system, we still
handle it in KVM.

In that case, let's inject an undef into the guest.

Let's also remove write_to_read_only which isn't used anywhere.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c |  9 +++++++++
 arch/arm64/kvm/sys_regs.h | 18 ------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d343c0f..20f90c0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -55,6 +55,15 @@
  * 64bit interface.
  */
 
+static bool read_from_write_only(struct kvm_vcpu *vcpu,
+				 const struct sys_reg_params *params)
+{
+	WARN_ONCE(1, "Unexpected sys_reg read to write-only register\n");
+	print_sys_reg_instr(params);
+	kvm_inject_undefined(vcpu);
+	return false;
+}
+
 /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
 static u32 cache_levels;
 
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 9c6ffd0..638f724 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -83,24 +83,6 @@ static inline bool read_zero(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
-				      const struct sys_reg_params *params)
-{
-	kvm_debug("sys_reg write to read-only register at: %lx\n",
-		  *vcpu_pc(vcpu));
-	print_sys_reg_instr(params);
-	return false;
-}
-
-static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
-					const struct sys_reg_params *params)
-{
-	kvm_debug("sys_reg read to write-only register at: %lx\n",
-		  *vcpu_pc(vcpu));
-	print_sys_reg_instr(params);
-	return false;
-}
-
 /* Reset functions */
 static inline void reset_unknown(struct kvm_vcpu *vcpu,
 				 const struct sys_reg_desc *r)
-- 
2.9.0
