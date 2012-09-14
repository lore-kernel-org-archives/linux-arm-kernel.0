From: dciminaghi@mail.gnudd.com (Davide Ciminaghi)
Date: Fri, 14 Sep 2012 18:24:00 +0200
Subject: [PATCH 5/8] mmci: replace readsl/writesl with
 ioread32_rep/iowrite32_rep
In-Reply-To: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <1347639843-32119-6-git-send-email-dciminaghi@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Davide Ciminaghi <ciminaghi@gnudd.com>

Not all the architectures have readsl/writesl,
use the more portable ioread32_rep/iowrite32_rep functions instead.

Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
---
 drivers/mmc/host/mmci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50ff19a..263102c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -840,14 +840,14 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 		if (unlikely(count & 0x3)) {
 			if (count < 4) {
 				unsigned char buf[4];
-				readsl(base + MMCIFIFO, buf, 1);
+				ioread32_rep(base + MMCIFIFO, buf, 1);
 				memcpy(ptr, buf, count);
 			} else {
-				readsl(base + MMCIFIFO, ptr, count >> 2);
+				ioread32_rep(base + MMCIFIFO, ptr, count >> 2);
 				count &= ~0x3;
 			}
 		} else {
-			readsl(base + MMCIFIFO, ptr, count >> 2);
+			ioread32_rep(base + MMCIFIFO, ptr, count >> 2);
 		}
 
 		ptr += count;
@@ -900,7 +900,7 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		 * byte become a 32bit write, 7 bytes will be two
 		 * 32bit writes etc.
 		 */
-		writesl(base + MMCIFIFO, ptr, (count + 3) >> 2);
+		iowrite32_rep(base + MMCIFIFO, ptr, (count + 3) >> 2);
 
 		ptr += count;
 		remain -= count;
-- 
1.7.9.1
