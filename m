From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:35 +0100
Subject: [PULL 06/19] KVM: arm/arm64: vgic-its: Check result of allocation
 before use
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-4-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We miss a test against NULL after allocation.

Fixes: 6d03a68f8054 ("KVM: arm64: vgic-its: Turn device_id validation into generic ID validation")
Cc: <stable@vger.kernel.org> # 4.8
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index cb2d0a2dbe5a..8e633bd9cc1e 100644
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
