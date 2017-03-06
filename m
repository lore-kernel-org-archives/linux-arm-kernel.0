From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:24 +0100
Subject: [PATCH v3 09/19] KVM: arm64: ITS: Interpret MAPD ITT_addr field
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-10-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now the MAPD ITT_addr had been ignored. We will need it
for save/restore. Let's record it in the its_device struct.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 56bcd92..694023f 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -99,6 +99,7 @@ struct its_device {
 
 	/* the head for the list of ITTEs */
 	struct list_head itt_head;
+	gpa_t itt_addr;
 	u32 nb_eventid_bits;
 	u32 device_id;
 };
@@ -562,6 +563,7 @@ static u64 its_cmd_mask_field(u64 *its_cmd, int word, int shift, int size)
 #define its_cmd_get_collection(cmd)	its_cmd_mask_field(cmd, 2,  0, 16)
 #define its_cmd_get_target_addr(cmd)	its_cmd_mask_field(cmd, 2, 16, 32)
 #define its_cmd_get_validbit(cmd)	its_cmd_mask_field(cmd, 2, 63,  1)
+#define its_cmd_get_ittaddr(cmd)	its_cmd_mask_field(cmd, 2, 8,  44)
 #define its_cmd_get_size(cmd)		its_cmd_mask_field(cmd, 1, 0,  5)
 
 /*
@@ -832,6 +834,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	u32 device_id = its_cmd_get_deviceid(its_cmd);
 	bool valid = its_cmd_get_validbit(its_cmd);
 	size_t size = its_cmd_get_size(its_cmd);
+	gpa_t itt_addr = its_cmd_get_ittaddr(its_cmd);
 	struct its_device *device;
 
 	if (!vgic_its_check_id(its, its->baser_device_table, device_id))
@@ -862,6 +865,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 		return -ENOMEM;
 
 	device->device_id = device_id;
+	device->itt_addr = itt_addr << 8;
 	device->nb_eventid_bits = size + 1;
 
 	INIT_LIST_HEAD(&device->itt_head);
-- 
2.5.5
