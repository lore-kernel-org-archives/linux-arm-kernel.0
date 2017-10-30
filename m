From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Oct 2017 03:56:02 +0100
Subject: [PULL 7/8] KVM: arm/arm64: vgic-its: Check CBASER/BASER validity
 before enabling the ITS
In-Reply-To: <20171030025603.23550-1-christoffer.dall@linaro.org>
References: <20171030025603.23550-1-christoffer.dall@linaro.org>
Message-ID: <20171030025603.23550-8-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

The spec says it is UNPREDICTABLE to enable the ITS
if any of the following conditions are true:

- GITS_CBASER.Valid == 0.
- GITS_BASER<n>.Valid == 0, for any GITS_BASER<n> register
  where the Type field indicates Device.
- GITS_BASER<n>.Valid == 0, for any GITS_BASER<n> register
  where the Type field indicates Interrupt Collection and
  GITS_TYPER.HCC == 0.

In that case, let's keep the ITS disabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 6a715a6ec64e..e69ef7d27fde 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1466,6 +1466,16 @@ static void vgic_mmio_write_its_ctlr(struct kvm *kvm, struct vgic_its *its,
 {
 	mutex_lock(&its->cmd_lock);
 
+	/*
+	 * It is UNPREDICTABLE to enable the ITS if any of the CBASER or
+	 * device/collection BASER are invalid
+	 */
+	if (!its->enabled && (val & GITS_CTLR_ENABLE) &&
+		(!(its->baser_device_table & GITS_BASER_VALID) ||
+		 !(its->baser_coll_table & GITS_BASER_VALID) ||
+		 !(its->cbaser & GITS_CBASER_VALID)))
+		goto out;
+
 	its->enabled = !!(val & GITS_CTLR_ENABLE);
 
 	/*
@@ -1474,6 +1484,7 @@ static void vgic_mmio_write_its_ctlr(struct kvm *kvm, struct vgic_its *its,
 	 */
 	vgic_its_process_commands(kvm, its);
 
+out:
 	mutex_unlock(&its->cmd_lock);
 }
 
-- 
2.14.2
