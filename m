From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue,  3 Jul 2018 23:26:15 +0200
Subject: [PATCH] KVM: arm/arm64: Fix vgic init race
Message-ID: <1530653175-11999-1-git-send-email-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vgic_init function can race with kvm_arch_vcpu_create() which does
not hold kvm_lock() and we therefore have no synchronization primitives
to ensure we're doing the right thing.

As the user is trying to initialize or run the VM while at the same time
creating more VCPUs, we just have to refuse to initialize the VGIC in
this case rather than silently failing with a broken VCPU.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 9406eaf..c0c0b88 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -286,6 +286,10 @@ int vgic_init(struct kvm *kvm)
        if (vgic_initialized(kvm))
                return 0;

+       /* Are we also in the middle of creating a VCPU? */
+       if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
+               return -EBUSY;
+
        /* freeze the number of spis */
        if (!dist->nr_spis)
                dist->nr_spis = VGIC_NR_IRQS_LEGACY - VGIC_NR_PRIVATE_IRQS;
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
