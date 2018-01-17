From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Jan 2018 19:30:55 +0100
Subject: [PATCH] net: fec: add necessary defines to work on ARM64
Message-ID: <20180117183055.27602-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX8 is a ARMv8 based SoC, that uses the same FEC IP as the
earlier, ARMv7 based, i.MX SoCs. Allow the driver to work on ARM64.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h      | 5 +++--
 drivers/net/ethernet/freescale/fec_main.c | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5385074b3b7d..e7381f8ef89d 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -20,7 +20,8 @@
 #include <linux/timecounter.h>
 
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM)
+    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+    defined(CONFIG_ARM64)
 /*
  *	Just figures, Motorola would have to change the offsets for
  *	registers in the same peripheral device on different models
@@ -195,7 +196,7 @@
  *	Evidently, ARM SoCs have the FEC block generated in a
  *	little endian mode so adjust endianness accordingly.
  */
-#if defined(CONFIG_ARM)
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 #define fec32_to_cpu le32_to_cpu
 #define fec16_to_cpu le16_to_cpu
 #define cpu_to_fec32 cpu_to_le32
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a74300a4459c..45eed37373a9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -195,7 +195,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * account when setting it.
  */
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM)
+    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+    defined(CONFIG_ARM64)
 #define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
 #else
 #define	OPT_FRAME_SIZE	0
@@ -2107,7 +2108,8 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
 
 /* List of registers that can be safety be read to dump them with ethtool */
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM)
+	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+	defined(CONFIG_ARM64)
 static u32 fec_enet_register_offset[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
 	FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT, FEC_R_CNTRL,
@@ -3119,7 +3121,7 @@ static int fec_enet_init(struct net_device *ndev)
 	unsigned dsize_log2 = __fls(dsize);
 
 	WARN_ON(dsize != (1 << dsize_log2));
-#if defined(CONFIG_ARM)
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	fep->rx_align = 0xf;
 	fep->tx_align = 0xf;
 #else
-- 
2.11.0
