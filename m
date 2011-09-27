From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 27 Sep 2011 09:46:08 +0200
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Message-ID: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Corrects a bug in pio read when reading packets < 4 bytes. These
small packets are only relevant for SDIO transfers.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e4c05..8831b2f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -776,7 +776,24 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 		if (count <= 0)
 			break;
 
-		readsl(base + MMCIFIFO, ptr, count >> 2);
+		/*
+		 * SDIO especially may want to receive something that is
+		 * not divisible by 4 (as opposed to card sectors
+		 * etc). Therefore make sure we always read the last bytes
+		 * out of the FIFO.
+		 */
+		switch (count) {
+		case 1:
+		case 3:
+			readsb(base + MMCIFIFO, ptr, count);
+			break;
+		case 2:
+			readsw(base + MMCIFIFO, ptr, 1);
+			break;
+		default:
+			readsl(base + MMCIFIFO, ptr, count >> 2);
+			break;
+		}
 
 		ptr += count;
 		remain -= count;
-- 
1.7.5.4
