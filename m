From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  2 Jun 2015 12:12:57 -0700
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that resume in
 ARM state
In-Reply-To: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms always enter the kernel in the ARM state even if
the kernel is compiled for THUMB2. Add a small wrapper on top of
cpu_resume() that switches into THUMB2 state.

This fixes a problem reported by Kevin Hilman on next-20150601
where the ifc6410 fails to boot a THUMB2 kernel because the
platform's firmware always enters the kernel in ARM mode from
deep idle states.

Reported-by: Kevin Hilman <khilman@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/suspend.h | 1 +
 arch/arm/kernel/sleep.S        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index cd20029bcd94..6c7182f32cef 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -7,6 +7,7 @@ struct sleep_save_sp {
 };
 
 extern void cpu_resume(void);
+extern void cpu_resume_arm(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
 #endif
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 76bb3128e135..f37593567ef5 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -118,6 +118,12 @@ ENDPROC(cpu_resume_after_mmu)
 
 	.text
 	.align
+	.arm
+ENTRY(cpu_resume_arm)
+ THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)
 ENTRY(cpu_resume)
 ARM_BE8(setend be)			@ ensure we are in BE mode
 #ifdef CONFIG_ARM_VIRT_EXT
@@ -149,6 +155,7 @@ THUMB(	ldmia	r0!, {r1, r2, r3}	)
 THUMB(	mov	sp, r2			)
 THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
+ENDPROC(cpu_resume_arm)
 
 	.align 2
 _sleep_save_sp:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
