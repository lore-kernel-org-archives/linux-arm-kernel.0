From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 29 Mar 2012 15:31:56 +0530
Subject: [PATCH v3 3/4] drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq()
 in ams_delta_serio_exit()
In-Reply-To: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
References: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1333015317-11866-4-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though ams-delta-serio input driver uses gpio_to_irq() in all
relevent places to get irq number, the ams_delta_serio_exit() still
uses OMAP_GPIO_IRQ macro. Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/input/serio/ams_delta_serio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index d4d08bd..dbe1ae8 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -170,7 +170,7 @@ module_init(ams_delta_serio_init);
 static void __exit ams_delta_serio_exit(void)
 {
 	serio_unregister_port(ams_delta_serio);
-	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
+	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
 }
-- 
1.7.0.4
