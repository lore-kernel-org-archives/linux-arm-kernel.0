From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:18 +0530
Subject: [PATCH 06/10] net: ethernet: natsemi: Handle return value of
 platform_get_irq
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-7-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/natsemi/jazzsonic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index d5b2888..3cf0856 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -242,6 +242,11 @@ static int jazz_sonic_probe(struct platform_device *pdev)
 
 	dev->base_addr = res->start;
 	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq <= 0) {
+		err = dev->irq ? dev->irq : -ENODEV;
+		goto out;
+	}
+
 	err = sonic_probe1(dev);
 	if (err)
 		goto out;
-- 
2.7.4
