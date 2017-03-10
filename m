From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 10 Mar 2017 11:46:23 +0000
Subject: [PATCH 3.16 229/370] clocksource/exynos_mct: Clear interrupt when
 cpu is shut down
In-Reply-To: <lsq.1489146380.780052105@decadent.org.uk>
Message-ID: <lsq.1489146383.332922970@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.16.42-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joonyoung Shim <jy0922.shim@samsung.com>

commit bc7c36eedb0c7004aa06c2afc3c5385adada8fa3 upstream.

When a CPU goes offline a potentially pending timer interrupt is not
cleared. When the CPU comes online again then the pending interrupt is
delivered before the per cpu clockevent device is initialized. As a
consequence the tick interrupt handler dereferences a NULL pointer.

[   51.251378] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[   51.289348] task: ee942d00 task.stack: ee960000
[   51.293861] PC is at tick_periodic+0x38/0xb0
[   51.298102] LR is at tick_handle_periodic+0x1c/0x90

Clear the pending interrupt in the cpu dying path.

Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Cc: cw00.choi at samsung.com
Cc: daniel.lezcano at linaro.org
Cc: javier at osg.samsung.com
Cc: kgene at kernel.org
Cc: krzk at kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1484628876-22065-1-git-send-email-jy0922.shim at samsung.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16: add definition of the 'mevt' variable, added earlier
 upstream]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -458,10 +458,15 @@ static int exynos4_local_timer_setup(str
 
 static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
+	struct mct_clock_event_device *mevt;
+
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
+
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
 	} else {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
