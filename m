From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:23 +0000
Subject: [PATCH 29/29] ARM: KVM: Fix length of mmio access
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-30-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the maximum MMIO access to be 4 bytes,
compare it to sizeof(unsigned long), which will do the
right thing on both 32 and 64bit systems.

Same thing for sign extention.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 9bd471a..bd1bbcd 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -39,10 +39,10 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	if (!run->mmio.is_write) {
 		dest = vcpu_reg(vcpu, vcpu->arch.mmio_decode.rt);
-		memset(dest, 0, sizeof(int));
+		*dest = 0;
 
 		len = run->mmio.len;
-		if (len > 4)
+		if (len > sizeof(unsigned long))
 			return -EINVAL;
 
 		memcpy(dest, run->mmio.data, len);
@@ -50,7 +50,8 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
 				*((u64 *)run->mmio.data));
 
-		if (vcpu->arch.mmio_decode.sign_extend && len < 4) {
+		if (vcpu->arch.mmio_decode.sign_extend &&
+		    len < sizeof(unsigned long)) {
 			mask = 1U << ((len * 8) - 1);
 			*dest = (*dest ^ mask) - mask;
 		}
-- 
1.7.12.4
