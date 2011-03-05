From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:12 +0530
Subject: [PATCH V3 09/19] OMAP3+: SR: disable interrupt by default
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-10-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will enable and disable interrupt on a need basis in the class
driver. We need to keep the IRQ disabled by default else the
forceupdate or vcbypass events could trigger events that we don't
need/expect to handle.

This is a preparation for SmartReflex AVS class drivers such as
class 2 and class 1.5 which would need to use interrupts. Existing
SmartReflex AVS class 3 driver does not require to use interrupts
and is not impacted by this change.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7096300..f9057ad 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -267,6 +267,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 				0, name, (void *)sr_info);
 		if (ret)
 			goto error;
+		disable_irq(sr_info->irq);
 	}
 
 	if (pdata && pdata->enable_on_init)
-- 
1.7.1
