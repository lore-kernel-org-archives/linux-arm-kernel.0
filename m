From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Mon,  8 Aug 2011 09:32:28 +0300
Subject: [PATCH] ARM errata: Possible cache data corruption with
	hit-under-miss enabled
Message-ID: <1312785148-32531-1-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch is a workaround for the 364296 ARM1136 r0pX erratum (possible
cache data corruption with hit-under-miss enabled). It sets the
undocumented bit 31 in the auxiliary control register and the FI bit in
the control register, thus disabling hit-under-miss without putting the
processor into full low interrupt latency mode.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/Kconfig      |   12 ++++++++++++
 arch/arm/mm/proc-v6.S |   16 ++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9c26ba7..0c3a56c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1115,6 +1115,18 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption of the
 	  processor.
 
+config ARM_ERRATA_364296
+	bool "ARM errata: Possible cache data corruption with hit-under-miss enabled"
+	depends on CPU_V6 && !SMP
+	help
+	  This options enables the workaround for the 364296 ARM1136
+	  r0pX erratum (possible cache data corruption with
+	  hit-under-miss enabled). It sets the undocumented bit 31 in
+	  the auxiliary control register and the FI bit in the control
+	  register, thus disabling hit-under-miss without putting the
+	  processor into full low interrupt latency mode. ARM11MPCore
+	  is not affected.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 22aac85..1b675b1 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -180,6 +180,22 @@ __v6_setup:
 	mrc	p15, 0, r0, c1, c0, 0		@ read control register
 	bic	r0, r0, r5			@ clear bits them
 	orr	r0, r0, r6			@ set them
+#ifdef CONFIG_ARM_ERRATA_364296
+	/* Workaround for the 364296 ARM1136 r0pX erratum (possible cache data
+	 * corruption with hit-under-miss enabled). The conditional code below
+	 * (setting the undocumented bit 31 in the auxiliary control register
+	 * and the FI bit in the control register) disables hit-under-miss
+	 * without putting the processor into full low interrupt latency mode.
+	 */
+	ldr	r6, =0x4107b360			@ id for ARM1136 r0pX
+	mrc	p15, 0, r5, c0, c0, 0		@ get processor id
+	bic	r5, r5, #0xf			@ mask out part bits [3:0]
+	teq	r5, r6				@ check for the faulty core
+	mrceq	p15, 0, r5, c1, c0, 1		@ load aux control reg
+	orreq	r5, r5, #(1 << 31)		@ set the undocumented bit 31
+	mcreq	p15, 0, r5, c1, c0, 1		@ write aux control reg
+	orreq	r0, r0, #(1 << 21)		@ low interrupt latency configuration
+#endif
 	mov	pc, lr				@ return to head.S:__ret
 
 	/*
-- 
1.7.2.5
