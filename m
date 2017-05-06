From: eric.auger@redhat.com (Eric Auger)
Date: Sat,  6 May 2017 17:24:25 +0200
Subject: [PATCH v7 06/24] KVM: arm/arm64: vgic: expose (un)lock_all_vcpus
In-Reply-To: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1494084283-12723-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use those helpers in vgic-its.c so let's
expose them in the private vgic header.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <cdall@linaro.org>

---
v5 -> v6:
- Add Christoffer's A-b

v4 -> v5:
- Add Marc's A-b
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
index 6cf557e..b87f1c6 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -184,4 +184,7 @@ int vgic_init(struct kvm *kvm);
 int vgic_debug_init(struct kvm *kvm);
 int vgic_debug_destroy(struct kvm *kvm);
 
+bool lock_all_vcpus(struct kvm *kvm);
+void unlock_all_vcpus(struct kvm *kvm);
+
 #endif
-- 
2.5.5
