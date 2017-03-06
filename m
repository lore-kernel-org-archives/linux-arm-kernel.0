From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:21 +0100
Subject: [PATCH v3 06/19] KVM: arm64: ITS: Implement
 vgic_mmio_uaccess_write_its_creadr
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GITS_CREADR needs to be restored so let's implement the associated
uaccess_write_its callback.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 virt/kvm/arm/vgic/vgic-its.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index e9c8f9f..6120c6e 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1225,6 +1225,25 @@ static unsigned long vgic_mmio_read_its_creadr(struct kvm *kvm,
 	return extract_bytes(its->creadr, addr & 0x7, len);
 }
 
+static void vgic_mmio_uaccess_write_its_creadr(struct kvm *kvm,
+					       struct vgic_its *its,
+					       gpa_t addr, unsigned int len,
+					       unsigned long val)
+{
+	u32 reg;
+
+	mutex_lock(&its->cmd_lock);
+	reg = update_64bit_reg(its->creadr, addr & 7, len, val);
+	reg = ITS_CMD_OFFSET(reg);
+	if (reg >= ITS_CMD_BUFFER_SIZE(its->cbaser)) {
+		mutex_unlock(&its->cmd_lock);
+		return;
+	}
+
+	its->creadr = reg;
+	mutex_unlock(&its->cmd_lock);
+}
+
 #define BASER_INDEX(addr) (((addr) / sizeof(u64)) & 0x7)
 static unsigned long vgic_mmio_read_its_baser(struct kvm *kvm,
 					      struct vgic_its *its,
@@ -1320,7 +1339,8 @@ static struct vgic_register_region its_registers[] = {
 		vgic_mmio_read_its_cwriter, vgic_mmio_write_its_cwriter, NULL,
 		8, VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
 	REGISTER_ITS_DESC(GITS_CREADR,
-		vgic_mmio_read_its_creadr, its_mmio_write_wi, NULL, 8,
+		vgic_mmio_read_its_creadr, its_mmio_write_wi,
+		vgic_mmio_uaccess_write_its_creadr, 8,
 		VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
 	REGISTER_ITS_DESC(GITS_BASER,
 		vgic_mmio_read_its_baser, vgic_mmio_write_its_baser, NULL, 0x40,
-- 
2.5.5
