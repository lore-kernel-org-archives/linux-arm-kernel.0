From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 22:41:50 +0800
Subject: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert driver to use devm_*() APIs so rely on driver model core layer
to manage resources. This eliminates error path boilerplate and makes
code neat.

This patch also fixes the memory leakage for 'kmi->io' when remove
module.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/input/serio/ambakmi.c | 44 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index c6606ca..d4814be 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -112,19 +112,11 @@ static int amba_kmi_probe(struct amba_device *dev,
 {
 	struct amba_kmi_port *kmi;
 	struct serio *io;
-	int ret;
-
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
-	kmi = kzalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
-	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!kmi || !io) {
-		ret = -ENOMEM;
-		goto out;
-	}
 
+	kmi = devm_kzalloc(&dev->dev, sizeof(*kmi), GFP_KERNEL);
+	io  = devm_kzalloc(&dev->dev, sizeof(*io), GFP_KERNEL);
+	if (!kmi || !io)
+		return -ENOMEM;
 
 	io->id.type	= SERIO_8042;
 	io->write	= amba_kmi_write;
@@ -136,31 +128,19 @@ static int amba_kmi_probe(struct amba_device *dev,
 	io->dev.parent	= &dev->dev;
 
 	kmi->io		= io;
-	kmi->base	= ioremap(dev->res.start, resource_size(&dev->res));
-	if (!kmi->base) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	kmi->base	= devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(kmi->base))
+		return PTR_ERR(kmi->base);
 
-	kmi->clk = clk_get(&dev->dev, "KMIREFCLK");
-	if (IS_ERR(kmi->clk)) {
-		ret = PTR_ERR(kmi->clk);
-		goto unmap;
-	}
+	kmi->clk = devm_clk_get(&dev->dev, "KMIREFCLK");
+	if (IS_ERR(kmi->clk))
+		return PTR_ERR(kmi->clk);
 
 	kmi->irq = dev->irq[0];
 	amba_set_drvdata(dev, kmi);
 
 	serio_register_port(kmi->io);
 	return 0;
-
- unmap:
-	iounmap(kmi->base);
- out:
-	kfree(kmi);
-	kfree(io);
-	amba_release_regions(dev);
-	return ret;
 }
 
 static int amba_kmi_remove(struct amba_device *dev)
@@ -168,10 +148,6 @@ static int amba_kmi_remove(struct amba_device *dev)
 	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
 
 	serio_unregister_port(kmi->io);
-	clk_put(kmi->clk);
-	iounmap(kmi->base);
-	kfree(kmi);
-	amba_release_regions(dev);
 	return 0;
 }
 
-- 
2.7.4
