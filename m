From: mw@semihalf.com (Marcin Wojtas)
Date: Wed,  6 Jul 2016 04:18:58 +0200
Subject: [PATCH net] net: mvneta: set real interrupt per packet for tx_done
Message-ID: <1467771538-31811-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dmitri Epshtein <dima@marvell.com>

Commit aebea2ba0f74 ("net: mvneta: fix Tx interrupt delay") intended to
set coalescing threshold to a value guaranteeing interrupt generation
per each sent packet, so that buffers can be released with no delay.

In fact setting threshold to '1' was wrong, because it causes interrupt
every two packets. According to the documentation a reason behind it is
following - interrupt occurs once sent buffers counter reaches a value,
which is higher than one specified in MVNETA_TXQ_SIZE_REG(q). This
behavior was confirmed during tests. Also when testing the SoC working
as a NAS device, better performance was observed with int-per-packet,
as it strongly depends on the fact that all transmitted packets are
released immediately.

This commit enables NETA controller work in interrupt per sent packet mode
by setting coalescing threshold to 0.

Signed-off-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v3.10+
Fixes aebea2ba0f74 ("net: mvneta: fix Tx interrupt delay")
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index cf04c97..0ad2fa3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -244,7 +244,7 @@
 /* Various constants */
 
 /* Coalescing */
-#define MVNETA_TXDONE_COAL_PKTS		1
+#define MVNETA_TXDONE_COAL_PKTS		0	/* interrupt per packet */
 #define MVNETA_RX_COAL_PKTS		32
 #define MVNETA_RX_COAL_USEC		100
 
-- 
1.8.3.1
