From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:31:02 +0200
Subject: [PATCH v4 12/22] KVM: arm64: ITS: Check the device id matches TYPER
 DEVBITS range
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-13-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MAPD we currently check the device id can be stored in the device table.
Let's first check it can be encoded within the range defined by TYPER
DEVBITS.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- VITS_TYPER_DEVBITS set to 16 for homogeneity
- use BIT_ULL
---
 virt/kvm/arm/vgic/vgic-its.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 89a0db7..b275aea 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -183,6 +183,7 @@ static struct its_ite *find_ite(struct vgic_its *its, u32 device_id,
 
 #define VITS_ESZ 8
 #define VITS_TYPER_IDBITS 16
+#define VITS_TYPER_DEVBITS 16
 
 /*
  * Finds and returns a collection in the ITS collection table.
@@ -382,8 +383,8 @@ static unsigned long vgic_mmio_read_its_typer(struct kvm *kvm,
 	 * To avoid memory waste in the guest, we keep the number of IDBits and
 	 * DevBits low - as least for the time being.
 	 */
-	reg |= 0x0f << GITS_TYPER_DEVBITS_SHIFT;
 	reg |= (VITS_TYPER_IDBITS - 1) << GITS_TYPER_IDBITS_SHIFT;
+	reg |= (VITS_TYPER_DEVBITS - 1) << GITS_TYPER_DEVBITS_SHIFT;
 	reg |= (VITS_ESZ - 1) << GITS_TYPER_ITT_ENTRY_SIZE_SHIFT;
 
 	return extract_bytes(reg, addr & 7, len);
@@ -623,10 +624,10 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
  * Check whether an ID can be stored into the corresponding guest table.
  * For a direct table this is pretty easy, but gets a bit nasty for
  * indirect tables. We check whether the resulting guest physical address
- * is actually valid (covered by a memslot and guest accessbible).
+ * is actually valid (covered by a memslot and guest accessible).
  * For this we have to read the respective first level entry.
  */
-static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
+static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id)
 {
 	int l1_tbl_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
 	int index;
@@ -634,6 +635,9 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
 	gfn_t gfn;
 	int esz = GITS_BASER_ENTRY_SIZE(baser);
 
+	if (id >= BIT_ULL(VITS_TYPER_DEVBITS))
+		return false;
+
 	if (!(baser & GITS_BASER_INDIRECT)) {
 		phys_addr_t addr;
 
-- 
2.5.5
