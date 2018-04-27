From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Apr 2018 15:51:02 +0100
Subject: [PATCH] arm64: vgic-v2: Fix proxying of cpuif access
Message-ID: <20180427145102.5645-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proxying the cpuif accesses at EL2 makes use of vcpu_data_guest_to_host
and co, which check the endianness, which call into vcpu_read_sys_reg...
which isn't mapped at EL2 (it was inlined before, and got moved OoL
with the VHE optimizations).

The result is of course a nice panic. Let's add some specialized
cruft to keep the broken platforms that require this hack alive.
I'd rather kill BE support, but hey, just in case...

Fixes: d47533dab9f5 ("KVM: arm64: Introduce framework for accessing deferred sysregs")
Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c | 33 ++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
index 86801b6055d6..b83a669b26ac 100644
--- a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
+++ b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
@@ -23,6 +23,30 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+static bool __hyp_text __is_be(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_mode_is_32bit(vcpu))
+		return !!(read_sysreg_el2(spsr) & COMPAT_PSR_E_BIT);
+
+	return !!(read_sysreg(SCTLR_EL1) & SCTLR_ELx_EE);
+}
+
+static u32 __hyp_text __host_to_guest_u32(struct kvm_vcpu *vcpu, u32 data)
+{
+	if (__is_be(vcpu))
+		return cpu_to_be32(data);
+
+	return cpu_to_le32(data);
+}
+
+static u32 __hyp_text __guest_to_host_u32(struct kvm_vcpu *vcpu, u32 data)
+{
+	if (__is_be(vcpu))
+		return be32_to_cpu(data);
+
+	return le32_to_cpu(data);
+}
+
 /*
  * __vgic_v2_perform_cpuif_access -- perform a GICV access on behalf of the
  *				     guest.
@@ -64,14 +88,11 @@ int __hyp_text __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	addr += fault_ipa - vgic->vgic_cpu_base;
 
 	if (kvm_vcpu_dabt_iswrite(vcpu)) {
-		u32 data = vcpu_data_guest_to_host(vcpu,
-						   vcpu_get_reg(vcpu, rd),
-						   sizeof(u32));
+		u32 data = __guest_to_host_u32(vcpu, vcpu_get_reg(vcpu, rd));
 		writel_relaxed(data, addr);
 	} else {
-		u32 data = readl_relaxed(addr);
-		vcpu_set_reg(vcpu, rd, vcpu_data_host_to_guest(vcpu, data,
-							       sizeof(u32)));
+		u32 data = __host_to_guest_u32(vcpu, readl_relaxed(addr));
+		vcpu_set_reg(vcpu, rd, data);
 	}
 
 	return 1;
-- 
2.14.2
