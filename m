From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Nov 2015 16:04:01 +0530
Subject: [PATCH] spi: davinci: fix spurious i/o error
Message-ID: <108883742c4b44d338ea0816abeeb2901a2afcd5.1448361028.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

davinci_spi_bufs() uses wait_for_completion_interruptible()
without bothering to handle -ERESTARTSYS. Due to this,
sometime, it returns prematurely when a signal is received.
Since the return value is never checked, userspace eventually
receives a spurious -EIO.

To fix this, use un-interruptible wait_for_completion_timeout().

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/spi/spi-davinci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7d3af3eacf57..38026aa1afd7 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -703,7 +703,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	/* Wait for the transfer to complete */
 	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
-		wait_for_completion_interruptible(&(dspi->done));
+		if (wait_for_completion_timeout(&dspi->done, HZ) == 0) {
+			dev_err(&spi->dev, "spi transfer timeout\n");
+			return -ETIMEDOUT;
+		}
 	} else {
 		while (dspi->rcount > 0 || dspi->wcount > 0) {
 			errors = davinci_spi_process_events(dspi);
-- 
2.4.4.408.g16da57c
