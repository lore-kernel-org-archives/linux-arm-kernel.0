From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue,  3 Jan 2012 14:46:47 +0100
Subject: [PATCH] net: fsl: fec: fix build for mx23-only kernel
Message-ID: <1325598407-14353-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If one only selects mx23-based boards, compile fails:

drivers/net/ethernet/freescale/fec.c:410:2: error: 'FEC_HASH_TABLE_HIGH' undeclared (first use in this function)
drivers/net/ethernet/freescale/fec.c:411:2: error: 'FEC_HASH_TABLE_LOW' undeclared (first use in this function)

This is because fec.h uses CONFIG_SOC_IMX28 to determine the register
layout of the core which makes sense since the MX23 does not have a fec.
However, Kconfig uses the broader ARCH_MXS symbol and this way even
makes the fec-driver default for MX23. Adapt Kconfig to use the more
precise SOC_IMX28 as well.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/freescale/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 5272f9d..9de3764 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -23,8 +23,8 @@ if NET_VENDOR_FREESCALE
 config FEC
 	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
 	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
-		   ARCH_MXC || ARCH_MXS)
-	default ARCH_MXC || ARCH_MXS if ARM
+		   ARCH_MXC || SOC_IMX28)
+	default ARCH_MXC || SOC_IMX28 if ARM
 	select PHYLIB
 	---help---
 	  Say Y here if you want to use the built-in 10/100 Fast ethernet
-- 
1.7.7.3
