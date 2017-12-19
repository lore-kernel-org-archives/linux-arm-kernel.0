From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Dec 2017 17:59:47 +0100
Subject: [PATCH net 3/3] net: mvneta: eliminate wrong call to handle rx
 descriptor error
In-Reply-To: <20171219165947.28516-1-gregory.clement@free-electrons.com>
References: <20171219165947.28516-1-gregory.clement@free-electrons.com>
Message-ID: <20171219165947.28516-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

There are few reasons in mvneta_rx_swbm() function when received packet
is dropped. mvneta_rx_error() should be called only if error bit [16]
is set in rx descriptor.

[gregory.clement at free-electrons.com: add fixes tag]
Cc: stable at vger.kernel.org
Fixes: dc35a10f68d3 ("net: mvneta: bm: add support for hardware buffer management")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Tested-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 1e0835655c93..a539263cd79c 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1962,9 +1962,9 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 		if (!mvneta_rxq_desc_is_first_last(rx_status) ||
 		    (rx_status & MVNETA_RXD_ERR_SUMMARY)) {
+			mvneta_rx_error(pp, rx_desc);
 err_drop_frame:
 			dev->stats.rx_errors++;
-			mvneta_rx_error(pp, rx_desc);
 			/* leave the descriptor untouched */
 			continue;
 		}
-- 
2.15.1
