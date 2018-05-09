From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Wed,  9 May 2018 17:56:46 +0300
Subject: [PATCH v2] mtd: nxp-spifi: release flash_np in nxp_spifi_probe()
In-Reply-To: <20180509163920.67a5f203@bbrezillon>
Message-ID: <1525877806-21148-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nxp_spifi_probe() increments refcnt of SPI flash device node by
of_get_next_available_child() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mtd/spi-nor/nxp-spifi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
index 15374216d4d9..7b047951d0a2 100644
--- a/drivers/mtd/spi-nor/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/nxp-spifi.c
@@ -438,11 +438,15 @@ static int nxp_spifi_probe(struct platform_device *pdev)
 	ret = nxp_spifi_setup_flash(spifi, flash_np);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to setup flash chip\n");
-		goto dis_clks;
+		goto put_np;
 	}
 
+	of_node_put(flash_np);
+
 	return 0;
 
+put_np:
+	of_node_put(flash_np);
 dis_clks:
 	clk_disable_unprepare(spifi->clk_spifi);
 dis_clk_reg:
-- 
2.7.4
