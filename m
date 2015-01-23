From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:55 +0100
Subject: [GIT PULL 26/36] arm/arm64: KVM: add vgic.h header file
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-27-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

vgic.c is currently a mixture of generic vGIC emulation code and
functions specific to emulating a GICv2. To ease the addition of
GICv3 later, we create new header file vgic.h, which holds constants
and prototypes of commonly used functions.
Rename some identifiers to avoid name space clutter.
I removed the long-standing comment about using the kvm_io_bus API
to tackle the GIC register ranges, as it wouldn't be a win for us
anymore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

-------
As the diff isn't always obvious here (and to aid eventual rebases),
here is a list of high-level changes done to the code:
* moved definitions and prototypes from vgic.c to vgic.h:
  - VGIC_ADDR_UNDEF
  - ACCESS_{READ,WRITE}_*
  - vgic_init()
  - vgic_update_state()
  - vgic_kick_vcpus()
  - vgic_get_vmcr()
  - vgic_set_vmcr()
  - struct mmio_range {} (renamed to struct kvm_mmio_range)
* removed static keyword and exported prototype in vgic.h:
  - vgic_bitmap_get_reg()
  - vgic_bitmap_set_irq_val()
  - vgic_bitmap_get_shared_map()
  - vgic_bytemap_get_reg()
  - vgic_dist_irq_set_pending()
  - vgic_dist_irq_clear_pending()
  - vgic_cpu_irq_clear()
  - vgic_reg_access()
  - handle_mmio_raz_wi()
  - vgic_handle_enable_reg()
  - vgic_handle_set_pending_reg()
  - vgic_handle_clear_pending_reg()
  - vgic_handle_cfg_reg()
  - vgic_unqueue_irqs()
  - find_matching_range() (renamed to vgic_find_range)
  - vgic_handle_mmio_range()
  - vgic_update_state()
  - vgic_get_vmcr()
  - vgic_set_vmcr()
  - vgic_queue_irq()
  - vgic_kick_vcpus()
  - vgic_init()
  - vgic_v2_init_emulation()
  - vgic_has_attr_regs()
  - vgic_set_common_attr()
  - vgic_get_common_attr()
  - vgic_destroy()
  - vgic_create()
* moved functions to vgic.h (static inline):
  - mmio_data_read()
  - mmio_data_write()
  - is_in_range()

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 151 +++++++++++++++++-----------------------------------
 virt/kvm/arm/vgic.h | 120 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 101 deletions(-)
 create mode 100644 virt/kvm/arm/vgic.h

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 06073fa..ce6c998 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -75,33 +75,16 @@
  *   inactive as long as the external input line is held high.
  */
 
-#define VGIC_ADDR_UNDEF		(-1)
-#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+#include "vgic.h"
 
-#define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
-#define IMPLEMENTER_ARM		0x43b
 #define GICC_ARCH_VERSION_V2	0x2
 
-#define ACCESS_READ_VALUE	(1 << 0)
-#define ACCESS_READ_RAZ		(0 << 0)
-#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
-#define ACCESS_WRITE_IGNORED	(0 << 1)
-#define ACCESS_WRITE_SETBIT	(1 << 1)
-#define ACCESS_WRITE_CLEARBIT	(2 << 1)
-#define ACCESS_WRITE_VALUE	(3 << 1)
-#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
-
-static int vgic_init(struct kvm *kvm);
 static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
-static void vgic_update_state(struct kvm *kvm);
-static void vgic_kick_vcpus(struct kvm *kvm);
 static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
 static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
 static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
-static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
-static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 
 static const struct vgic_ops *vgic_ops;
 static const struct vgic_params *vgic;
@@ -175,8 +158,7 @@ static unsigned long *u64_to_bitmask(u64 *val)
 	return (unsigned long *)val;
 }
 
-static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
-				int cpuid, u32 offset)
+u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x, int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
@@ -194,8 +176,8 @@ static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
 	return test_bit(irq - VGIC_NR_PRIVATE_IRQS, x->shared);
 }
 
-static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
-				    int irq, int val)
+void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
+			     int irq, int val)
 {
 	unsigned long *reg;
 
@@ -217,7 +199,7 @@ static unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x, int cpuid)
 	return x->private + cpuid;
 }
 
-static unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
+unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x)
 {
 	return x->shared;
 }
@@ -244,7 +226,7 @@ static void vgic_free_bytemap(struct vgic_bytemap *b)
 	b->shared = NULL;
 }
 
-static u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
+u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset)
 {
 	u32 *reg;
 
@@ -341,14 +323,14 @@ static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_pending, vcpu->vcpu_id, irq);
 }
 
