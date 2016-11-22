From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:04 +0000
Subject: [RFC PATCH 07/11] ARM: sleep: allow it to be build for R-class
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dependency on MMU is quite strict and prevent R-class from being built -
relax this condition and guard against M-class only

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig        |    2 +-
 arch/arm/kernel/sleep.S |    4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49e0f01..f9ff570 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2179,7 +2179,7 @@ config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
 config ARM_CPU_SUSPEND
-	def_bool PM_SLEEP || BL_SWITCHER || ARM_PSCI_FW
+	def_bool (PM_SLEEP || BL_SWITCHER || ARM_PSCI_FW) && !CPU_V7M
 	depends on ARCH_SUSPEND_POSSIBLE
 
 config ARCH_HIBERNATION_POSSIBLE
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0f6c100..0e7fddf 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -119,14 +119,12 @@ ENDPROC(cpu_resume_after_mmu)
 	.text
 	.align
 
-#ifdef CONFIG_MMU
 	.arm
 ENTRY(cpu_resume_arm)
  THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
  THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
  THUMB(	.thumb			)	@ switch to Thumb now.
  THUMB(1:			)
-#endif
 
 ENTRY(cpu_resume)
 ARM_BE8(setend be)			@ ensure we are in BE mode
@@ -160,9 +158,7 @@ THUMB(	mov	sp, r2			)
 THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
 
-#ifdef CONFIG_MMU
 ENDPROC(cpu_resume_arm)
-#endif
 
 	.align 2
 _sleep_save_sp:
-- 
1.7.9.5
