From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Dec 2014 11:02:09 +0000
Subject: [PATCH] clocksource: arch_timer: Only use the virtual counter
 (CNTVCT) on arm64
Message-ID: <1418209329-28615-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0b46b8a718c6 (clocksource: arch_timer: Fix code to use physical
timers when requested) introduces the use of physical counters in the
ARM architected timer driver. However, he arm64 kernel uses CNTVCT in
VDSO. When booting in EL2, the kernel switches to the physical timers to
make things easier for KVM but it continues to use the virtual counter
both in user and kernel. While in such scenario CNTVCT == CNTPCT (since
CNTVOFF is initialised by the kernel to 0), we want to spot firmware
bugs corrupting CNTVOFF early (which would affect CNTVCT).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---

Daniel,

Do you plan to take this patch and push into mainline (ideally before -rc1)?
Otherwise we can push it via the arm64 tree.

Thanks,

Catalin


 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6a79fc4f900c..095c1774592c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -462,7 +462,7 @@ static void __init arch_counter_register(unsigned type)
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_CP15_TIMER) {
-		if (arch_timer_use_virtual)
+		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_use_virtual)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
