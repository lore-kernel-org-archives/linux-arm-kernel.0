From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Aug 2016 11:46:54 +0100
Subject: [PATCH v2 3/7] KVM: arm: vgic-new: improve compatibility with 32-bit
In-Reply-To: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471344418-19568-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have couple of 64-bit register defined in GICv3 architecture, so
"unsigned long" kind of accessors wouldn't work for 32-bit. However,
these registers can't be access as 64-bit in a one go if we run 32-bit
host simply because KVM doesn't support multiple load/store on MMIO
space.

It means that 32-bit guest access these registers in 32-bit chunks, so
the only thing we need to do is to ensure that extract_bytes() always
takes 64-bit data.

Since we are here fix couple of other width related issues by using
ULL variants over UL.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |    6 +++---
 virt/kvm/arm/vgic/vgic-mmio.h    |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index ff668e0..cc20b60 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -23,7 +23,7 @@
 #include "vgic-mmio.h"
 
 /* extract @num bytes at @offset bytes offset in data */
-unsigned long extract_bytes(unsigned long data, unsigned int offset,
+unsigned long extract_bytes(u64 data, unsigned int offset,
 			    unsigned int num)
 {
 	return (data >> (offset * 8)) & GENMASK_ULL(num * 8 - 1, 0);
@@ -179,7 +179,7 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 	int target_vcpu_id = vcpu->vcpu_id;
 	u64 value;
 
-	value = (mpidr & GENMASK(23, 0)) << 32;
+	value = (mpidr & GENMASK_ULL(23, 0)) << 32;
 	value |= ((target_vcpu_id & 0xffff) << 8);
 	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
 		value |= GICR_TYPER_LAST;
@@ -603,7 +603,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
 	bool broadcast;
 
 	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
-	broadcast = reg & BIT(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
+	broadcast = reg & BIT_ULL(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
 	target_cpus = (reg & ICC_SGI1R_TARGET_LIST_MASK) >> ICC_SGI1R_TARGET_LIST_SHIFT;
 	mpidr = SGI_AFFINITY_LEVEL(reg, 3);
 	mpidr |= SGI_AFFINITY_LEVEL(reg, 2);
diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 0b3ecf9..80f92ce 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -96,7 +96,7 @@ unsigned long vgic_data_mmio_bus_to_host(const void *val, unsigned int len);
 void vgic_data_host_to_mmio_bus(void *buf, unsigned int len,
 				unsigned long data);
 
-unsigned long extract_bytes(unsigned long data, unsigned int offset,
+unsigned long extract_bytes(u64 data, unsigned int offset,
 			    unsigned int num);
 
 u64 update_64bit_reg(u64 reg, unsigned int offset, unsigned int len,
-- 
1.7.9.5
