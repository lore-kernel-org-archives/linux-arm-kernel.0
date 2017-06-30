From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:22 +0100
Subject: [PATCH 06/58] KVM: arm/arm64: Use uaccess functions for GICv3
 {sc}active
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

We recently rewrote the sactive and cactive handlers to take the kvm
lock for guest accesses to these registers.  However, when accessed from
userspace this lock is already held.  Unfortunately we forgot to change
the private accessors for GICv3, because these are redistributor
registers and not distributor registers.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 23c0d56436a7..e25567a93dd5 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -528,12 +528,14 @@ static const struct vgic_register_region vgic_v3_sgibase_registers[] = {
 		vgic_mmio_read_pending, vgic_mmio_write_cpending,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
 		VGIC_ACCESS_32bit),
-	REGISTER_DESC_WITH_LENGTH(GICR_ISACTIVER0,
-		vgic_mmio_read_active, vgic_mmio_write_sactive, 4,
-		VGIC_ACCESS_32bit),
-	REGISTER_DESC_WITH_LENGTH(GICR_ICACTIVER0,
-		vgic_mmio_read_active, vgic_mmio_write_cactive, 4,
-		VGIC_ACCESS_32bit),
+	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ISACTIVER0,
+		vgic_mmio_read_active, vgic_mmio_write_sactive,
+		NULL, vgic_mmio_uaccess_write_sactive,
+		4, VGIC_ACCESS_32bit),
+	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_ICACTIVER0,
+		vgic_mmio_read_active, vgic_mmio_write_cactive,
+		NULL, vgic_mmio_uaccess_write_cactive,
+		4, VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH(GICR_IPRIORITYR0,
 		vgic_mmio_read_priority, vgic_mmio_write_priority, 32,
 		VGIC_ACCESS_32bit | VGIC_ACCESS_8bit),
-- 
2.11.0
