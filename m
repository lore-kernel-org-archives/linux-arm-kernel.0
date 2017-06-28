From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:54 +0100
Subject: [PATCH v2 35/52] KVM: arm/arm64: vgic: Move kvm_vgic_destroy call
 around
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-36-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way we call kvm_vgic_destroy is a bit bizarre. We call it
*after* having freed the vcpus, which sort of defeats the point
of cleaning up things before that point.

Let's move kvm_vgic_destroy towards the beginning of kvm_arch_destroy_vm,
which seems more sensible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 7846a578db1a..ebab6c29e3be 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -177,6 +177,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	int i;
 
+	kvm_vgic_destroy(kvm);
+
 	free_percpu(kvm->arch.last_vcpu_ran);
 	kvm->arch.last_vcpu_ran = NULL;
 
@@ -186,8 +188,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 			kvm->vcpus[i] = NULL;
 		}
 	}
-
-	kvm_vgic_destroy(kvm);
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
-- 
2.11.0
