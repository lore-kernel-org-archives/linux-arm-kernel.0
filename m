From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:09 -0700
Subject: [PATCH 5/6] OMAP2+: PM: SmartReflex: use put_sync_suspend for
	IRQ-safe disabling
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Message-ID: <1312472710-31758-6-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@google.com>

omap_sr_disable_reset_volt is called with irqs off in omapx_enter_sleep,
as part of idle sequence, this eventually calls sr_disable and
pm_runtime_put_sync. pm_runtime_put_sync calls rpm_idle, which will
enable interrupts in order to call the callback. In this short interval
when interrupts are enabled, scenarios such as the following can occur:
while interrupts are enabled, the timer interrupt that is supposed to
wake the device out of idle occurs and is acked, so when the CPU finally
goes to off, the timer is already gone, missing a wakeup event.

Further, as the documentation for runtime states:"
 However, subsystems can use the pm_runtime_irq_safe() helper function
 to tell the PM core that a device's ->runtime_suspend() and ->runtime_resume()
 callbacks should be invoked in atomic context with interrupts disabled
 (->runtime_idle() is still invoked the default way)."

Hence, replace pm_runtime_put_sync with pm_runtime_put_sync_suspend
to invoke the suspend handler and shut off the fclk for SmartReflex
module instead of using the idle handler in interrupt disabled context.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Colin Cross <ccross@google.com>
[khilman at ti.com: minor Subject edits]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index dc8e86a..34c01a7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -621,7 +621,7 @@ void sr_disable(struct voltagedomain *voltdm)
 			sr_v2_disable(sr);
 	}
 
-	pm_runtime_put_sync(&sr->pdev->dev);
+	pm_runtime_put_sync_suspend(&sr->pdev->dev);
 }
 
 /**
-- 
1.7.6
