From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat,  5 Nov 2011 10:41:27 +0000
Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+ processors
Message-ID: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent gcc versions generate unaligned accesses by default on ARMv6 and
later processors. This patch ensures that the SCTLR.A bit is always
cleared on such processors to avoid kernel traping before
alignment_init() is called.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: John Linn <John.Linn@xilinx.com>
---
 arch/arm/kernel/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index a400a4d..1768db2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -394,7 +394,7 @@ __secondary_data:
  *  r13 = *virtual* address to jump to upon completion
  */
 __enable_mmu:
-#ifdef CONFIG_ALIGNMENT_TRAP
+#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
 	orr	r0, r0, #CR_A
 #else
 	bic	r0, r0, #CR_A
