From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Dec 2014 12:41:57 +0100
Subject: [GIT PULL 10/12] arm/arm64: KVM: Don't allow creating VCPUs after
 vgic_initialized
In-Reply-To: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
References: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418643719-25966-11-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the vgic initializes its internal state it does so based on the
number of VCPUs available at the time.  If we allow KVM to create more
VCPUs after the VGIC has been initialized, we are likely to error out in
unfortunate ways later, perform buffer overflows etc.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c5a05f2..66f37c4 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -213,6 +213,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err;
 	struct kvm_vcpu *vcpu;
 
+	if (irqchip_in_kernel(kvm) && vgic_initialized(kvm)) {
+		err = -EBUSY;
+		goto out;
+	}
+
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu) {
 		err = -ENOMEM;
-- 
2.1.2.330.g565301e.dirty
