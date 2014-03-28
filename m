From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 28 Mar 2014 14:06:02 +0100
Subject: [PATCH 3/3] clocksource: exynos_mct: Fix too early ISR fire up on
 wrong CPU
In-Reply-To: <1396011962-4467-1-git-send-email-k.kozlowski@samsung.com>
References: <1396011962-4467-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1396011962-4467-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After hotplugging CPU1 the first call of interrupt handler for CPU1
oneshot timer was called on CPU0 because it fired up before setting IRQ
affinity. Affected are SoCs where Multi Core Timer interrupts are shared
(SPI), e.g. Exynos 4210.

During setup of the MCT timers the clock event device should be
registered after setting the affinity for interrupt. This will prevent
starting the timer too early.

Additionally, if clock event device has interrupt set up, the
clockevents_config_and_register() will also set the affinity for it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
---
 drivers/clocksource/exynos_mct.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 2ac7d228743a..f9c9a1d41f2a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -418,8 +418,6 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	evt->set_mode = exynos4_tick_set_mode;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = 450;
-	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-					0xf, 0x7fffffff);
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
@@ -435,6 +433,8 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
+	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
+					0xf, 0x7fffffff);
 
 	return 0;
 }
-- 
1.7.9.5
