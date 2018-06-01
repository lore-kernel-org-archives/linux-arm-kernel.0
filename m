From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:36 +0100
Subject: [PATCH 22/33] KVM: arm/arm64: Document
 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-23-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

We introduce a new KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute in
KVM_DEV_ARM_VGIC_GRP_ADDR group. It allows userspace to provide the
base address and size of a redistributor region

Compared to KVM_VGIC_V3_ADDR_TYPE_REDIST, this new attribute allows
to declare several separate redistributor regions.

So the whole redist space does not need to be contiguous anymore.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../virtual/kvm/devices/arm-vgic-v3.txt       | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index 9293b45abdb9..2408ab720ef7 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -27,16 +27,42 @@ Groups:
       VCPU and all of the redistributor pages are contiguous.
       Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
       This address needs to be 64K aligned.
+
+    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
+      The attribute data pointed to by kvm_device_attr.addr is a __u64 value:
+      bits:     | 63   ....  52  |  51   ....   16 | 15 - 12  |11 - 0
+      values:   |     count      |       base      |  flags   | index
+      - index encodes the unique redistributor region index
+      - flags: reserved for future use, currently 0
+      - base field encodes bits [51:16] of the guest physical base address
+        of the first redistributor in the region.
+      - count encodes the number of redistributors in the region. Must be
+        greater than 0.
+      There are two 64K pages for each redistributor in the region and
+      redistributors are laid out contiguously within the region. Regions
+      are filled with redistributors in the index order. The sum of all
+      region count fields must be greater than or equal to the number of
+      VCPUs. Redistributor regions must be registered in the incremental
+      index order, starting from index 0.
+      The characteristics of a specific redistributor region can be read
+      by presetting the index field in the attr data.
+      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+
+  It is invalid to mix calls with KVM_VGIC_V3_ADDR_TYPE_REDIST and
+  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attributes.
+
   Errors:
     -E2BIG:  Address outside of addressable IPA range
-    -EINVAL: Incorrectly aligned address
+    -EINVAL: Incorrectly aligned address, bad redistributor region
+             count/index, mixed redistributor region attribute usage
     -EEXIST: Address already configured
+    -ENOENT: Attempt to read the characteristics of a non existing
+             redistributor region
     -ENXIO:  The group or attribute is unknown/unsupported for this device
              or hardware support is missing.
     -EFAULT: Invalid user pointer for attr->addr.
 
 
-
   KVM_DEV_ARM_VGIC_GRP_DIST_REGS
   KVM_DEV_ARM_VGIC_GRP_REDIST_REGS
   Attributes:
-- 
2.17.1