-static void vgic_dist_irq_set_pending(struct kvm_vcpu *vcpu, int irq)
+void vgic_dist_irq_set_pending(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
 	vgic_bitmap_set_irq_val(&dist->irq_pending, vcpu->vcpu_id, irq, 1);
 }
 
-static void vgic_dist_irq_clear_pending(struct kvm_vcpu *vcpu, int irq)
+void vgic_dist_irq_clear_pending(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
@@ -364,7 +346,7 @@ static void vgic_cpu_irq_set(struct kvm_vcpu *vcpu, int irq)
 			vcpu->arch.vgic_cpu.pending_shared);
 }
 
-static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
+void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
 		clear_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
@@ -378,16 +360,6 @@ static bool vgic_can_sample_irq(struct kvm_vcpu *vcpu, int irq)
 	return vgic_irq_is_edge(vcpu, irq) || !vgic_irq_is_queued(vcpu, irq);
 }
 
-static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
-{
-	return le32_to_cpu(*((u32 *)mmio->data)) & mask;
-}
-
-static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
-{
-	*((u32 *)mmio->data) = cpu_to_le32(value) & mask;
-}
-
 /**
  * vgic_reg_access - access vgic register
  * @mmio:   pointer to the data describing the mmio access
@@ -399,8 +371,8 @@ static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
  * modes defined for vgic register access
  * (read,raz,write-ignored,setbit,clearbit,write)
  */
-static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
-			    phys_addr_t offset, int mode)
+void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+		     phys_addr_t offset, int mode)
 {
 	int word_offset = (offset & 3) * 8;
 	u32 mask = (1UL << (mmio->len * 8)) - 1;
@@ -484,16 +456,16 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 	return false;
 }
 
-static bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
-			       struct kvm_exit_mmio *mmio, phys_addr_t offset)
+bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			phys_addr_t offset)
 {
 	vgic_reg_access(mmio, NULL, offset,
 			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
 	return false;
 }
 
-static bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
-				   phys_addr_t offset, int vcpu_id, int access)
+bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset, int vcpu_id, int access)
 {
 	u32 *reg;
 	int mode = ACCESS_READ_VALUE | access;
@@ -530,9 +502,9 @@ static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
 }
 
-static bool vgic_handle_set_pending_reg(struct kvm *kvm,
-					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset, int vcpu_id)
+bool vgic_handle_set_pending_reg(struct kvm *kvm,
+				 struct kvm_exit_mmio *mmio,
+				 phys_addr_t offset, int vcpu_id)
 {
 	u32 *reg, orig;
 	u32 level_mask;
@@ -567,9 +539,9 @@ static bool vgic_handle_set_pending_reg(struct kvm *kvm,
 	return false;
 }
 
-static bool vgic_handle_clear_pending_reg(struct kvm *kvm,
-					  struct kvm_exit_mmio *mmio,
-					  phys_addr_t offset, int vcpu_id)
+bool vgic_handle_clear_pending_reg(struct kvm *kvm,
+				   struct kvm_exit_mmio *mmio,
+				   phys_addr_t offset, int vcpu_id)
 {
 	u32 *level_active;
 	u32 *reg, orig;
@@ -741,8 +713,8 @@ static u16 vgic_cfg_compress(u32 val)
  * LSB is always 0. As such, we only keep the upper bit, and use the
  * two above functions to compress/expand the bits
  */
-static bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
-				phys_addr_t offset)
+bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
+			 phys_addr_t offset)
 {
 	u32 val;
 
@@ -818,7 +790,7 @@ static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
  * to the distributor but the active state stays in the LRs, because we don't
  * track the active state on the distributor side.
  */
-static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
+void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	int i;
@@ -943,21 +915,7 @@ static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
 		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, false);
 }
 
