From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Tue, 17 May 2011 16:04:34 -0700
Subject: [PATCH] ARM: bcmring: fix patches to convert to sp804
 clockevents
In-Reply-To: <E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
Message-ID: <4DD2FF02.1020508@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build and boot problem with original patches to convert bcmring
to use sp804 clockevents.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
  arch/arm/mach-bcmring/core.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index c323ae9..299c275 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -191,8 +191,6 @@ void __init bcmring_amba_init(void)

  	chipcHw_busInterfaceClockEnable(bus_clock);

-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
  	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
  		struct amba_device *d = amba_devs[i];
  		amba_device_register(d, &iomem_resource);
@@ -232,12 +230,14 @@ void __init bcmring_init_timer(void)
  	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
  	writel(0, TIMER3_VA_BASE + TIMER_CTRL);

+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
  	/*
  	 * Make irqs happen for the system timer
  	 */
  	bcmring_clocksource_init();

-	sp804_clockevents_register(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
  }

  struct sys_timer bcmring_timer = {
-- 
1.7.4.1
