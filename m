From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Mar 2017 11:58:17 +0100
Subject: [PATCH 8/9] KVM: arm/arm64: vgic: Don't check vgic_initialized in
 flush_hwstate
In-Reply-To: <20170320105818.20481-1-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
Message-ID: <20170320105818.20481-9-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now when we do an early init of the static parts of the VGIC data
structures, we can do things like checking if the AP lists are empty
directly without having to explicitly check if the vgic is initialized
and reduce a bit of work in our criticial path.

Note: list_empty is a single atomic read (uses READ_ONCE) and can
therefore check if a list is empty or not without the need to take the
spinlock protecting the list.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index f5b3c25..093873e 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -653,9 +653,6 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 /* Flush our emulation state into the GIC hardware before entering the guest. */
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(!vgic_initialized(vcpu->kvm)))
-		return;
-
 	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
 		return;
 
-- 
2.9.0
