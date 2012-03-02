From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Mar 2012 17:50:23 +0100
Subject: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect IRQ
 for board setup
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330707024-23730-12-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Card detect IRQ from the TWL6030 used to be provided to the MMC
controller code using a statically allocated IRQ scheme:

  card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;

This is no longer valid in a SPARSE_IRQ context since there is no more
pre-defined TWL6030_IRQ_BASE.

Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
that will be called from the MMC controller.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 drivers/mfd/twl6030-irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index a1c7183..4a63de2 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -308,7 +308,8 @@ int twl6030_mmc_card_detect_config(void)
 									ret);
 		return ret;
 	}
-	return 0;
+
+	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
 }
 EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
 
-- 
1.7.0.4
