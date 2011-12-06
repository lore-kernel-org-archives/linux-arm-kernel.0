From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  6 Dec 2011 11:27:13 +0100
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: don't munge MAC
 address from platform data
In-Reply-To: <6d1e5cdcbfc48df864ec9e0939645c0e95389d2a.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <bd4415514fa0b40ece04d56b3ac4f549e79d87d7.1323163127.git.LW@KARO-electronics.de>
 <6c28f25c5c6d2f88d0985ce361c5e16f19db27d0.1323163127.git.LW@KARO-electronics.de>
 <0b92136d69e509a6ce49b526e1834f0ec90b04a4.1323163127.git.LW@KARO-electronics.de>
 <6d1e5cdcbfc48df864ec9e0939645c0e95389d2a.1323163127.git.LW@KARO-electronics.de>
Message-ID: <55b78c1766da5b0d0d679f5eae3fb9fc74a6ceef.1323163127.git.LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the MAC address is supplied via platform_data it should be OK as
it is and should not be modified in case of a dual FEC setup.
Also copying the MAC from platform_data to the single 'macaddr'
variable will overwrite the MAC for the first interface in case of a
dual FEC setup.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index e2b5ce6..11534b9 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -818,7 +818,7 @@ static void __inline__ fec_get_mac(struct net_device *ndev)
 			iap = (unsigned char *)FEC_FLASHMAC;
 #else
 		if (pdata)
-			memcpy(iap, pdata->mac, ETH_ALEN);
+			iap = (unsigned char *)&pdata->mac;
 #endif
 	}
 
-- 
1.5.6.5
