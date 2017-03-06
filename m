From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:25 +0100
Subject: [PATCH v3 10/19] KVM: arm64: ITS: Check the device id matches TYPER
 DEVBITS range
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-11-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MAPD we currently check the device id can be stored in the device table.
Let's first check it can be encoded within the range defined by TYPER
DEVBITS.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 694023f..322e370 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -180,6 +180,7 @@ static struct its_ite *find_ite(struct vgic_its *its, u32 device_id,
 
 #define VITS_ESZ 8
 #define VITS_TYPER_IDBITS 0xF
+#define VITS_TYPER_DEVBITS 0xF
 
 /*
  * Finds and returns a collection in the ITS collection table.
@@ -402,7 +403,7 @@ static unsigned long vgic_mmio_read_its_typer(struct kvm *kvm,
 	 * To avoid memory waste in the guest, we keep the number of IDBits and
 	 * DevBits low - as least for the time being.
 	 */
-	reg |= 0x0f << GITS_TYPER_DEVBITS_SHIFT;
+	reg |= VITS_TYPER_DEVBITS << GITS_TYPER_DEVBITS_SHIFT;
 	reg |= VITS_TYPER_IDBITS << GITS_TYPER_IDBITS_SHIFT;
 	reg |= (VITS_ESZ - 1) << GITS_TYPER_ITT_ENTRY_SIZE_SHIFT;
 
@@ -631,7 +632,7 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
  * Check whether an ID can be stored into the corresponding guest table.
  * For a direct table this is pretty easy, but gets a bit nasty for
  * indirect tables. We check whether the resulting guest physical address
- * is actually valid (covered by a memslot and guest accessbible).
+ * is actually valid (covered by a memslot and guest accessible).
  * For this we have to read the respective first level entry.
  */
 static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
@@ -642,6 +643,9 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
 	gfn_t gfn;
 	int esz = GITS_BASER_ENTRY_SIZE(baser);
 
+	if (id >= (2 << (VITS_TYPER_DEVBITS + 1)))
+		return false;
+
 	if (!(baser & GITS_BASER_INDIRECT)) {
 		phys_addr_t addr;
 
-- 
2.5.5
