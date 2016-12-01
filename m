From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  1 Dec 2016 18:03:05 +0100
Subject: [PATCH v6 net-next 2/7] net: mvneta: Do not allocate buffer in rxq
 init with HWBM
In-Reply-To: <cover.dd374b7aaa358be0211d7ead81129a399fa692f4.1480611779.git-series.gregory.clement@free-electrons.com>
References: <cover.dd374b7aaa358be0211d7ead81129a399fa692f4.1480611779.git-series.gregory.clement@free-electrons.com>
Message-ID: <fd5dc513b3128b2b10e9c23ad8aea90acbc2ffb6.1480611779.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For HWBM all buffers are allocated in mvneta_bm_construct() and in runtime
they are put into descriptors by hardware. There is no need to fill them
at this point.

Suggested-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 1b84f746d748..f5319c50f8d9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2784,14 +2784,14 @@ static int mvneta_rxq_init(struct mvneta_port *pp,
 		mvneta_rxq_buf_size_set(pp, rxq,
 					MVNETA_RX_BUF_SIZE(pp->pkt_size));
 		mvneta_rxq_bm_disable(pp, rxq);
+		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
 		mvneta_rxq_bm_enable(pp, rxq);
 		mvneta_rxq_long_pool_set(pp, rxq);
 		mvneta_rxq_short_pool_set(pp, rxq);
+		mvneta_rxq_non_occup_desc_add(pp, rxq, rxq->size);
 	}
 
-	mvneta_rxq_fill(pp, rxq, rxq->size);
-
 	return 0;
 }
 
-- 
git-series 0.8.10
