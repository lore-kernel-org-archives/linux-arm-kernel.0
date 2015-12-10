From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 Dec 2015 21:59:04 +0530
Subject: [PATCH v2 1/2] spi: davinci: fix spurious i/o error
In-Reply-To: <cover.1449764266.git.nsekhar@ti.com>
References: <cover.1449764266.git.nsekhar@ti.com>
Message-ID: <fbcc972e6612cf3d069e7230dd078d8a1e0e2e5a.1449764266.git.nsekhar@ti.com>
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
 drivers/spi/spi-davinci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7d3af3eacf57..57d6960a6252 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -703,7 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	/* Wait for the transfer to complete */
 	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
-		wait_for_completion_interruptible(&(dspi->done));
+		if (wait_for_completion_timeout(&dspi->done, HZ) == 0)
+			errors = SPIFLG_TIMEOUT_MASK;
 	} else {
 		while (dspi->rcount > 0 || dspi->wcount > 0) {
 			errors = davinci_spi_process_events(dspi);
-- 
2.6.3
