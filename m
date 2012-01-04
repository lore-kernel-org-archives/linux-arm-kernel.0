From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed,  4 Jan 2012 17:04:12 +0000
Subject: [PATCH] ARM: LPAE: Check the CPU support for the long descriptor
 format
Message-ID: <1325696652-27367-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a check for the presence of the LPAE feature during the
CPU initialisation. If not present, it reports an error when
CONFIG_DEBUG_LL is enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/head.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 54fa641..b26291c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -99,6 +99,14 @@ ENTRY(stext)
  THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p			@ yes, error 'p'
 
+#ifdef CONFIG_ARM_LPAE
+	mrc	p15, 0, r3, c0, c1, 4		@ read ID_MMFR0
+	and	r3, r3, #0xf			@ extract VMSA support
+	cmp	r3, #5				@ long-descriptor translation table format?
+ THUMB( it	lo )				@ force fixup-able long branch encoding
+	blo	__error_p			@ only classic page table format
+#endif
+
 #ifndef CONFIG_XIP_KERNEL
 	adr	r3, 2f
 	ldmia	r3, {r4, r8}
