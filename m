From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:26 +0100
Subject: [PATCH 08/37] KVM: arm/arm64: Fix vgic init race
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

The vgic_init function can race with kvm_arch_vcpu_create() which does
not hold kvm_lock() and we therefore have no synchronization primitives
to ensure we're doing the right thing.

As the user is trying to initialize or run the VM while at the same time
creating more VCPUs, we just have to refuse to initialize the VGIC in
this case rather than silently failing with a broken VCPU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 2673efce65f3..b71417913741 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -271,6 +271,10 @@ int vgic_init(struct kvm *kvm)
 	if (vgic_initialized(kvm))
 		return 0;
 
+	/* Are we also in the middle of creating a VCPU? */
+	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
+		return -EBUSY;
+
 	/* freeze the number of spis */
 	if (!dist->nr_spis)
 		dist->nr_spis = VGIC_NR_IRQS_LEGACY - VGIC_NR_PRIVATE_IRQS;
-- 
2.18.0
