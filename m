From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 21:51:29 +0100
Subject: [PATCH] spi: fix counting in spi-loopback-test code
Message-ID: <7416604.jejCLcpcOT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These variables are always used uninitialized:

drivers/spi/spi-loopback-test.c: In function 'spi_test_run_iter':
drivers/spi/spi-loopback-test.c:768:17: warning: 'rx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/spi/spi-loopback-test.c:762:17: warning: 'tx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]

Adding an explicit initialization seems to be the only
workable solution here, to make the code behave correctly
and build without warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 84e0c4e5e2c4 ("spi: add loopback test driver to allow for spi_master regression tests")
---
The warning is hidden in allmodconfig at the moment because we build
that with -Os rather than -O2, which shows it.

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 894616f687b0..cf4bb36bee25 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -761,6 +761,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		test.iterate_transfer_mask = 1;
 
 	/* count number of transfers with tx/rx_buf != NULL */
+	rx_count = tx_count = 0;
 	for (i = 0; i < test.transfer_count; i++) {
 		if (test.transfers[i].tx_buf)
 			tx_count++;
