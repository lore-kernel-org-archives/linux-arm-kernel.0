From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 14 Jan 2015 16:31:18 +0000
Subject: [PATCH v7 14/20] arm/arm64: KVM: add opaque private pointer to MMIO
 data
In-Reply-To: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1421253084-9663-15-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a GICv2 there is always only one (v)CPU involved: the one that
does the access. On a GICv3 the access to a CPU redistributor is
memory-mapped, but not banked, so the (v)CPU affected is determined by
looking at the MMIO address region being accessed.
To allow passing the affected CPU into the accessors later, extend
struct kvm_exit_mmio to add an opaque private pointer parameter.
The current GICv2 emulation just does not use it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changelog v6...v7:
 (none)

Changelog v5...v6:
 (none)

Changelog v4...v5:
 (add Acked-by:)

Changelog v3...v4:
- moving private parameter from each accessor into struct kvm_exit_mmio

 arch/arm/include/asm/kvm_mmio.h   |    1 +
 arch/arm64/include/asm/kvm_mmio.h |    1 +
 virt/kvm/arm/vgic.c               |    1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/kvm_mmio.h b/arch/arm/include/asm/kvm_mmio.h
index adcc0d7..3f83db2 100644
--- a/arch/arm/include/asm/kvm_mmio.h
+++ b/arch/arm/include/asm/kvm_mmio.h
@@ -37,6 +37,7 @@ struct kvm_exit_mmio {
 	u8		data[8];
 	u32		len;
 	bool		is_write;
+	void		*private;
 };
 
 static inline void kvm_prepare_mmio(struct kvm_run *run,
diff --git a/arch/arm64/include/asm/kvm_mmio.h b/arch/arm64/include/asm/kvm_mmio.h
index fc2f689..9f52beb 100644
--- a/arch/arm64/include/asm/kvm_mmio.h
+++ b/arch/arm64/include/asm/kvm_mmio.h
@@ -40,6 +40,7 @@ struct kvm_exit_mmio {
 	u8		data[8];
 	u32		len;
 	bool		is_write;
+	void		*private;
 };
 
 static inline void kvm_prepare_mmio(struct kvm_run *run,
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0e84292..b6e17c8 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -709,6 +709,7 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
 
 	mmio32.len = 4;
 	mmio32.is_write = mmio->is_write;
+	mmio32.private = mmio->private;
 
 	mmio32.phys_addr = mmio->phys_addr + 4;
 	if (mmio->is_write)
-- 
1.7.9.5
