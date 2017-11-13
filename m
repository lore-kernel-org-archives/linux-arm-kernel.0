From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:51 +0100
Subject: [PULL 26/27] KVM: arm/arm64: Fix GICv4 ITS initialization issues
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-27-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should only try to initialize GICv4 data structures on a GICv4
capable system.  Move the vgic_supports_direct_msis() check inito
vgic_v4_init() so that any KVM VGIC initialization path does not fail
on non-GICv4 systems.

Also be slightly more strict in the checking of the return value in
vgic_its_create, and only error out on negative return values from the
vgic_v4_init() function.  This is important because the kvm device code
only treats negative values as errors and only cleans up in this case.
Errornously treating a positive return value as an error from the
vgic_v4_init() function can lead to NULL pointer dereferences, as has
recently been observed.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-init.c | 8 +++-----
 virt/kvm/arm/vgic/vgic-its.c  | 2 +-
 virt/kvm/arm/vgic/vgic-v4.c   | 3 +++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 40be908da238..62310122ee78 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -285,11 +285,9 @@ int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
-	if (vgic_supports_direct_msis(kvm)) {
-		ret = vgic_v4_init(kvm);
-		if (ret)
-			goto out;
-	}
+	ret = vgic_v4_init(kvm);
+	if (ret)
+		goto out;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_vgic_vcpu_enable(vcpu);
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index b8c1b724ba3e..c93ecd4a903b 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1673,7 +1673,7 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 
 	if (vgic_initialized(dev->kvm)) {
 		int ret = vgic_v4_init(dev->kvm);
-		if (ret) {
+		if (ret < 0) {
 			kfree(its);
 			return ret;
 		}
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 915d09dc2638..53c324aa44ef 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -118,6 +118,9 @@ int vgic_v4_init(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	int i, nr_vcpus, ret;
 
+	if (!vgic_supports_direct_msis(kvm))
+		return 0; /* Nothing to see here... move along. */
+
 	if (dist->its_vm.vpes)
 		return 0;
 
-- 
2.14.2
