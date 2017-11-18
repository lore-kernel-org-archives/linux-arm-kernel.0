From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 14:40:13 +0530
Subject: [PATCH 2/2 v2] misc: atmel-ssc: Fix platform_get_irq's error checking
In-Reply-To: <6e238a28aa79c581c90329060805c0b07e2187a7.1510995185.git.arvind.yadav.cs@gmail.com>
References: <6e238a28aa79c581c90329060805c0b07e2187a7.1510995185.git.arvind.yadav.cs@gmail.com>
Message-ID: <03c6f3e9df6d3077717e1f14b4775f2864a0304a.1510995185.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.

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
+	if (ssc->irq <= 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		return ssc->irq;
 	}
 
 	spin_lock(&user_lock);
-- 
2.7.4
