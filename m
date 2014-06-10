From: kamal@canonical.com (Kamal Mostafa)
Date: Tue, 10 Jun 2014 12:45:09 -0700
Subject: [PATCH 3.13 069/160] clocksource: Exynos_mct: Register clock event
 after request_irq()
In-Reply-To: <1402429600-20477-1-git-send-email-kamal@canonical.com>
References: <1402429600-20477-1-git-send-email-kamal@canonical.com>
Message-ID: <1402429600-20477-70-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.13.11.3 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

commit 8db6e5104b77de5d0b7002b95069da0992a34be9 upstream.

After hotplugging CPU1 the first call of interrupt handler for CPU1
oneshot timer was called on CPU0 because it fired before setting IRQ
affinity. Affected are SoCs where Multi Core Timer interrupts are
shared (SPI), e.g. Exynos 4210.

During setup of the MCT timers the clock event device should be
registered after setting the affinity for interrupt. This will prevent
starting the timer too early.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>,
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org,
Link: http://lkml.kernel.org/r/20140416143316.299247848 at linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/clocksource/exynos_mct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index b17b3e0..70f3a59 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -414,8 +414,6 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	evt->set_mode = exynos4_tick_set_mode;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = 450;
-	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-					0xf, 0x7fffffff);
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
@@ -432,6 +430,8 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
+	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
+					0xf, 0x7fffffff);
 
 	return 0;
 }
-- 
1.9.1
