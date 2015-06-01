From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  1 Jun 2015 13:22:00 -0700
Subject: [PATCH] ARM: Enter CPU in ARM state for cpu_resume
Message-ID: <1433190120-27798-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The standard boot protocol on ARM requires CPUs to be entered in
the ARM state, unless they don't support the ARM instruction set
(see Documentation/arm/Booting). On THUMB2 kernels, we assume
the firmware can determine what state to enter the kernel in, but
some firmwares don't honor the thumb bit. Make the cpu_resume
symbol an ARM symbol, so that firmwares that honor the thumb bit
will enter the kernel in ARM state and firmwares that don't honor
the thumb bit will be able to enter the kernel in ARM state
without more changes.

This fixes a problem reported by Kevin Hilman where the ifc6410 
fails to boot for THUMB2 kernels because the platform's firmware
always enters the kernel in ARM mode from deep idle states.

Reported-by: Kevin Hilman <khilman@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/sleep.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 76bb3128e135..7c289ebb0b45 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -118,7 +118,12 @@ ENDPROC(cpu_resume_after_mmu)
 
 	.text
 	.align
+	.arm
 ENTRY(cpu_resume)
+ THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)
 ARM_BE8(setend be)			@ ensure we are in BE mode
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install_secondary
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
