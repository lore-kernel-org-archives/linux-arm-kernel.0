From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 30 Nov 2016 10:53:51 -0600
Subject: [PATCH v2] soc: ti: qmss: fix the case when !SMP
Message-ID: <20161130165351.1154-1-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_set_affinity_hint() will always fail when !SMP and
Networking will fail on Keystone 2 devices in this case.
Hence, fix by ignoring IRQ affinity settings when !SMP.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index b73e353..eacad57 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1228,7 +1228,7 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 
 		range->num_irqs++;
 
-		if (oirq.args_count == 3)
+		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3)
 			range->irqs[i].cpu_map =
 				(oirq.args[2] & 0x0000ff00) >> 8;
 	}
-- 
2.10.1
