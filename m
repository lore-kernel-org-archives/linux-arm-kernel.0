From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  2 Apr 2015 18:41:47 +0300
Subject: [PATCH 3/3] mfd: ucb1x00: make use of provided irq
In-Reply-To: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1427989307-1805-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the platform data provides IRQ information, use that instead always
probing the IRQ.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/mfd/ucb1x00-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index cd4d39e..9b3c86b 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -465,9 +465,12 @@ static int ucb1x00_probe(struct mcp *mcp)
 	if (ret)
 		goto err_dev_add;
 
-	ucb1x00_enable(ucb);
-	ucb->irq = ucb1x00_detect_irq(ucb);
-	ucb1x00_disable(ucb);
+	ucb->irq = pdata ? pdata->irq : NO_IRQ;
+	if (ucb->irq == NO_IRQ) {
+		ucb1x00_enable(ucb);
+		ucb->irq = ucb1x00_detect_irq(ucb);
+		ucb1x00_disable(ucb);
+	}
 	if (ucb->irq == NO_IRQ) {
 		dev_err(&ucb->dev, "IRQ probe failed\n");
 		ret = -ENODEV;
-- 
2.1.4