-/*
- * I would have liked to use the kvm_bus_io_*() API instead, but it
- * cannot cope with banked registers (only the VM pointer is passed
- * around, and we need the vcpu). One of these days, someone please
- * fix it!
- */
-struct mmio_range {
-	phys_addr_t base;
-	unsigned long len;
-	int bits_per_irq;
-	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
-			    phys_addr_t offset);
-};
-
-static const struct mmio_range vgic_dist_ranges[] = {
+static const struct kvm_mmio_range vgic_dist_ranges[] = {
 	{
 		.base		= GIC_DIST_CTRL,
 		.len		= 12,
@@ -1042,12 +1000,12 @@ static const struct mmio_range vgic_dist_ranges[] = {
 	{}
 };
 
-static const
-struct mmio_range *find_matching_range(const struct mmio_range *ranges,
+const
+struct kvm_mmio_range *vgic_find_range(const struct kvm_mmio_range *ranges,
 				       struct kvm_exit_mmio *mmio,
 				       phys_addr_t offset)
 {
-	const struct mmio_range *r = ranges;
+	const struct kvm_mmio_range *r = ranges;
 
 	while (r->len) {
 		if (offset >= r->base &&
@@ -1060,7 +1018,7 @@ struct mmio_range *find_matching_range(const struct mmio_range *ranges,
 }
 
 static bool vgic_validate_access(const struct vgic_dist *dist,
-				 const struct mmio_range *range,
+				 const struct kvm_mmio_range *range,
 				 unsigned long offset)
 {
 	int irq;
@@ -1088,7 +1046,7 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
 static bool call_range_handler(struct kvm_vcpu *vcpu,
 			       struct kvm_exit_mmio *mmio,
 			       unsigned long offset,
-			       const struct mmio_range *range)
+			       const struct kvm_mmio_range *range)
 {
 	u32 *data32 = (void *)mmio->data;
 	struct kvm_exit_mmio mmio32;
@@ -1132,18 +1090,18 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
  *
  * returns true if the MMIO access could be performed
  */
-static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
+bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			    struct kvm_exit_mmio *mmio,
-			    const struct mmio_range *ranges,
+			    const struct kvm_mmio_range *ranges,
 			    unsigned long mmio_base)
 {
-	const struct mmio_range *range;
+	const struct kvm_mmio_range *range;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	bool updated_state;
 	unsigned long offset;
 
 	offset = mmio->phys_addr - mmio_base;
-	range = find_matching_range(ranges, mmio, offset);
+	range = vgic_find_range(ranges, mmio, offset);
 	if (unlikely(!range || !range->handle_mmio)) {
 		pr_warn("Unhandled access %d %08llx %d\n",
 			mmio->is_write, mmio->phys_addr, mmio->len);
@@ -1169,12 +1127,6 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return true;
 }
 
-static inline bool is_in_range(phys_addr_t addr, unsigned long len,
-			       phys_addr_t baseaddr, unsigned long size)
-{
-	return (addr >= baseaddr) && (addr + len <= baseaddr + size);
-}
-
 static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 				struct kvm_exit_mmio *mmio)
 {
@@ -1301,7 +1253,7 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
  * Update the interrupt state and determine which CPUs have pending
  * interrupts. Must be called with distributor lock held.
  */
-static void vgic_update_state(struct kvm *kvm)
+void vgic_update_state(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
@@ -1362,12 +1314,12 @@ static inline void vgic_disable_underflow(struct kvm_vcpu *vcpu)
 	vgic_ops->disable_underflow(vcpu);
 }
 
-static inline void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
+void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
 {
 	vgic_ops->get_vmcr(vcpu, vmcr);
 }
 
-static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
+void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
 {
 	vgic_ops->set_vmcr(vcpu, vmcr);
 }
@@ -1417,7 +1369,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
  * Queue an interrupt to a CPU virtual interface. Return true on success,
  * or false if it wasn't possible to queue it.
  */
-static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
+bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1703,7 +1655,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	return test_bit(vcpu->vcpu_id, dist->irq_pending_on_cpu);
 }
 
-static void vgic_kick_vcpus(struct kvm *kvm)
+void vgic_kick_vcpus(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
 	int c;
@@ -1956,7 +1908,7 @@ static int vgic_v2_init_model(struct kvm *kvm)
  * Allocate and initialize the various data structures. Must be called
  * with kvm->lock held!
  */
-static int vgic_init(struct kvm *kvm)
+int vgic_init(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
@@ -2096,7 +2048,7 @@ out:
 	return ret;
 }
 
-static void vgic_v2_init_emulation(struct kvm *kvm)
+void vgic_v2_init_emulation(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
@@ -2326,7 +2278,7 @@ static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
  * CPU Interface Register accesses - these are not accessed by the VM, but by
  * user space for saving and restoring VGIC state.
  */
-static const struct mmio_range vgic_cpu_ranges[] = {
+static const struct kvm_mmio_range vgic_cpu_ranges[] = {
 	{
 		.base		= GIC_CPU_CTRL,
 		.len		= 12,
@@ -2353,7 +2305,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 				 struct kvm_device_attr *attr,
 				 u32 *reg, bool is_write)
 {
-	const struct mmio_range *r = NULL, *ranges;
+	const struct kvm_mmio_range *r = NULL, *ranges;
 	phys_addr_t offset;
 	int ret, cpuid, c;
 	struct kvm_vcpu *vcpu, *tmp_vcpu;
@@ -2394,7 +2346,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 	default:
 		BUG();
 	}
-	r = find_matching_range(ranges, &mmio, offset);
+	r = vgic_find_range(ranges, &mmio, offset);
 
 	if (unlikely(!r || !r->handle_mmio)) {
 		ret = -ENXIO;
@@ -2440,8 +2392,7 @@ out:
 	return ret;
 }
 
-static int vgic_set_common_attr(struct kvm_device *dev,
-				struct kvm_device_attr *attr)
+int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
 
@@ -2525,8 +2476,7 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static int vgic_get_common_attr(struct kvm_device *dev,
-				struct kvm_device_attr *attr)
+int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = -ENXIO;
 
@@ -2581,13 +2531,12 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static int vgic_has_attr_regs(const struct mmio_range *ranges,
-			      phys_addr_t offset)
+int vgic_has_attr_regs(const struct kvm_mmio_range *ranges, phys_addr_t offset)
 {
 	struct kvm_exit_mmio dev_attr_mmio;
 
 	dev_attr_mmio.len = 4;
-	if (find_matching_range(ranges, &dev_attr_mmio, offset))
+	if (vgic_find_range(ranges, &dev_attr_mmio, offset))
 		return 0;
 	else
 		return -ENXIO;
@@ -2622,12 +2571,12 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static void vgic_destroy(struct kvm_device *dev)
+void vgic_destroy(struct kvm_device *dev)
 {
 	kfree(dev);
 }
 
-static int vgic_create(struct kvm_device *dev, u32 type)
+int vgic_create(struct kvm_device *dev, u32 type)
 {
 	return kvm_vgic_create(dev->kvm, type);
 }
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
new file mode 100644
index 0000000..e363b93
--- /dev/null
+++ b/virt/kvm/arm/vgic.h
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2012-2014 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from virt/kvm/arm/vgic.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __KVM_VGIC_H__
+#define __KVM_VGIC_H__
+
+#define VGIC_ADDR_UNDEF		(-1)
+#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+
+#define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
+#define IMPLEMENTER_ARM		0x43b
+
+#define ACCESS_READ_VALUE	(1 << 0)
+#define ACCESS_READ_RAZ		(0 << 0)
+#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
+#define ACCESS_WRITE_IGNORED	(0 << 1)
+#define ACCESS_WRITE_SETBIT	(1 << 1)
+#define ACCESS_WRITE_CLEARBIT	(2 << 1)
+#define ACCESS_WRITE_VALUE	(3 << 1)
+#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
+
+unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
+
+void vgic_update_state(struct kvm *kvm);
+int vgic_init_common_maps(struct kvm *kvm);
+
+u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x, int cpuid, u32 offset);
+u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset);
+
+void vgic_dist_irq_set_pending(struct kvm_vcpu *vcpu, int irq);
+void vgic_dist_irq_clear_pending(struct kvm_vcpu *vcpu, int irq);
+void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq);
+void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
+			     int irq, int val);
+
+void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
+void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
+
+bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq);
+void vgic_unqueue_irqs(struct kvm_vcpu *vcpu);
+
+void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+		     phys_addr_t offset, int mode);
+bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			phys_addr_t offset);
+
+static inline
+u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
+{
+	return le32_to_cpu(*((u32 *)mmio->data)) & mask;
+}
+
+static inline
+void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
+{
+	*((u32 *)mmio->data) = cpu_to_le32(value) & mask;
+}
+
+struct kvm_mmio_range {
+	phys_addr_t base;
+	unsigned long len;
+	int bits_per_irq;
+	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset);
+};
+
+static inline bool is_in_range(phys_addr_t addr, unsigned long len,
+			       phys_addr_t baseaddr, unsigned long size)
+{
+	return (addr >= baseaddr) && (addr + len <= baseaddr + size);
+}
+
+const
+struct kvm_mmio_range *vgic_find_range(const struct kvm_mmio_range *ranges,
+				       struct kvm_exit_mmio *mmio,
+				       phys_addr_t offset);
+
+bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
+			    struct kvm_exit_mmio *mmio,
+			    const struct kvm_mmio_range *ranges,
+			    unsigned long mmio_base);
+
+bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+			    phys_addr_t offset, int vcpu_id, int access);
+
+bool vgic_handle_set_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+				 phys_addr_t offset, int vcpu_id);
+
+bool vgic_handle_clear_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
+				   phys_addr_t offset, int vcpu_id);
+
+bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
+			 phys_addr_t offset);
+
+void vgic_kick_vcpus(struct kvm *kvm);
+
+int vgic_has_attr_regs(const struct kvm_mmio_range *ranges, phys_addr_t offset);
+int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
+int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
+
+int vgic_init(struct kvm *kvm);
+void vgic_v2_init_emulation(struct kvm *kvm);
+
+#endif
-- 
2.1.2.330.g565301e.dirty
