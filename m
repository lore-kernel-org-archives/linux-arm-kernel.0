From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:30:59 +0200
Subject: [PATCH v4 09/22] KVM: arm64: ITS: Report the ITE size in GITS_TYPER
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-10-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An ITE size of 8 Bytes is reported to the guest. Combining this
information with the number of event IDs the guest wants to support,
this latter will be able to allocate each device's ITT with the
right size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

---

v2 -> v3:
- changed (u64)(VITS_ESZ - 1) to (VITS_ESZ - 1ULL) in
  vgic_register_its_iodev
- added Andre's R-b

v1 -> v2:
- correct ITT_ENTRY_SIZE field
- remove ITE_SIZE since all entries become 8 bytes
---
 include/linux/irqchip/arm-gic-v3.h | 1 +
 virt/kvm/arm/vgic/vgic-its.c       | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 97cbca1..d86f963 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -232,6 +232,7 @@
 #define GITS_CTLR_QUIESCENT		(1U << 31)
 
 #define GITS_TYPER_PLPIS		(1UL << 0)
+#define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 169b486..fabcac1 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -179,6 +179,8 @@ static struct its_ite *find_ite(struct vgic_its *its, u32 device_id,
 
 #define GIC_LPI_OFFSET 8192
 
+#define VITS_ESZ 8
+
 /*
  * Finds and returns a collection in the ITS collection table.
  * Must be called with the its_lock mutex held.
@@ -379,6 +381,7 @@ static unsigned long vgic_mmio_read_its_typer(struct kvm *kvm,
 	 */
 	reg |= 0x0f << GITS_TYPER_DEVBITS_SHIFT;
 	reg |= 0x0f << GITS_TYPER_IDBITS_SHIFT;
+	reg |= (VITS_ESZ - 1) << GITS_TYPER_ITT_ENTRY_SIZE_SHIFT;
 
 	return extract_bytes(reg, addr & 7, len);
 }
@@ -1436,7 +1439,7 @@ static int vgic_register_its_iodev(struct kvm *kvm, struct vgic_its *its)
 	(GIC_BASER_CACHEABILITY(GITS_BASER, INNER, RaWb)		| \
 	 GIC_BASER_CACHEABILITY(GITS_BASER, OUTER, SameAsInner)		| \
 	 GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)		| \
-	 ((8ULL - 1) << GITS_BASER_ENTRY_SIZE_SHIFT)			| \
+	 ((VITS_ESZ - 1ULL) << GITS_BASER_ENTRY_SIZE_SHIFT)		| \
 	 GITS_BASER_PAGE_SIZE_64K)
 
 #define INITIAL_PROPBASER_VALUE						  \
-- 
2.5.5
