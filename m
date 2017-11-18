From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 11:14:27 +0530
Subject: [PATCH 2/2] misc: atmel-ssc: Fix platform_get_irq's error checking
In-Reply-To: <1510983867-2344-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510983867-2344-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510983867-2344-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/misc/atmel-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index b2a0340..9d9eeae 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -235,9 +235,9 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		return ssc->irq;
 	}
 
 	spin_lock(&user_lock);
-- 
2.7.4
