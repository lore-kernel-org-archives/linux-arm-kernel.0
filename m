From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Jul 2016 16:54:06 +0100
Subject: [PATCH 04/13] KVM: arm64: vgic-its: Fix handling of indirect tables
In-Reply-To: <1468857255-9543-1-git-send-email-marc.zyngier@arm.com>
References: <1468857255-9543-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1468857255-9543-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code will fail on valid indirect tables, and happily
use the ones that are pointing out of the guest RAM. Funny what a
small "!" can do for you...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index f427fa2..d6697c4 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -702,9 +702,9 @@ static bool vgic_its_check_device_id(struct kvm *kvm, struct vgic_its *its,
 		return false;
 
 	/* Each 1st level entry is represented by a 64-bit value. */
-	if (!kvm_read_guest(kvm,
-			    BASER_ADDRESS(r) + index * sizeof(indirect_ptr),
-			    &indirect_ptr, sizeof(indirect_ptr)))
+	if (kvm_read_guest(kvm,
+			   BASER_ADDRESS(r) + index * sizeof(indirect_ptr),
+			   &indirect_ptr, sizeof(indirect_ptr)))
 		return false;
 
 	/* check the valid bit of the first level entry */
-- 
2.1.4
