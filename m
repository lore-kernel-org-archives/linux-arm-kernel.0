From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun, 19 Nov 2017 10:04:01 +0530
Subject: [PATCH 2/2 v3] misc: atmel-ssc: Fix platform_get_irq's error checking
In-Reply-To: <3ce95a4e4eb4476b19868f36cd1f11e4b62b6203.1511065797.git.arvind.yadav.cs@gmail.com>
References: <3ce95a4e4eb4476b19868f36cd1f11e4b62b6203.1511065797.git.arvind.yadav.cs@gmail.com>
Message-ID: <fbe464e8bd8039463c4984835286b19060509f82.1511065797.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.
changes in v3:
              Return -ENODEV instead of ssc->irq.

 drivers/misc/atmel-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index b2a0340..2ec0f9e 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -235,7 +235,7 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq <= 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
 		return -ENXIO;
 	}
-- 
2.7.4
