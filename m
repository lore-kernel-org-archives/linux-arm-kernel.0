From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Thu, 10 Aug 2017 20:42:47 +0300
Subject: [RFC PATCH 04/10] staging: fsl-dpaa2/eth: move generic FD defines to
 DPIO
In-Reply-To: <20170810174253.20951-1-horia.geanta@nxp.com>
References: <20170810174253.20951-1-horia.geanta@nxp.com>
Message-ID: <20170810174253.20951-5-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous commits:
6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
39163c0ce0f4 ("staging: fsl-dpaa2/eth: Errors checking update")
have added bits that are not specific to the WRIOP accelerator.

Move these where they belong (in DPIO) such that other accelerators
can make use of them.

While here, fix the values of FD_CTRL_FSE and FD_CTRL_FAERR, which
were shifted off by one bit.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  8 +++-----
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 19 +++++--------------
 drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index b9a0a315e6fb..a1d5c371e1c4 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -410,8 +410,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
 	dpaa2_fd_set_addr(fd, addr);
 	dpaa2_fd_set_len(fd, skb->len);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_ASAL | DPAA2_FD_CTRL_PTA |
-			  DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_ASAL | FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	return 0;
 
@@ -464,8 +463,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));
 	dpaa2_fd_set_len(fd, skb->len);
 	dpaa2_fd_set_format(fd, dpaa2_fd_single);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_ASAL | DPAA2_FD_CTRL_PTA |
-			  DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_ASAL | FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	return 0;
 }
@@ -653,7 +651,7 @@ static void dpaa2_eth_tx_conf(struct dpaa2_eth_priv *priv,
 		/* We only check error bits in the FAS field if corresponding
 		 * FAERR bit is set in FD and the FAS field is marked as valid
 		 */
-		has_fas_errors = (fd_errors & DPAA2_FD_CTRL_FAERR) &&
+		has_fas_errors = (fd_errors & FD_CTRL_FAERR) &&
 				 !!(dpaa2_fd_get_frc(fd) & DPAA2_FD_FRC_FASV);
 		if (net_ratelimit())
 			netdev_dbg(priv->net_dev, "TX frame FD error: %x08\n",
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index e6d28a249fc1..dfbb60b15555 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -120,23 +120,14 @@ struct dpaa2_eth_swa {
 #define DPAA2_FD_FRC_FASWOV		0x0800
 #define DPAA2_FD_FRC_FAICFDV		0x0400
 
-/* Error bits in FD CTRL */
-#define DPAA2_FD_CTRL_UFD		0x00000004
-#define DPAA2_FD_CTRL_SBE		0x00000008
-#define DPAA2_FD_CTRL_FSE		0x00000010
-#define DPAA2_FD_CTRL_FAERR		0x00000020
-
-#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FAERR)
-#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \
-					 DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FSE	| \
-					 DPAA2_FD_CTRL_FAERR)
+#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE | FD_CTRL_FAERR)
+#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \
+					 FD_CTRL_SBE	| \
+					 FD_CTRL_FSE	| \
+					 FD_CTRL_FAERR)
 
 /* Annotation bits in FD CTRL */
 #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128 */
-#define DPAA2_FD_CTRL_PTA		0x00800000
-#define DPAA2_FD_CTRL_PTV1		0x00400000
 
 /* Frame annotation status */
 struct dpaa2_fas {
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index 992fdc7ba5b8..72328415c26d 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -101,6 +101,18 @@ struct dpaa2_fd {
 #define FL_FINAL_FLAG_MASK	0x1
 #define FL_FINAL_FLAG_SHIFT	15
 
+/* Error bits in FD CTRL */
+#define FD_CTRL_ERR_MASK	0x000000FF
+#define FD_CTRL_UFD		0x00000004
+#define FD_CTRL_SBE		0x00000008
+#define FD_CTRL_FLC		0x00000010
+#define FD_CTRL_FSE		0x00000020
+#define FD_CTRL_FAERR		0x00000040
+
+/* Annotation bits in FD CTRL */
+#define FD_CTRL_PTA		0x00800000
+#define FD_CTRL_PTV1		0x00400000
+
 enum dpaa2_fd_format {
 	dpaa2_fd_single = 0,
 	dpaa2_fd_list,
-- 
2.12.0.264.gd6db3f216544
