From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 26 Nov 2015 19:08:08 +0100
Subject: [PATCH v2 net 1/6] net: mvneta: add configuration for MBUS windows
 access protection
In-Reply-To: <1448561293-16431-1-git-send-email-mw@semihalf.com>
References: <1448561293-16431-1-git-send-email-mw@semihalf.com>
Message-ID: <1448561293-16431-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds missing configuration of MBUS windows access protection
in mvneta_conf_mbus_windows function - a dedicated variable for that
purpose remained there unused since v3.8 initial mvneta support. Because
of that the register contents were inherited from the bootloader.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.8+
Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network
unit")
---
 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e84c7f2..c4327b9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -62,6 +62,7 @@
 #define MVNETA_WIN_SIZE(w)                      (0x2204 + ((w) << 3))
 #define MVNETA_WIN_REMAP(w)                     (0x2280 + ((w) << 2))
 #define MVNETA_BASE_ADDR_ENABLE                 0x2290
+#define MVNETA_ACCESS_PROTECT_ENABLE		0x2294
 #define MVNETA_PORT_CONFIG                      0x2400
 #define      MVNETA_UNI_PROMISC_MODE            BIT(0)
 #define      MVNETA_DEF_RXQ(q)                  ((q) << 1)
@@ -3188,9 +3189,11 @@ static void mvneta_conf_mbus_windows(struct mvneta_port *pp,
 
 		win_enable &= ~(1 << i);
 		win_protect |= 3 << (2 * i);
+
 	}
 
 	mvreg_write(pp, MVNETA_BASE_ADDR_ENABLE, win_enable);
+	mvreg_write(pp, MVNETA_ACCESS_PROTECT_ENABLE, win_protect);
 }
 
 /* Power up the port */
-- 
1.8.3.1
