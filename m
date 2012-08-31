From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 Aug 2012 09:52:54 +0200
Subject: [PATCH 1/2] i2c-omap: Fix incorrect adapter id when booting from a
 device tree
In-Reply-To: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch>
References: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1346399575-7285-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting from a device tree, the omap driver is using pdev->id,
which is incorrect. The proposed patch uses aliases, as done in
omap-serial.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/i2c/busses/i2c-omap.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d19a49..9445d1f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1064,9 +1064,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
-		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -1076,8 +1073,22 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
+	if (adap->dev.of_node)
+		adap->nr = of_alias_get_id(adap->dev.of_node, "i2c");
+	else
+		adap->nr = pdev->id;
+
+	if (adap->nr < 0) {
+		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
+				adap->nr);
+		r = -ENODEV;
+		goto err_free_irq;
+	}
+
+	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
+		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+
 	/* i2c device drivers may be active on return from add_adapter() */
-	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(dev->dev, "failure adding adapter\n");
-- 
1.7.5.4
