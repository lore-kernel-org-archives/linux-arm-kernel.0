From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 16 Jul 2015 14:29:38 -0700
Subject: [PATCH v4 2/2] arm: KVM: keep arm vfp/simd exit handling consistent
 with arm64
In-Reply-To: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
References: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1437082178-11039-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enhancing arm64 FP/SIMD exit handling, ARMv7 VFP exit branch is moved
to guest trap handling. This allows us to keep exit handling flow between both
architectures consistent.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/interrupts.S | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 79caf79..b245b4e 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -363,10 +363,6 @@ hyp_hvc:
 	@ Check syndrome register
 	mrc	p15, 4, r1, c5, c2, 0	@ HSR
 	lsr	r0, r1, #HSR_EC_SHIFT
-#ifdef CONFIG_VFPv3
-	cmp	r0, #HSR_EC_CP_0_13
-	beq	switch_to_guest_vfp
-#endif
 	cmp	r0, #HSR_EC_HVC
 	bne	guest_trap		@ Not HVC instr.
 
@@ -380,7 +376,10 @@ hyp_hvc:
 	cmp     r2, #0
 	bne	guest_trap		@ Guest called HVC
 
-host_switch_to_hyp:
+	/*
+	 * Getting here means host called HVC, we shift parameters and branch
+	 * to Hyp function.
+	 */
 	pop	{r0, r1, r2}
 
 	/* Check for __hyp_get_vectors */
@@ -411,6 +410,10 @@ guest_trap:
 
 	@ Check if we need the fault information
 	lsr	r1, r1, #HSR_EC_SHIFT
+#ifdef CONFIG_VFPv3
+	cmp	r1, #HSR_EC_CP_0_13
+	beq	switch_to_guest_vfp
+#endif
 	cmp	r1, #HSR_EC_IABT
 	mrceq	p15, 4, r2, c6, c0, 2	@ HIFAR
 	beq	2f
@@ -479,7 +482,6 @@ guest_trap:
  */
 #ifdef CONFIG_VFPv3
 switch_to_guest_vfp:
-	load_vcpu			@ Load VCPU pointer to r0
 	push	{r3-r7}
 
 	@ NEON/VFP used.  Turn on VFP access.
-- 
1.9.1
