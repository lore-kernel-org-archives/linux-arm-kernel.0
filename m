From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 13 Aug 2016 10:45:45 +0100
Subject: [PATCH RFC] Revert "of/irq: Mark initialised interrupt controllers as
 populated"
Message-ID: <E1bYVVh-0001eq-BI@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 15cc2ed6dcf91a8658e084be4e140147161819d7, which
causes a regression with iMX6 power domains.  iMX6 GPC contains both an
interrupt controller and power domains.  The iMX6 GPC code is setup to
register an interrupt controller using IRQCHIP_DECLARE(), but then to
register the power domains using the platform device.

This commit prevents the platform device being created, thereby breaking
iMX6 power domain support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Please argue amongst yourselves about how to fix this regression caused
by this commit...

Marc introduced the code which used OF_DECLARE_2()/IRQCHIP_DECLARE() in

	commit b923ff6af0d5a806a3996dac6d4393cd9792d0f4
	Author: Marc Zyngier <marc.zyngier@arm.com>
	Date:   Mon Feb 23 17:45:18 2015 +0000

while the PM domain code was introduced at around the same time by:

	commit 00eb60a8b4f7a4aa00fd8abd68c2dc7aec55df19
	Author: Philipp Zabel <p.zabel@pengutronix.de>
	Date:   Mon Feb 23 18:40:12 2015 +0100

I guess distributed development is fun!

 drivers/of/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 89a71c6074fc..7d3f93fdc4ad 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -559,8 +559,6 @@ void __init of_irq_init(const struct of_device_id *matches)
 			 * its children can get processed in a subsequent pass.
 			 */
 			list_add_tail(&desc->list, &intc_parent_list);
-
-			of_node_set_flag(desc->dev, OF_POPULATED);
 		}
 
 		/* Get the next pending parent that might have children */
-- 
2.1.0
