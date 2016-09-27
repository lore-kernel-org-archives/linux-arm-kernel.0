From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:50 +0200
Subject: [PULL 42/50] KVM: arm: vgic: Support 64-bit data manipulation on
 32-bit host systems
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-43-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

We have couple of 64-bit registers defined in GICv3 architecture, so
unsigned long accesses to these registers will only access a single
32-bit part of that regitser. On the other hand these registers can't
be accessed as 64-bit with a single instruction like ldrd/strd or
ldmia/stmia if we run a 32-bit host because KVM does not support
access to MMIO space done by these instructions.

It means that a 32-bit guest accesses these registers in 32-bit
chunks, so the only thing we need to do is to ensure that
extract_bytes() always takes 64-bit data.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 2 +-
 virt/kvm/arm/vgic/vgic-mmio.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 6385ed5..0d3c76a 100644
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
2.9.0
