From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:29:04 +0100
Subject: [PATCH 47/55] KVM: arm64: vgic-its: Fix vgic_its_check_device_id BE
 handling
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-48-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS tables are stored in LE format. If the host is reading
a L1 table entry to check its validity, it must convert it to
the CPU endianness.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index d6697c4..2ac5927 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -707,6 +707,8 @@ static bool vgic_its_check_device_id(struct kvm *kvm, struct vgic_its *its,
 			   &indirect_ptr, sizeof(indirect_ptr)))
 		return false;
 
+	indirect_ptr = le64_to_cpu(indirect_ptr);
+
 	/* check the valid bit of the first level entry */
 	if (!(indirect_ptr & BIT_ULL(63)))
 		return false;
-- 
2.8.1
