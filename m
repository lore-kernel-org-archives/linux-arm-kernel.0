From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Nov 2017 17:58:18 +0000
Subject: [PATCH 4/7] KVM: arm/arm64: vgic-its: Check result of allocation
 before use
In-Reply-To: <20171116175821.26544-1-marc.zyngier@arm.com>
References: <20171116175821.26544-1-marc.zyngier@arm.com>
Message-ID: <20171116175821.26544-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We miss a test against NULL after allocation.

Fixes: 6d03a68f8054 ("KVM: arm64: vgic-its: Turn device_id validation into generic ID validation")
Cc: stable at vger.kernel.org # 4.8
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 370086006838..30f7c7e6d2f4 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -821,6 +821,8 @@ static int vgic_its_alloc_collection(struct vgic_its *its,
 		return E_ITS_MAPC_COLLECTION_OOR;
 
 	collection = kzalloc(sizeof(*collection), GFP_KERNEL);
+	if (!collection)
+		return -ENOMEM;
 
 	collection->collection_id = coll_id;
 	collection->target_addr = COLLECTION_NOT_MAPPED;
-- 
2.14.2
