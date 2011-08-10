From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Aug 2011 11:26:46 +0100
Subject: [PATCH 1/1] ARM errata: Possible cache data corruption with hit-under-miss enabled
Message-ID: <mailman.61.1312972314.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a workaround for the 364296 ARM1136 r0p2 erratum (possible
cache data corruption with hit-under-miss enabled). It sets the
undocumented bit 31 in the auxiliary control register and the FI bit in
the control register, thus disabling hit-under-miss without putting the
processor into full low interrupt latency mode.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig      |   12 ++++++++++++
 arch/arm/mm/proc-v6.S |   16 ++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c71a8f..30335e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1272,6 +1272,18 @@ config ARM_ERRATA_754327
 	  This workaround defines cpu_relax() as smp_mb(), preventing correctly
 	  written polling loops from denying visibility of updates to memory.
 
+config ARM_ERRATA_364296
+	bool "ARM errata: Possible cache data corruption with hit-under-miss enabled"
+	depends on CPU_V6 && !SMP
+	help
+	  This options enables the workaround for the 364296 ARM1136
+	  r0p2 erratum (possible cache data corruption with
+	  hit-under-miss enabled). It sets the undocumented bit 31 in
+	  the auxiliary control register and the FI bit in the control
+	  register, thus disabling hit-under-miss without putting the
+	  processor into full low interrupt latency mode. ARM11MPCore
+	  is not affected.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 219138d..a923aa0 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -223,6 +223,22 @@ __v6_setup:
 	mrc	p15, 0, r0, c1, c0, 0		@ read control register
 	bic	r0, r0, r5			@ clear bits them
 	orr	r0, r0, r6			@ set them
+#ifdef CONFIG_ARM_ERRATA_364296
+	/*
+	 * Workaround for the 364296 ARM1136 r0p2 erratum (possible cache data
+	 * corruption with hit-under-miss enabled). The conditional code below
+	 * (setting the undocumented bit 31 in the auxiliary control register
+	 * and the FI bit in the control register) disables hit-under-miss
+	 * without putting the processor into full low interrupt latency mode.
+	 */
+	ldr	r6, =0x4107b362			@ id for ARM1136 r0p2
+	mrc	p15, 0, r5, c0, c0, 0		@ get processor id
+	teq	r5, r6				@ check for the faulty core
+	mrceq	p15, 0, r5, c1, c0, 1		@ load aux control reg
+	orreq	r5, r5, #(1 << 31)		@ set the undocumented bit 31
+	mcreq	p15, 0, r5, c1, c0, 1		@ write aux control reg
+	orreq	r0, r0, #(1 << 21)		@ low interrupt latency configuration
+#endif
 	mov	pc, lr				@ return to head.S:__ret
 
 	/*

-- 
Catalin
