From: sven.fischer@snom.com (Sven Fischer)
Date: Thu, 21 Apr 2011 18:17:18 +0200
Subject: [PATCH] Enhanced ethtool API of CPSW driver in order to be able to
	address even more than one PHY.
Message-ID: <1303402638-29884-1-git-send-email-sven.fischer@snom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linked ethtool ioctls ETHTOOL_GSET and ETHTOOL_SSET to the CPSW switch driver and added a new ioctl ETHTOOL_GPHYLINK.

The new ETHTOOL_GPHYLINK, which gets the PHY link status of a specific PHY, makes ETHTOOL_GLINK obsolete, because it was not working PHY specific.

ETHTOOL_GSET and ETHTOOL_SSET ioctls are now able to access a specific PHY as well.
---
 drivers/net/cpsw.c      |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy.c   |    9 ++++++++
 include/linux/ethtool.h |   12 +++++++++-
 include/linux/phy.h     |    1 +
 net/core/ethtool.c      |   28 ++++++++++++++++++++++++-
 5 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cpsw.c b/drivers/net/cpsw.c
index df4d302..b1045b1 100644
--- a/drivers/net/cpsw.c
+++ b/drivers/net/cpsw.c
@@ -319,6 +319,54 @@ static void cpsw_adjust_link(struct net_device *ndev)
 	}
 }
 
