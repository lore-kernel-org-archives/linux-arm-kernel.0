From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  7 Nov 2017 11:47:53 +0100
Subject: [PULL 20/26] KVM: arm/arm64: vgic-its: Remove kvm_its_unmap_device
In-Reply-To: <20171107104800.30021-1-christoffer.dall@linaro.org>
References: <20171107104800.30021-1-christoffer.dall@linaro.org>
Message-ID: <20171107104800.30021-21-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

Let's remove kvm_its_unmap_device and use kvm_its_free_device
as both functions are identical.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 9f5e34767628..75c18183eee3 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -897,7 +897,7 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 }
 
 /* Requires the its_lock to be held. */
-static void vgic_its_unmap_device(struct kvm *kvm, struct its_device *device)
+static void vgic_its_free_device(struct kvm *kvm, struct its_device *device)
 {
 	struct its_ite *ite, *temp;
 
@@ -960,7 +960,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * by removing the mapping and re-establishing it.
 	 */
 	if (device)
-		vgic_its_unmap_device(kvm, device);
+		vgic_its_free_device(kvm, device);
 
 	/*
 	 * The spec does not say whether unmapping a not-mapped device
@@ -1615,16 +1615,6 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 	return vgic_its_set_abi(its, NR_ITS_ABIS - 1);
 }
 
-static void vgic_its_free_device(struct kvm *kvm, struct its_device *dev)
-{
-	struct its_ite *ite, *tmp;
-
-	list_for_each_entry_safe(ite, tmp, &dev->itt_head, ite_list)
-		its_free_ite(kvm, ite);
-	list_del(&dev->dev_list);
-	kfree(dev);
-}
-
 static void vgic_its_destroy(struct kvm_device *kvm_dev)
 {
 	struct kvm *kvm = kvm_dev->kvm;
-- 
2.14.2
