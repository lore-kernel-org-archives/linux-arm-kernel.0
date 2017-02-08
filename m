From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  9 Feb 2017 00:14:42 +0100
Subject: [PATCH 08/10] clocksource/drivers/arm_arch_timer: Remove fsl-a008585
 parameter
In-Reply-To: <1486595685-10232-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170208231208.GB12695@mai>
 <1486595685-10232-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1486595685-10232-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

Having a command line option to flip the errata handling for a
particular erratum is a little bit unusual, and it's vastly superior to
pass this in the DT. By common consensus, it's best to kill off the
command line parameter.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
[Mark: split patch, reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ---------
 drivers/clocksource/arm_arch_timer.c            | 14 --------------
 2 files changed, 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index be7c0d9..d8fc55a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -549,15 +549,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.arm_arch_timer.fsl-a008585=
-			[ARM64]
-			Format: <bool>
-			Enable/disable the workaround of Freescale/NXP
-			erratum A-008585.  This can be useful for KVM
-			guests, if the guest device tree doesn't show the
-			erratum.  If unspecified, the workaround is
-			enabled based on the device tree.
-
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4c8c3fb..6a9d031 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -101,20 +101,6 @@ EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
 static int fsl_a008585_enable = -1;
 
-static int __init early_fsl_a008585_cfg(char *buf)
-{
-	int ret;
-	bool val;
-
-	ret = strtobool(buf, &val);
-	if (ret)
-		return ret;
-
-	fsl_a008585_enable = val;
-	return 0;
-}
-early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
-
 u32 __fsl_a008585_read_cntp_tval_el0(void)
 {
 	return __fsl_a008585_read_reg(cntp_tval_el0);
-- 
2.7.4
