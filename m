From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Feb 2011 00:00:54 -0500 (EST)
Subject: fixes to the p2v series
Message-ID: <alpine.LFD.2.00.1102012335240.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Revisiting this series I found some minor issues. You might want to fold 
in those fixes as appropriate:

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 17a97b5..9b1d2bd 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -494,7 +494,7 @@ __fixup_a_pv_table:
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
 	bcc	2b
 	mov	pc, lr
-ENDPROC(__fixup_phys_virt)
+ENDPROC(__fixup_a_pv_table)
 
 ENTRY(fixup_pv_table)
 	stmfd	sp!, {r4 - r7, lr}

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 3cf47d5..a2b775b 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -30,8 +30,8 @@ struct mod_arch_specific {
 #define MODULE_ARCH_VERMAGIC_ARMVSN "ARMv" __stringify(__LINUX_ARM_ARCH__) " "
 
 /* Add __virt_to_phys patching state as well */
-#ifdef ARM_PATCH_PHYS_VIRT
-#ifdef ARM_PATCH_PHYS_VIRT_16BIT
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
 #define MODULE_ARCH_VERMAGIC_P2V "p2v16 "
 #else
 #define MODULE_ARCH_VERMAGIC_P2V "p2v8 "

Nicolas
