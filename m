From: Frank.Li@freescale.com (Frank Li)
Date: Mon, 4 Mar 2013 14:52:38 +0800
Subject: [PATCH 1/1] net: fec: fix build error in no MXC platform
Message-ID: <1362379958-12972-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

build error cause by
Commit ff43da86c69d76a726ffe7d1666148960dc1d108
("NET: FEC: dynamtic check DMA desc buff type")

drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_get_nextdesc?:
drivers/net/ethernet/freescale/fec.c:215:18: error: invalid use of undefined type ?struct bufdesc_ex?
drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_get_prevdesc?:
drivers/net/ethernet/freescale/fec.c:224:18: error: invalid use of undefined type ?struct bufdesc_ex?
drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_start_xmit?:
drivers/net/ethernet/freescale/fec.c:286:37: error: arithmetic on pointer to an incomplete type
drivers/net/ethernet/freescale/fec.c:287:13: error: arithmetic on pointer to an incomplete type
drivers/net/ethernet/freescale/fec.c:324:7: error: dereferencing pointer to incomplete type etc....

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/net/ethernet/freescale/fec.h |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 01579b8..a53150c 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -97,6 +97,13 @@ struct bufdesc {
 	unsigned short cbd_sc;	/* Control and status info */
 	unsigned long cbd_bufaddr;	/* Buffer address */
 };
+#else
+struct bufdesc {
+	unsigned short	cbd_sc;			/* Control and status info */
+	unsigned short	cbd_datlen;		/* Data length */
+	unsigned long	cbd_bufaddr;		/* Buffer address */
+};
+#endif
 
 struct bufdesc_ex {
 	struct bufdesc desc;
@@ -107,14 +114,6 @@ struct bufdesc_ex {
 	unsigned short res0[4];
 };
 
-#else
-struct bufdesc {
-	unsigned short	cbd_sc;			/* Control and status info */
-	unsigned short	cbd_datlen;		/* Data length */
-	unsigned long	cbd_bufaddr;		/* Buffer address */
-};
-#endif
-
 /*
  *	The following definitions courtesy of commproc.h, which where
  *	Copyright (c) 1997 Dan Malek (dmalek at jlc.net).
-- 
1.7.1
