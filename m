From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:47 +0100
Subject: [PULL 22/27] KVM: arm/arm64: GICv4: Prevent a VM using GICv4 from
 being saved
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-23-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The GICv4 architecture doesn't make it easy for save/restore to
work, as it doesn't give any guarantee that the pending state
is written into the pending table.

So let's not take any chance, and let's return an error if
we encounter any LPI that has the HW bit set. In order for
userspace to distinguish this error from other failure modes,
use -EACCES as an error code.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic-its.txt | 2 ++
 virt/kvm/arm/vgic/vgic-its.c                       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
index 8d5830eab26a..4f0c9fc40365 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
@@ -64,6 +64,8 @@ Groups:
     -EINVAL: Inconsistent restored data
     -EFAULT: Invalid guest ram access
     -EBUSY:  One or more VCPUS are running
+    -EACCES: The virtual ITS is backed by a physical GICv4 ITS, and the
+	     state is not available
 
   KVM_DEV_ARM_VGIC_GRP_ITS_REGS
   Attributes:
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index bf571f6d2b32..b8c1b724ba3e 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1995,6 +1995,15 @@ static int vgic_its_save_itt(struct vgic_its *its, struct its_device *device)
 	list_for_each_entry(ite, &device->itt_head, ite_list) {
 		gpa_t gpa = base + ite->event_id * ite_esz;
 
+		/*
+		 * If an LPI carries the HW bit, this means that this
+		 * interrupt is controlled by GICv4, and we do not
+		 * have direct access to that state. Let's simply fail
+		 * the save operation...
+		 */
+		if (ite->irq->hw)
+			return -EACCES;
+
 		ret = vgic_its_save_ite(its, device, ite, gpa, ite_esz);
 		if (ret)
 			return ret;
-- 
2.14.2
