From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 10 Nov 2011 17:10:22 +0100
Subject: [PATCH] mmc: mmci: Increase max_segs from 16 to 128
Message-ID: <1320941422-1565-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A significant increase (10-20%) in performance throughput for
USB mass storage is the reason for incrementing the value.
By some reason the USB driver allocates buffers which requires
a scattergather list to contain a lot more than 16 elements to
get optimal performance. This change sets the maximum elements
to 128.

Tests with large reads and large writes (100 MiB) show that the
throughput increase is significant for write (10% for this test)
but not for read. Tests are run on a Linux host with ext4 FS on
the gadget mass storage device. The sg-len still exceeds 16 for
the read tests but the performance gain is low or nothing.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 drivers/mmc/host/mmci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79e4143..49f153e 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -160,7 +160,7 @@
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
-#define NR_SG		16
+#define NR_SG		128
 
 struct clk;
 struct variant_data;
-- 
1.7.5.4
