From: julien.grall@arm.com (Julien Grall)
Date: Thu, 10 May 2018 15:04:31 +0100
Subject: [RFC 03/13] virtio/scsi: Allow to use multiple banks
In-Reply-To: <20180510140441.24573-1-julien.grall@arm.com>
References: <20180510140441.24573-1-julien.grall@arm.com>
Message-ID: <20180510140441.24573-4-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, virtio scsi only register a bank starting at 0. On some
architectures this may not be true and the guest may have multiple
memory region.

Register all the memory regions to vhost by browsing kvm->mem_banks. The
code is based on the virtio_net__vhost_init implementation.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

This code was not tested as I don't have any setup with scsi.
---
 virtio/scsi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/virtio/scsi.c b/virtio/scsi.c
index 58d2353..ee58e5f 100644
--- a/virtio/scsi.c
+++ b/virtio/scsi.c
@@ -182,24 +182,29 @@ static struct virtio_ops scsi_dev_virtio_ops = {
 
 static void virtio_scsi_vhost_init(struct kvm *kvm, struct scsi_dev *sdev)
 {
+	struct kvm_mem_bank *bank;
 	struct vhost_memory *mem;
 	u64 features;
-	int r;
+	int r, i;
 
 	sdev->vhost_fd = open("/dev/vhost-scsi", O_RDWR);
 	if (sdev->vhost_fd < 0)
 		die_perror("Failed openning vhost-scsi device");
 
-	mem = calloc(1, sizeof(*mem) + sizeof(struct vhost_memory_region));
+	mem = calloc(1, sizeof(*mem) + kvm->mem_slots * sizeof(struct vhost_memory_region));
 	if (mem == NULL)
 		die("Failed allocating memory for vhost memory map");
 
-	mem->nregions = 1;
-	mem->regions[0] = (struct vhost_memory_region) {
-		.guest_phys_addr	= 0,
-		.memory_size		= kvm->ram_size,
-		.userspace_addr		= (unsigned long)kvm->ram_start,
-	};
+	i = 0;
+	list_for_each_entry(bank, &kvm->mem_banks, list) {
+		mem->regions[0] = (struct vhost_memory_region) {
+			.guest_phys_addr	= bank->guest_phys_addr,
+			.memory_size		= bank->size,
+			.userspace_addr		= (unsigned long)bank->host_addr,
+		};
+
+	}
+	mem->nregions = i;
 
 	r = ioctl(sdev->vhost_fd, VHOST_SET_OWNER);
 	if (r != 0)
-- 
2.11.0
