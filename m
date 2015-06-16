From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 16 Jun 2015 14:50:52 -0700
Subject: [PATCH v2 2/2] arm: KVM: keep arm vfp/simd exit handling consistent
 with arm64
In-Reply-To: <1434491452-19177-1-git-send-email-m.smarduch@samsung.com>
References: <1434491452-19177-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1434491452-19177-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enhancing arm64 FP/SIMD exit handling, FP/SIMD exit branch is moved
to guest trap handling. This keeps exiting handling flow between both
architectures consistent.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/interrupts.S |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 79caf79..fca2c56 100644
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
 
@@ -406,6 +402,12 @@ THUMB(	orr	lr, #1)
 1:	eret
 
 guest_trap:
+#ifdef CONFIG_VFPv3
+	/* Guest accessed VFP/SIMD registers, save host, restore Guest */
+	cmp	r0, #HSR_EC_CP_0_13
+	beq	switch_to_guest_fpsimd
+#endif
+
 	load_vcpu			@ Load VCPU pointer to r0
 	str	r1, [vcpu, #VCPU_HSR]
 
@@ -478,7 +480,7 @@ guest_trap:
  * inject an undefined exception to the guest.
  */
 #ifdef CONFIG_VFPv3
-switch_to_guest_vfp:
+switch_to_guest_fpsimd:
 	load_vcpu			@ Load VCPU pointer to r0
 	push	{r3-r7}
 
-- 
1.7.9.5
