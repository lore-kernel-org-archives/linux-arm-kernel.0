From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 26 Feb 2013 14:47:54 +0800
Subject: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect wrongly
 set.
In-Reply-To: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if the spi property "cs-gpios" is set as below:

	cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;

the master->num_chipselect will wrongly be set to 0,
and the spi fail to probe.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: spi-devel-general at lists.sourceforge.net
Cc: linux-kernel at vger.kernel.org
---
 drivers/spi/spi-atmel.c |    2 +-
 drivers/spi/spi.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ab34497..5bf3786 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -944,7 +944,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = pdev->id;
-	master->num_chipselect = master->dev.of_node ? 0 : 4;
+	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 19ee901..d88cbef 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1070,7 +1070,7 @@ static int of_spi_register_master(struct spi_master *master)
 	master->num_chipselect = max(nb, master->num_chipselect);
 
 	if (nb < 1)
-		return 0;
+		nb = master->num_chipselect;
 
 	cs = devm_kzalloc(&master->dev,
 			  sizeof(int) * master->num_chipselect,
-- 
1.7.9.5
