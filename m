From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Oct 2017 03:56:01 +0100
Subject: [PULL 6/8] KVM: arm/arm64: vgic-its: Fix
 vgic_its_restore_collection_table returned value
In-Reply-To: <20171030025603.23550-1-christoffer.dall@linaro.org>
References: <20171030025603.23550-1-christoffer.dall@linaro.org>
Message-ID: <20171030025603.23550-7-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

vgic_its_restore_cte returns +1 if the collection table entry
is valid and properly decoded. As a consequence, if the
collection table is fully filled with valid data that are
decoded without error, vgic_its_restore_collection_table()
returns +1. This is wrong.

Let's return 0 in that case.

Fixes: ea1ad53e1e31a3 (KVM: arm64: vgic-its: Collection table save/restore)
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 76685f4c6261..6a715a6ec64e 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -2264,6 +2264,10 @@ static int vgic_its_restore_collection_table(struct vgic_its *its)
 		gpa += cte_esz;
 		read += cte_esz;
 	}
+
+	if (ret > 0)
+		return 0;
+
 	return ret;
 }
 
-- 
2.14.2
