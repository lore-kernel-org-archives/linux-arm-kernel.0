From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Dec 2017 15:23:01 +0000
Subject: [PATCH v2 2/8] arm64: limit PA size to supported range
In-Reply-To: <20171222152307.11252-1-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
Message-ID: <20171222152307.11252-3-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kristina Martsenko <kristina.martsenko@arm.com>

We currently copy the physical address size from
ID_AA64MMFR0_EL1.PARange directly into TCR.(I)PS. This will not work for
4k and 16k granule kernels on systems that support 52-bit physical
addresses, since 52-bit addresses are only permitted with the 64k
granule.

To fix this, fall back to 48 bits when configuring the PA size when the
kernel does not support 52-bit PAs. When it does, fall back to 52, to
avoid similar problems in the future if the PA size is ever increased
above 52.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
[catalin.marinas at arm.com: tcr_set_pa_size macro renamed to tcr_compute_pa_size]
[catalin.marinas at arm.com: comments added to tcr_compute_pa_size]
[catalin.marinas at arm.com: definitions added for TCR_*PS_SHIFT]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/assembler.h     | 18 ++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/include/asm/sysreg.h        |  8 ++++++++
 arch/arm64/kvm/hyp-init.S              |  6 ++----
 arch/arm64/kvm/hyp/s2-setup.c          |  2 ++
 arch/arm64/mm/proc.S                   |  6 ++----
 6 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index aef72d886677..04a92307e6c1 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -351,6 +351,24 @@ alternative_endif
 	.endm
 
 /*
+ * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
+ * ID_AA64MMFR0_EL1.PARange value
+ *
+ *	tcr:		register with the TCR_ELx value to be updated
+ *	pos:		PARange bitfield position
+ *	tmp{0,1}:	temporary registers
+ */
+	.macro	tcr_compute_pa_size, tcr, pos, tmp0, tmp1
+	mrs	\tmp0, ID_AA64MMFR0_EL1
+	// Narrow PARange to fit the PS field in TCR_ELx
+	ubfx	\tmp0, \tmp0, #ID_AA64MMFR0_PARANGE_SHIFT, #3
+	mov	\tmp1, #ID_AA64MMFR0_PARANGE_MAX
+	cmp	\tmp0, \tmp1
+	csel	\tmp0, \tmp1, \tmp0, hi
+	bfi	\tcr, \tmp0, \pos, #3
+	.endm
+
+/*
  * Macro to perform a data cache maintenance for the interval
  * [kaddr, kaddr + size)
  *
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c1de9f67980b..9be2e9371c52 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -272,6 +272,8 @@
 #define TCR_TG1_4K		(UL(2) << TCR_TG1_SHIFT)
 #define TCR_TG1_64K		(UL(3) << TCR_TG1_SHIFT)
 
+#define TCR_IPS_SHIFT		32
+#define TCR_IPS_MASK		(UL(7) << TCR_IPS_SHIFT)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 #define TCR_HA			(UL(1) << 39)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 08cc88574659..ec144f480b39 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -471,6 +471,14 @@
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
 #define ID_AA64MMFR0_TGRAN16_NI		0x0
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
+#define ID_AA64MMFR0_PARANGE_48		0x5
+#define ID_AA64MMFR0_PARANGE_52		0x6
+
+#ifdef CONFIG_ARM64_PA_BITS_52
+#define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_52
+#else
+#define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_48
+#endif
 
 /* id_aa64mmfr1 */
 #define ID_AA64MMFR1_PAN_SHIFT		20
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 3f9615582377..e2d1fe03662a 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -90,11 +90,9 @@ __do_hyp_init:
 	bfi	x4, x5, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
 #endif
 	/*
-	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
-	 * TCR_EL2.
+	 * Set the PS bits in TCR_EL2.
 	 */
-	mrs	x5, ID_AA64MMFR0_EL1
-	bfi	x4, x5, #16, #3
+	tcr_compute_pa_size x4, #TCR_EL2_PS_SHIFT, x5, x6
 
 	msr	tcr_el2, x4
 
diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
index a81f5e10fc8c..603e1ee83e89 100644
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -32,6 +32,8 @@ u32 __hyp_text __init_stage2_translation(void)
 	 * PS is only 3. Fortunately, bit 19 is RES0 in VTCR_EL2...
 	 */
 	parange = read_sysreg(id_aa64mmfr0_el1) & 7;
+	if (parange > ID_AA64MMFR0_PARANGE_MAX)
+		parange = ID_AA64MMFR0_PARANGE_MAX;
 	val |= parange << 16;
 
 	/* Compute the actual PARange... */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 95233dfc4c39..4f133cb340dc 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -228,11 +228,9 @@ ENTRY(__cpu_setup)
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the IPS bits in
-	 * TCR_EL1.
+	 * Set the IPS bits in TCR_EL1.
 	 */
-	mrs	x9, ID_AA64MMFR0_EL1
-	bfi	x10, x9, #32, #3
+	tcr_compute_pa_size x10, #TCR_IPS_SHIFT, x5, x6
 #ifdef CONFIG_ARM64_HW_AFDBM
 	/*
 	 * Hardware update of the Access and Dirty bits.
