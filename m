From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:31 +0000
Subject: [RFC v3 PATCH 13/25] ARM: sleep: allow it to be build for R-class
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-14-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_resume_arm was guarded with CONFIG_MMU in 2678bb9fa13 (ARM: fix
EFM32 build breakage caused by cpu_resume_arm) in response to broken
build for EFM32 platform which has M-class cpu. It turned out that
this dependency on MMU is quite strict and prevent R-class from being
built.

The root cause of build breakage for M-class is that there is no ARM
instructions supported there. So instead of limiting cpu_resume_arm to
MMU only build, lets handle M-class case properly - keep in Thumb mode
and fall through to cpu_resume.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/sleep.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0f6c100..41b512d 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -119,7 +119,10 @@ ENDPROC(cpu_resume_after_mmu)
 	.text
 	.align
 
-#ifdef CONFIG_MMU
+#ifdef CONFIG_CPU_THUMBONLY
+	.thumb
+ENTRY(cpu_resume_arm)
+#else
 	.arm
 ENTRY(cpu_resume_arm)
  THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
@@ -159,10 +162,7 @@ THUMB(	ldmia	r0!, {r1, r2, r3}	)
 THUMB(	mov	sp, r2			)
 THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
-
-#ifdef CONFIG_MMU
 ENDPROC(cpu_resume_arm)
-#endif
 
 	.align 2
 _sleep_save_sp:
-- 
1.7.9.5
