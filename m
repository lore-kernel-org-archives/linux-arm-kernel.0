From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  9 May 2017 12:44:37 +0200
Subject: [PULL 08/37] KVM: arm/arm64: vgic: expose (un)lock_all_vcpus
In-Reply-To: <20170509104506.30929-1-cdall@linaro.org>
References: <20170509104506.30929-1-cdall@linaro.org>
Message-ID: <20170509104506.30929-9-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

We need to use those helpers in vgic-its.c so let's
expose them in the private vgic header.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 4 ++--
 virt/kvm/arm/vgic/vgic.h            | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index d181d2b..859bfa8 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -259,13 +259,13 @@ static void unlock_vcpus(struct kvm *kvm, int vcpu_lock_idx)
 	}
 }
 
-static void unlock_all_vcpus(struct kvm *kvm)
+void unlock_all_vcpus(struct kvm *kvm)
 {
 	unlock_vcpus(kvm, atomic_read(&kvm->online_vcpus) - 1);
 }
 
 /* Returns true if all vcpus were locked, false otherwise */
-static bool lock_all_vcpus(struct kvm *kvm)
+bool lock_all_vcpus(struct kvm *kvm)
 {
 	struct kvm_vcpu *tmp_vcpu;
 	int c;
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 44445da..a48f33b 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -179,4 +179,7 @@ int vgic_init(struct kvm *kvm);
 int vgic_debug_init(struct kvm *kvm);
 int vgic_debug_destroy(struct kvm *kvm);
 
+bool lock_all_vcpus(struct kvm *kvm);
+void unlock_all_vcpus(struct kvm *kvm);
+
 #endif
-- 
2.9.0
