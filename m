From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:21 +0530
Subject: [PATCH 5/7 v2] net: ethernet: natsemi: Fix platform_get_irq's error
 checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-6-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/ethernet/natsemi/jazzsonic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index d5b2888..22424e9 100644
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
