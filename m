From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 14:24:48 +0100
Subject: next build: 629 warnings 1 failures (next/next-20140723)
In-Reply-To: <20140724104318.GA13371@arm.com>
References: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
 <CAOesGMhT9n7nVbCay5cU74pv2qrbqMooZLoY923Lk6SzXk5z+A@mail.gmail.com>
 <20140724085037.GB1994@arm.com> <20140724104318.GA13371@arm.com>
Message-ID: <20140724132448.GB13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 11:43:18AM +0100, Catalin Marinas wrote:
> On Thu, Jul 24, 2014 at 09:50:37AM +0100, Will Deacon wrote:
> > On Thu, Jul 24, 2014 at 12:27:30AM +0100, Olof Johansson wrote:
> > > I'm building with a vanilla gcc 4.8.2 / binutils 2.23.2. That
> > > shouldn't be broken like this, so those changes should be fixed (or
> > > minimal toolchain expecations need to be documented -- but there
> > > really is no good reason to require 4.9.0/2.24).
> > 
> > These all come from the GICv3 driver, so it's not going to be a lot of fun
> > fixing them. You'd have to introduce a macro for generating the system-reg
> > accesses (for both C and asm), then switch the GIC driver and the arch code
> > over to using that.
> 
> We may need to document that enabling GICv3 requires a newer toolchain.
> 
> Otherwise, my years old macros ;) (adapted here and untested):
[...]
> But I'll let Marc comment when he gets back from holiday (I'm pretty
> sure he will enjoy it ;))

Saving Marc some time:

------------8<--------------------------------

>From 3acb8b49aeba9f48153a2d719dec05d0b862e285 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 24 Jul 2014 14:14:42 +0100
Subject: [PATCH] arm64: gicv3: Allow GICv3 compilation with older binutils

GICv3 introduces new system registers accessible with the full msr/mrs
syntax (e.g. mrs x0, Sx_op0_op1_CRm_CRn_op2). However, only recent
binutils understand the new syntax. This patch introduces msr_s/mrs_s
assembly macros which generate the equivalent instructions above and
converts the existing GICv3 code (both drivers/irqchip/ and
arch/arm64/kernel/).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Olof Johansson <olof@lixom.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h    | 60 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           |  6 ++--
 drivers/irqchip/irq-gic-v3.c       | 16 +++++-----
 include/linux/irqchip/arm-gic-v3.h | 42 +++++++++++++-------------
 4 files changed, 93 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/include/asm/sysreg.h

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
new file mode 100644
index 000000000000..4e0195424212
--- /dev/null
+++ b/arch/arm64/include/asm/sysreg.h
@@ -0,0 +1,60 @@
+/*
+ * Macros for accessing system registers with older binutils.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
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
+#ifndef __ASM_SYSREG_H
+#define __ASM_SYSREG_H
+
+#define sys_reg(op0, op1, crn, crm, op2)        \
+	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
+
+#ifdef __ASSEMBLY__
+
+	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
+	.equ	__reg_num_x\num, \num
+	.endr
+	.equ	__reg_num_xzr, 31
+
+	.macro  mrs_s, rt, sreg
+	.inst   0xd5300000|(\sreg)|(__reg_num_\rt)
+	.endm
+
+	.macro  msr_s, sreg, rt
+	.inst   0xd5100000|(\sreg)|(__reg_num_\rt)
+	.endm
+
+#else
+
+__asm__(
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
+"	.equ	__reg_num_x\\num, \\num\n"
+"	.endr\n"
+"	.equ	__reg_num_xzr, 31\n"
+"\n"
+"       .macro  mrs_s, rt, sreg\n"
+"       .inst   0xd5300000|(\\sreg)|(__reg_num_\\rt)\n"
+"       .endm\n"
+"\n"
+"       .macro  msr_s, sreg, rt\n"
+"       .inst   0xd5100000|(\\sreg)|(__reg_num_\\rt)\n"
+"       .endm\n"
+);
+
+#endif
+
+#endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c99e3a879ebc..144f10567f82 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -297,12 +297,12 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	cmp	x0, #1
 	b.ne	3f
 
-	mrs	x0, ICC_SRE_EL2
+	mrs_s	x0, ICC_SRE_EL2
 	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
 	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
-	msr	ICC_SRE_EL2, x0
+	msr_s	ICC_SRE_EL2, x0
 	isb					// Make sure SRE is now set
-	msr	ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
+	msr_s	ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
 
 3:
 #endif
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 81519bae0453..57eaa5a0b1e3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -108,39 +108,39 @@ static u64 gic_read_iar(void)
 {
 	u64 irqstat;
 
-	asm volatile("mrs %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
+	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
 	return irqstat;
 }
 
 static void gic_write_pmr(u64 val)
 {
-	asm volatile("msr " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
 }
 
 static void gic_write_ctlr(u64 val)
 {
-	asm volatile("msr " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
 	isb();
 }
 
 static void gic_write_grpen1(u64 val)
 {
-	asm volatile("msr " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
 	isb();
 }
 
 static void gic_write_sgi1r(u64 val)
 {
-	asm volatile("msr " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
 }
 
 static void gic_enable_sre(void)
 {
 	u64 val;
 
-	asm volatile("mrs %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
+	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
 	val |= ICC_SRE_EL1_SRE;
-	asm volatile("msr " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
 	isb();
 
 	/*
@@ -150,7 +150,7 @@ static void gic_enable_sre(void)
 	 *
 	 * Kindly inform the luser.
 	 */
