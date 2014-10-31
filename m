From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 31 Oct 2014 17:26:43 +0000
Subject: [PATCH v3 08/19] arm/arm64: KVM: dont rely on a valid GICH base
 address
In-Reply-To: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1414776414-13426-9-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To check whether the vGIC was already initialized, we currently check
the GICH base address for not being NULL. Since with GICv3 we may
get along without this address, lets use the irqchip_in_kernel()
function to detect an already initialized vGIC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 98fffb4..0407c6c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2049,7 +2049,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm->arch.vgic.vctrl_base) {
+	if (irqchip_in_kernel(kvm)) {
 		ret = -EEXIST;
 		goto out;
 	}
-- 
1.7.9.5
