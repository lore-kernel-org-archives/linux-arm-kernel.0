From: vasilyev@ispras.ru (Anton Vasilyev)
Date: Fri, 27 Jul 2018 18:57:47 +0300
Subject: [PATCH] net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
Message-ID: <20180727155747.24978-1-vasilyev@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mdio_mux_iproc_probe() uses platform_set_drvdata() to store md pointer
in device, whereas mdio_mux_iproc_remove() restores md pointer by
dev_get_platdata(&pdev->dev). This leads to wrong resources release.

The patch replaces getter to platform_get_drvdata.

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b7142df7..0c5b68e7da51 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -218,7 +218,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 static int mdio_mux_iproc_remove(struct platform_device *pdev)
 {
-	struct iproc_mdiomux_desc *md = dev_get_platdata(&pdev->dev);
+	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
-- 
2.18.0
