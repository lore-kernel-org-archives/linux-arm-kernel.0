From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:20 +0100
Subject: [PATCH 1/6] spi: imx: specify spi base for device tree probe
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1352469625-32024-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT probe uses a dynamically allocated base for the spi core. This is a
completely different numbering scheme than in the non-DT probe.

* This breaks compatibility with user space applications between non-DT and DT.

* On platforms that are in between DT and non-DT, it breaks registration of
  devices via spi_board_info.

Use the same method as 7e6086d9e54a159a6257c02bb7fc5805c614aad2 does for gpios:
Use alias to identify the spi port, and then specify the base via the port id.
If alias is not defined in DT, allocate the base dynamically.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/spi/spi-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c9a0d84..d1e92b4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -783,7 +783,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
-	master->bus_num = pdev->id;
+	master->bus_num = (pdev->id < 0) ? of_alias_get_id(np, "spi") : pdev->id;
 	master->num_chipselect = num_cs;
 
 	spi_imx = spi_master_get_devdata(master);
-- 
1.7.10.4
