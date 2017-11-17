From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:58:18 +0530
Subject: [PATCH 2/6] mmc: s3cmci: Fix platform_get_irq's error checking
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510950502-22565-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/s3cmci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f7f157a..cc801bc 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1658,9 +1658,9 @@ static int s3cmci_probe(struct platform_device *pdev)
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq == 0) {
+	if (host->irq < 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
-		ret = -EINVAL;
+		ret = host->irq;
 		goto probe_iounmap;
 	}
 
-- 
2.7.4
