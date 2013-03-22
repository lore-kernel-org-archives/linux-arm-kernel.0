From: Frank.Li@freescale.com (Frank Li)
Date: Fri, 22 Mar 2013 09:19:53 +0800
Subject: [PATCH 1/1 v2 net-next] net: fec: fix the build as module
Message-ID: <1363915193-22179-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit ff43da86c69 (NET: FEC: dynamtic check DMA desc buff type) the
following build error happens when CONFIG_FEC=m

ERROR: "fec_ptp_init" [drivers/net/ethernet/freescale/fec.ko] undefined!
ERROR: "fec_ptp_ioctl" [drivers/net/ethernet/freescale/fec.ko] undefined!
ERROR: "fec_ptp_start_cyclecounter" [drivers/net/ethernet/freescale/fec.ko] undefined!

rename fec.c to fec_main.c
Build fec.o and fec_ptp.o into one fec.ko

Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
Change from V1 to V2
1. Use -M option to create patch

 drivers/net/ethernet/freescale/Makefile            |    3 ++-
 .../net/ethernet/freescale/{fec.c => fec_main.c}   |    0
 2 files changed, 2 insertions(+), 1 deletions(-)
 rename drivers/net/ethernet/freescale/{fec.c => fec_main.c} (100%)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index b7d58fe..549ce13 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -2,7 +2,8 @@
 # Makefile for the Freescale network device drivers.
 #
 
-obj-$(CONFIG_FEC) += fec.o fec_ptp.o
+obj-$(CONFIG_FEC) += fec.o
+fec-objs :=fec_main.o fec_ptp.o
 obj-$(CONFIG_FEC_MPC52xx) += fec_mpc52xx.o
 ifeq ($(CONFIG_FEC_MPC52xx_MDIO),y)
 	obj-$(CONFIG_FEC_MPC52xx) += fec_mpc52xx_phy.o
diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec_main.c
similarity index 100%
rename from drivers/net/ethernet/freescale/fec.c
rename to drivers/net/ethernet/freescale/fec_main.c
-- 
1.7.1
