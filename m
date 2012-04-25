From: neilb@suse.de (NeilBrown)
Date: Wed, 25 Apr 2012 13:05:24 +1000
Subject: [PATCH 3/3] twl4030: enable wakeup on twl4030 IRQ.
In-Reply-To: <20120425025637.7832.14013.stgit@notabene.brown>
References: <20120425025637.7832.14013.stgit@notabene.brown>
Message-ID: <20120425030524.7832.66013.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the interrupts that come through this line should trigger
wakeups:
  power button
  RTC alarm
  power available
  usb plug/unplug

so mark the interrupt as a wakeup interrupt.
This is particularly important for when the interrupt arrives during
the late suspend phase.  Without this setting it will be ignored.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/mfd/twl4030-irq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 5d656e8..ad733d7 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -757,6 +757,7 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 		dev_err(dev, "could not claim irq%d: %d\n", irq_num, status);
 		goto fail_rqirq;
 	}
+	enable_irq_wake(irq_num);
 
 	return irq_base;
 fail_rqirq:
