From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:49 -0000
Subject: [PATCH v3 01/13] spi: sunxi: set maximum and minimum speed of SPI
 master
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <2db0ce0ea1ddc17e9bb790c8cc50bcb4bb97be58.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The speed limits are unset in the sun4i and sun6i SPI drivers.

The maximum speed of SPI master is used when maximum speed of SPI slave
is not specified. Also the __spi_validate function should check that
transfer speeds do not exceed the master limits.

The user manual for A10 and A31 specifies maximum
speed of the SPI clock as 100MHz and minimum as 3kHz.

Setting the SPI clock to out-of-spec values can lock up the SoC.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
--
v2:
new patch
v3:
fix constant style
---
 drivers/spi/spi-sun4i.c | 2 ++
 drivers/spi/spi-sun6i.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1ddd9e2..4213508 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -387,6 +387,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	master->max_speed_hz = 100 * 1000 * 1000;
+	master->min_speed_hz =          3 * 1000;
 	master->set_cs = sun4i_spi_set_cs;
 	master->transfer_one = sun4i_spi_transfer_one;
 	master->num_chipselect = 4;
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 42e2c4b..fe70695 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -386,6 +386,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	master->max_speed_hz = 100 * 1000 * 1000;
+	master->min_speed_hz =          3 * 1000;
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-- 
2.8.1
