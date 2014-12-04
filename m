From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  4 Dec 2014 10:48:03 +0100
Subject: [PATCH v2 3/4] KVM: arm/arm64: check vgic_initialized before VCPU
 creation
In-Reply-To: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
References: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1417686484-20828-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that user-space can initiate VGIC initialization independently
on the first vcpu run, let's check the user-space does not attempt
to create a VCPU after this initialization.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/kvm/arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b5401f7..edcc66b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -216,6 +216,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err;
 	struct kvm_vcpu *vcpu;
 
+	if (unlikely(vgic_initialized(kvm))) {
+		err = -EBUSY;
+		goto out;
+	}
+
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu) {
 		err = -ENOMEM;
-- 
1.9.1