-	asm volatile("mrs %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
+	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
 	if (!(val & ICC_SRE_EL1_SRE))
 		pr_err("GIC: unable to set SRE (disabled@EL2), panic ahead\n");
 }
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 30cb7556d43f..03a4ea37ba86 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -18,6 +18,8 @@
 #ifndef __LINUX_IRQCHIP_ARM_GIC_V3_H
 #define __LINUX_IRQCHIP_ARM_GIC_V3_H
 
+#include <asm/sysreg.h>
+
 /*
  * Distributor registers. We assume we're running non-secure, with ARE
  * being set. Secure-only and non-ARE registers are not described.
@@ -125,17 +127,17 @@
 #define ICH_VMCR_PMR_SHIFT		24
 #define ICH_VMCR_PMR_MASK		(0xffUL << ICH_VMCR_PMR_SHIFT)
 
-#define ICC_EOIR1_EL1			S3_0_C12_C12_1
-#define ICC_IAR1_EL1			S3_0_C12_C12_0
-#define ICC_SGI1R_EL1			S3_0_C12_C11_5
-#define ICC_PMR_EL1			S3_0_C4_C6_0
-#define ICC_CTLR_EL1			S3_0_C12_C12_4
-#define ICC_SRE_EL1			S3_0_C12_C12_5
-#define ICC_GRPEN1_EL1			S3_0_C12_C12_7
+#define ICC_EOIR1_EL1			sys_reg(3, 0, 12, 12, 1)
+#define ICC_IAR1_EL1			sys_reg(3, 0, 12, 12, 0)
+#define ICC_SGI1R_EL1			sys_reg(3, 0, 12, 11, 5)
+#define ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
+#define ICC_CTLR_EL1			sys_reg(3, 0, 12, 12, 4)
+#define ICC_SRE_EL1			sys_reg(3, 0, 12, 12, 5)
+#define ICC_GRPEN1_EL1			sys_reg(3, 0, 12, 12, 7)
 
 #define ICC_IAR1_EL1_SPURIOUS		0x3ff
 
-#define ICC_SRE_EL2			S3_4_C12_C9_5
+#define ICC_SRE_EL2			sys_reg(3, 4, 12, 9, 5)
 
 #define ICC_SRE_EL2_SRE			(1 << 0)
 #define ICC_SRE_EL2_ENABLE		(1 << 3)
@@ -143,16 +145,16 @@
 /*
  * System register definitions
  */
-#define ICH_VSEIR_EL2			S3_4_C12_C9_4
-#define ICH_HCR_EL2			S3_4_C12_C11_0
-#define ICH_VTR_EL2			S3_4_C12_C11_1
-#define ICH_MISR_EL2			S3_4_C12_C11_2
-#define ICH_EISR_EL2			S3_4_C12_C11_3
-#define ICH_ELSR_EL2			S3_4_C12_C11_5
-#define ICH_VMCR_EL2			S3_4_C12_C11_7
+#define ICH_VSEIR_EL2			sys_reg(3, 4, 12, 9, 4)
+#define ICH_HCR_EL2			sys_reg(3, 4, 12, 11, 0)
+#define ICH_VTR_EL2			sys_reg(3, 4, 12, 11, 1)
+#define ICH_MISR_EL2			sys_reg(3, 4, 12, 11, 2)
+#define ICH_EISR_EL2			sys_reg(3, 4, 12, 11, 3)
+#define ICH_ELSR_EL2			sys_reg(3, 4, 12, 11, 5)
+#define ICH_VMCR_EL2			sys_reg(3, 4, 12, 11, 7)
 
-#define __LR0_EL2(x)			S3_4_C12_C12_ ## x
-#define __LR8_EL2(x)			S3_4_C12_C13_ ## x
+#define __LR0_EL2(x)			sys_reg(3, 4, 12, 12, x)
+#define __LR8_EL2(x)			sys_reg(3, 4, 12, 13, x)
 
 #define ICH_LR0_EL2			__LR0_EL2(0)
 #define ICH_LR1_EL2			__LR0_EL2(1)
@@ -171,13 +173,13 @@
 #define ICH_LR14_EL2			__LR8_EL2(6)
 #define ICH_LR15_EL2			__LR8_EL2(7)
 
-#define __AP0Rx_EL2(x)			S3_4_C12_C8_ ## x
+#define __AP0Rx_EL2(x)			sys_reg(3, 4, 12, 8, x)
 #define ICH_AP0R0_EL2			__AP0Rx_EL2(0)
 #define ICH_AP0R1_EL2			__AP0Rx_EL2(1)
 #define ICH_AP0R2_EL2			__AP0Rx_EL2(2)
 #define ICH_AP0R3_EL2			__AP0Rx_EL2(3)
 
-#define __AP1Rx_EL2(x)			S3_4_C12_C9_ ## x
+#define __AP1Rx_EL2(x)			sys_reg(3, 4, 12, 9, x)
 #define ICH_AP1R0_EL2			__AP1Rx_EL2(0)
 #define ICH_AP1R1_EL2			__AP1Rx_EL2(1)
 #define ICH_AP1R2_EL2			__AP1Rx_EL2(2)
@@ -189,7 +191,7 @@
 
 static inline void gic_write_eoir(u64 irq)
 {
-	asm volatile("msr " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" (irq));
+	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" (irq));
 	isb();
 }
 
