From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 23 Sep 2013 16:36:31 +0200
Subject: [PATCH 2/9] Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's and
 i.MX28's LRADC
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1379946998-23041-3-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LRADC units in i.MX23 and i.MX28 differ and we need to distinguish both
SoC variants in order to make the touchscreen work on i.MX23

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel at lists.infradead.org
CC: linux-input at vger.kernel.org
CC: devel at driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 00b61ac..3abc91f 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -177,6 +177,8 @@ struct mxs_lradc {
 
 	struct input_dev	*ts_input;
 	struct work_struct	ts_work;
+
+	enum mxs_lradc_id	soc;
 };
 
 #define	LRADC_CTRL0				0x00
@@ -923,6 +925,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	}
 
 	lradc = iio_priv(iio);
+	lradc->soc = (enum mxs_lradc_id)of_id->data;
 
 	/* Grab the memory area */
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.4.rc3
