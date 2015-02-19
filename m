From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Feb 2015 10:54:45 +0000
Subject: [RFC/RFT PATCH 2/3] arm64: KVM: mangle MAIR register to prevent
 uncached guest mappings
In-Reply-To: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1424343286-6792-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mangle the memory attribute register values at each write to MAIR_EL1
so that regions that the guest intends to map as device or uncached are
in fact mapped as cached instead. This avoids incoherency issues when
the guest bypassed the caches to access memory that the host has mapped
as cached.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1e170eab6603..bde2b49a7cd8 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -110,6 +110,39 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool access_mair(struct kvm_vcpu *vcpu,
+			const struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	unsigned long val, mask;
+
+	BUG_ON(!p->is_write);
+
+	val = *vcpu_reg(vcpu, p->Rt);
+
+	if (!p->is_aarch32) {
+		/*
+		 * Mangle val so that all device and uncached attributes are
+		 * replaced with cached attributes.
+		 * For each attribute, check whether any of bit 7, bit 5 or bit
+		 * 4 are set. If not, it is a device or outer non-cacheable
+		 * mapping and we override it with inner, outer write-through,
+		 * read+write-allocate (0xbb).
+		 * TODO: handle outer cacheable inner non-cacheable
+		 */
+		mask = ~(val >> 7 | val >> 5 | val >> 4) & 0x0101010101010101UL;
+		val = (val & ~(mask * 0xff)) | (mask * 0xbb);
+
+		vcpu_sys_reg(vcpu, r->reg) = val;
+	} else {
+		if (!p->is_32bit)
+			vcpu_cp15_64_high(vcpu, r->reg) = val >> 32;
+		vcpu_cp15_64_low(vcpu, r->reg) = val & 0xffffffffUL;
+	}
+
+	return true;
+}
+
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			const struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -371,7 +404,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* MAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
-	  access_vm_reg, reset_unknown, MAIR_EL1 },
+	  access_mair, reset_unknown, MAIR_EL1 },
 	/* AMAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0011), Op2(0b000),
 	  access_handled_at_el2, reset_amair_el1, AMAIR_EL1 },
-- 
1.8.3.2
