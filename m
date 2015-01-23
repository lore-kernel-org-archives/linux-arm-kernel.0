From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:50 +0100
Subject: [GIT PULL 21/36] arm/arm64: KVM: dont rely on a valid GICH base
 address
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-22-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

To check whether the vGIC was already initialized, we currently check
the GICH base address for not being NULL. Since with GICv3 we may
get along without this address, lets use the irqchip_in_kernel()
function to detect an already initialized vGIC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 69f6e7a..1c3b75e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2094,7 +2094,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm->arch.vgic.vctrl_base) {
+	if (irqchip_in_kernel(kvm)) {
 		ret = -EEXIST;
 		goto out;
 	}
-- 
2.1.2.330.g565301e.dirty
