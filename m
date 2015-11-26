From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 26 Nov 2015 19:08:10 +0100
Subject: [PATCH v2 net 3/6] net: mvneta: fix bit assignment for RX packet irq
 enable
In-Reply-To: <1448561293-16431-1-git-send-email-mw@semihalf.com>
References: <1448561293-16431-1-git-send-email-mw@semihalf.com>
Message-ID: <1448561293-16431-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A value originally defined in the driver was inappropriate. Even though
the ingress was somehow working, writing MVNETA_RXQ_INTR_ENABLE_ALL_MASK
to MVNETA_INTR_ENABLE didn't make any effect, because the bits [31:16]
are reserved and read-only.

This commit updates MVNETA_RXQ_INTR_ENABLE_ALL_MASK to be compliant with
the controller's documentation.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v3.8+
Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network
unit")
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d78edbb..0c3d923 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -160,7 +160,7 @@
 
 #define MVNETA_INTR_ENABLE                       0x25b8
 #define      MVNETA_TXQ_INTR_ENABLE_ALL_MASK     0x0000ff00
-#define      MVNETA_RXQ_INTR_ENABLE_ALL_MASK     0xff000000  // note: neta says it's 0x000000FF
+#define      MVNETA_RXQ_INTR_ENABLE_ALL_MASK     0x000000ff
 
 #define MVNETA_RXQ_CMD                           0x2680
 #define      MVNETA_RXQ_DISABLE_SHIFT            8
-- 
1.8.3.1
