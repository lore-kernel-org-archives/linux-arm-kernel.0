From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  9 Jan 2015 11:54:25 +0000
Subject: [PATCH v6 07/20] arm/arm64: KVM: dont rely on a valid GICH base
 address
In-Reply-To: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1420804478-17354-8-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To check whether the vGIC was already initialized, we currently check
the GICH base address for not being NULL. Since with GICv3 we may
get along without this address, lets use the irqchip_in_kernel()
function to detect an already initialized vGIC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
Changelog v5...v6:
 (add Acked-by)

Changelog v4...v5:
 (none)

Changelog v3...v4:
 (add Acked-by)

 virt/kvm/arm/vgic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 038d287..73cc18e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2089,7 +2089,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm->arch.vgic.vctrl_base) {
+	if (irqchip_in_kernel(kvm)) {
 		ret = -EEXIST;
 		goto out;
 	}
-- 
1.7.9.5
