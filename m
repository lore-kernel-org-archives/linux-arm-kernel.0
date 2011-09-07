From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  7 Sep 2011 17:00:53 +0100
Subject: [PATCH] ARM: tegra: Remove redundant change to the CPSR in headsmp.S
Message-ID: <1315411253-17559-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At secondary_startup, the MSR CPSR_cxsf, #0xd3 is not compatible
with Thumb-2 and also unmasks asynchronous aborts (CPSR.A bit
forced to zero -- this is probably unintentional).

Any remotely sane bootloader should be putting each secondary CPU
in the appropriate state _before_ entering the kernel anyway.
Otherwise, disabling interrupts on entry to the kernel isn't going
to fix it.

Therefore this patch just removes the MSR instruction.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

I make assumptions about the bootloader in this patch.  If someone with
Tegra knowledge can please comment and/or test, that would be much
appreciated, thanks.

 arch/arm/mach-tegra/headsmp.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index b5349b2..6ec4790 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -48,7 +48,6 @@ ENTRY(v7_invalidate_l1)
 ENDPROC(v7_invalidate_l1)
 
 ENTRY(tegra_secondary_startup)
-	msr	cpsr_fsxc, #0xd3
         bl      v7_invalidate_l1
 	mrc	p15, 0, r0, c0, c0, 5
         and	r0, r0, #15
-- 
1.7.4.1
