From: codehero@gmail.com (Dave Bender)
Date: Fri, 31 Oct 2014 11:40:40 -0400
Subject: [PATCH] omap2-mcspi: when overriding spi settings, don't clobber IO
 error on calling omap2_mcspi_setup_transfer
Message-ID: <CAETHaKrz9tPN-quM3iCisKuTPqK61GdS3zLgi3HMrieiZGMRgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Observed errors using spidev (erroneously on the userspace I may add)
and traced it to a bug in omap2-mcspi.c clobbering the status:

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d7e52c2..4fda762 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1153,8 +1153,10 @@ static void omap2_mcspi_work(struct omap2_mcspi
*mcspi, struct spi_message *m)
  }
  /* Restore defaults if they were overriden */
  if (par_override) {
+ int status_transfer;
  par_override = 0;
- status = omap2_mcspi_setup_transfer(spi, NULL);
+ status_transfer = omap2_mcspi_setup_transfer(spi, NULL);
+ status = status ? status : status_transfer;
  }

  if (cs_active)
