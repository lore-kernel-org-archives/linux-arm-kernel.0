From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:25 -0000
Subject: [PATCH 4/5] spi: sunxi: set maximum and minimum speed of SPI master
In-Reply-To: <cover.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
Message-ID: <7292b1fa08de4f453a643beb63e9faa7826726f6.1464130597.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum speed of SPI master is used when maximum speed of SPI slave
is not specified. Also the __spi_validate function should check that
transfer speeds do not exceed the master limits.

The user manual for A10 and A31 specifies maximum
speed of the SPI clock as 100MHz and minimum as 3kHz.

Setting the SPI clock to out-of-spec values can lock up the SoC.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 2 ++
 drivers/spi/spi-sun6i.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index bf52b09..e1a75dd6 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -405,6 +405,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	master->max_speed_hz = 100*1000*1000;
+	master->min_speed_hz =        3*1000;
 	master->set_cs = sun4i_spi_set_cs;
 	master->transfer_one = sun4i_spi_transfer_one;
 	master->num_chipselect = 4;
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 1952956..0c378ff 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -400,6 +400,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	master->max_speed_hz = 100*1000*1000;
+	master->min_speed_hz =        3*1000;
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-- 
2.8.1