+static u32 cpsw_slave_get_link(struct net_device *ndev,
+			       struct ethtool_link *cmd)
+{
+	struct cpsw_priv	*priv = netdev_priv(ndev);
+	int port;
+
+	if (!priv || !cmd) return -EFAULT;
+	for (port = 0; port < priv->data.slaves; port++) {
+		struct cpsw_slave *slave = priv->slaves + port;
+		if (slave && slave->phy && (slave->phy->addr == cmd->phy_address)) {
+			return phy_ethtool_gphlnk(slave->phy, cmd);
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static int cpsw_slave_get_settings(struct net_device *ndev,
+				   struct ethtool_cmd *cmd)
+{
+	struct cpsw_priv	*priv = netdev_priv(ndev);
+	int port;
+	
+	if (!priv || !cmd) return -EFAULT;
+	for (port = 0; port < priv->data.slaves; port++) {
+		struct cpsw_slave *slave = priv->slaves + port;
+		if (slave && slave->phy && (slave->phy->addr == cmd->phy_address)) {
+			return phy_ethtool_gset(slave->phy, cmd);
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static int cpsw_slave_set_settings(struct net_device *ndev,
+				   struct ethtool_cmd *cmd)
+{
+	struct cpsw_priv	*priv = netdev_priv(ndev);
+	int port;
+	
+	if (!priv || !cmd) return -EFAULT;
+	for (port = 0; port < priv->data.slaves; port++) {
+		struct cpsw_slave *slave = priv->slaves + port;
+		if (slave && slave->phy && (slave->phy->addr == cmd->phy_address)) {
+			return phy_ethtool_sset(slave->phy, cmd);
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
 static inline int __show_stat(char *buf, int maxlen, const char* name, u32 val)
 {
 	static char *leader = "........................................";
@@ -718,6 +766,7 @@ static struct net_device_stats *cpsw_ndo_get_stats(struct net_device *ndev)
 	return &priv->stats;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void cpsw_ndo_poll_controller(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -726,6 +775,7 @@ static void cpsw_ndo_poll_controller(struct net_device *ndev)
 	cpsw_interrupt(ndev->irq, priv);
 	cpdma_ctlr_int_ctrl(priv->dma, true);
 }
+#endif
 
 static const struct net_device_ops cpsw_netdev_ops = {
 	.ndo_open		= cpsw_ndo_open,
@@ -764,9 +814,12 @@ static void cpsw_set_msglevel(struct net_device *ndev, u32 value)
 
 static const struct ethtool_ops cpsw_ethtool_ops = {
 	.get_drvinfo	= cpsw_get_drvinfo,
+	.get_settings   = cpsw_slave_get_settings,
+	.set_settings   = cpsw_slave_set_settings,
 	.get_msglevel	= cpsw_get_msglevel,
 	.set_msglevel	= cpsw_set_msglevel,
 	.get_link	= ethtool_op_get_link,
+	.get_phy_link   = cpsw_slave_get_link,
 };
 
 static void cpsw_slave_init(struct cpsw_slave *slave, struct cpsw_priv *priv)
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 7670aac..c2bbe21 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -297,6 +297,15 @@ int phy_ethtool_gset(struct phy_device *phydev, struct ethtool_cmd *cmd)
 }
 EXPORT_SYMBOL(phy_ethtool_gset);
 
+int phy_ethtool_gphlnk(struct phy_device *phydev, struct ethtool_link *cmd)
+{
+	cmd->phy_address = phydev->addr;
+	cmd->link = phydev->link;
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_ethtool_gphlnk);
+
 /**
  * phy_mii_ioctl - generic PHY MII ioctl interface
  * @phydev: the phy_device struct
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6628a50..8734985 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -50,6 +50,13 @@ static inline __u32 ethtool_cmd_speed(struct ethtool_cmd *ep)
 	return (ep->speed_hi << 16) | ep->speed;
 }
 
+/* Used for ETHTOOL_GPHYLINK */
+struct ethtool_link {
+	__u32	cmd;
+	__u8	phy_address;
+	__u8	link;
+};
+
 #define ETHTOOL_FWVERS_LEN	32
 #define ETHTOOL_BUSINFO_LEN	32
 /* these strings are set to whatever the driver author decides... */
@@ -570,6 +577,7 @@ void ethtool_ntuple_flush(struct net_device *dev);
  * set_msglevel: Set driver message level
  * nway_reset: Restart autonegotiation
  * get_link: Get link status
+ * get_phy_link: Get link status of a specific PHY; replaces get_link
  * get_eeprom: Read data from the device EEPROM
  * set_eeprom: Write data to the device EEPROM
  * get_coalesce: Get interrupt coalescing parameters
@@ -629,6 +637,7 @@ struct ethtool_ops {
 	void	(*set_msglevel)(struct net_device *, u32);
 	int	(*nway_reset)(struct net_device *);
 	u32	(*get_link)(struct net_device *);
+	u32	(*get_phy_link)(struct net_device *, struct ethtool_link *);
 	int	(*get_eeprom_len)(struct net_device *);
 	int	(*get_eeprom)(struct net_device *,
 			      struct ethtool_eeprom *, u8 *);
@@ -691,7 +700,7 @@ struct ethtool_ops {
 #define ETHTOOL_GMSGLVL		0x00000007 /* Get driver message level */
 #define ETHTOOL_SMSGLVL		0x00000008 /* Set driver msg level. */
 #define ETHTOOL_NWAY_RST	0x00000009 /* Restart autonegotiation. */
-#define ETHTOOL_GLINK		0x0000000a /* Get link status (ethtool_value) */
+#define ETHTOOL_GLINK		0x0000000a /* Get link status (ethtool_value), replaced by ETHTOOL_GPHYLINK */
 #define ETHTOOL_GEEPROM		0x0000000b /* Get EEPROM data */
 #define ETHTOOL_SEEPROM		0x0000000c /* Set EEPROM data. */
 #define ETHTOOL_GCOALESCE	0x0000000e /* Get coalesce config */
@@ -741,6 +750,7 @@ struct ethtool_ops {
 #define ETHTOOL_GSSET_INFO	0x00000037 /* Get string set info */
 #define ETHTOOL_GRXFHINDIR	0x00000038 /* Get RX flow hash indir'n table */
 #define ETHTOOL_SRXFHINDIR	0x00000039 /* Set RX flow hash indir'n table */
+#define ETHTOOL_GPHYLINK	0x0000003a /* Get phy link status, makes ETHTOOL_GLINK obsolete */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7da5fa8..e73c139 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -508,6 +508,7 @@ void phy_start_machine(struct phy_device *phydev,
 void phy_stop_machine(struct phy_device *phydev);
 int phy_ethtool_sset(struct phy_device *phydev, struct ethtool_cmd *cmd);
 int phy_ethtool_gset(struct phy_device *phydev, struct ethtool_cmd *cmd);
+int phy_ethtool_gphlnk(struct phy_device *phydev, struct ethtool_link *cmd);
 int phy_mii_ioctl(struct phy_device *phydev,
 		struct ifreq *ifr, int cmd);
 int phy_start_interrupts(struct phy_device *phydev);
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 956a9f4..409d13d 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -171,14 +171,37 @@ EXPORT_SYMBOL(ethtool_ntuple_flush);
 
 /* Handlers for each ethtool command */
 
+static int ethtool_get_phy_link(struct net_device *dev, void __user *useraddr)
+{
+	struct ethtool_link cmd;
+	int err;
+
+	if (!dev->ethtool_ops->get_phy_link)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
+		return -EFAULT;
+
+	err = dev->ethtool_ops->get_phy_link(dev, &cmd);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(useraddr, &cmd, sizeof(cmd)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 {
-	struct ethtool_cmd cmd = { .cmd = ETHTOOL_GSET };
+	struct ethtool_cmd cmd;
 	int err;
 
 	if (!dev->ethtool_ops->get_settings)
 		return -EOPNOTSUPP;
 
+	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
+		return -EFAULT;
+
 	err = dev->ethtool_ops->get_settings(dev, &cmd);
 	if (err < 0)
 		return err;
@@ -1531,6 +1554,9 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 		rc = ethtool_get_value(dev, useraddr, ethcmd,
 				       dev->ethtool_ops->get_link);
 		break;
+	case ETHTOOL_GPHYLINK:
+		rc = ethtool_get_phy_link(dev, useraddr);
+		break;
 	case ETHTOOL_GEEPROM:
 		rc = ethtool_get_eeprom(dev, useraddr);
 		break;
-- 
1.7.3.2
