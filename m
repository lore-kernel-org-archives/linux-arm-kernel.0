From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 May 2016 17:49:59 +0800
Subject: [PATCH 2/5] clocksource: rockchip: remove unnecessary clear irq
 before request_irq
In-Reply-To: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1464169802-6033-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

rk_timer_interrupt_clear and rk_timer_disable is unnecessary before
request_irq. Timer should keep disabled before booting Linux.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/clocksource/rockchip_timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index b991b28..b93fed6 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -158,9 +158,6 @@ static void __init rk_timer_init(struct device_node *np)
 	ce->cpumask = cpumask_of(0);
 	ce->rating = 250;
 
-	rk_timer_interrupt_clear(ce);
-	rk_timer_disable(ce);
-
 	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
 	if (ret) {
 		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
-- 
1.9.1
