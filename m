From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 19 Jul 2012 00:04:09 +0200
Subject: [PATCH] ARM: Orion: fix driver probe error handling with respect to
 clk
Message-ID: <1342649049-3956-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk patches added code to get and enable clocks in the
respective driver probe functions.  If the probe function failed
for some reason after enabling the clock, the clock was not
disabled again in many cases.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---

Hi,

some hopefully obvious fixes to driver probe cleanup code. Patch
is based on v3.5-rc7.  Let me know if you prefer a series of per
driver patches instead.

- Simon

 drivers/crypto/mv_cesa.c                   |    4 ++++
 drivers/mmc/host/mvsdio.c                  |    4 ++++
 drivers/mtd/nand/orion_nand.c              |    4 ++++
 drivers/net/ethernet/marvell/mv643xx_eth.c |    4 ++++
 drivers/usb/host/ehci-orion.c              |    4 ++++
 sound/soc/kirkwood/kirkwood-i2s.c          |    8 +++++++-
 6 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
index 1cc6b3f..a4faa893 100644
--- a/drivers/crypto/mv_cesa.c
+++ b/drivers/crypto/mv_cesa.c
@@ -1098,6 +1098,10 @@ err_unreg_ecb:
 	crypto_unregister_alg(&mv_aes_alg_ecb);
 err_irq:
 	free_irq(irq, cp);
+	if (!IS_ERR(cp->clk)) {
+		clk_disable_unprepare(cp->clk);
+		clk_put(cp->clk);
+	}
 err_thread:
 	kthread_stop(cp->queue_th);
 err_unmap_sram:
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 3b9136c..a61cb5f 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -839,6 +839,10 @@ out:
 	if (r)
 		release_resource(r);
 	if (mmc)
+		if (!IS_ERR_OR_NULL(host->clk)) {
+			clk_disable_unprepare(host->clk);
+			clk_put(host->clk);
+		}
 		mmc_free_host(mmc);
 
 	return ret;
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 513dc88..9b8fd3d 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -183,6 +183,10 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	return 0;
 
 no_dev:
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
 	platform_set_drvdata(pdev, NULL);
 	iounmap(io_base);
 no_res:
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f0f06b2..c496720 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2983,6 +2983,10 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	if (!IS_ERR(mp->clk)) {
+		clk_disable_unprepare(mp->clk);
+		clk_put(mp->clk);
+	}
 	free_netdev(dev);
 
 	return err;
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 82de107..c6903e3 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -298,6 +298,10 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 err4:
 	usb_put_hcd(hcd);
 err3:
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
 	iounmap(regs);
 err2:
 	release_mem_region(res->start, resource_size(res));
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index fa45567..7646dd7 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -458,7 +458,13 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(priv->clk);
 
-	return snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
+	err = snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
+	if (!err)
+		return 0;
+	dev_err(&pdev->dev, "snd_soc_register_dai failed\n");
+
+	clk_disable_unprepare(priv->clk);
+	clk_put(priv->clk);
 
 err_ioremap:
 	iounmap(priv->io);
-- 
1.7.9.5
