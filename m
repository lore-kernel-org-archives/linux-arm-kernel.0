From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 15 Nov 2016 21:13:27 +0800
Subject: [PATCH v15 05/13] clocksource/drivers/arm_arch_timer: fix a bug in
 arch_timer_register about arch_timer_uses_ppi
In-Reply-To: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
References: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1479215615-26950-6-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch fix a potential bug about arch_timer_uses_ppi in
arch_timer_register.
On ARM64, we don't use ARCH_TIMER_PHYS_SECURE_PPI in Linux, so we will
just igorne it in init code. If arch_timer_uses_ppi is
ARCH_TIMER_PHYS_NONSECURE_PPI, the orignal code of
arch_timer_uses_ppi may go wrong.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index dd1040d..6de164f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -699,7 +699,7 @@ static int __init arch_timer_register(void)
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
-- 
2.7.4
