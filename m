From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  4 Sep 2013 16:26:52 +0200
Subject: [PATCH] net: mvneta: implement ->ndo_do_ioctl() to support PHY ioctls
Message-ID: <1378304812-21390-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the ->ndo_do_ioctl() operation so that the
PHY-related ioctl() calls can work from userspace, which allows
applications like mii-tool or mii-diag to do their job.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 90ab292..389a854 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2451,6 +2451,21 @@ static int mvneta_stop(struct net_device *dev)
 	return 0;
 }
 
+static int mvneta_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct mvneta_port *pp = netdev_priv(dev);
+	int ret;
+
+	if (!pp->phy_dev)
+		return -ENOTSUPP;
+
+	ret = phy_mii_ioctl(pp->phy_dev, ifr, cmd);
+	if (!ret)
+		mvneta_adjust_link(dev);
+
+	return ret;
+}
+
 /* Ethtool methods */
 
 /* Get settings (phy address, speed) for ethtools */
@@ -2569,6 +2584,7 @@ static const struct net_device_ops mvneta_netdev_ops = {
 	.ndo_change_mtu      = mvneta_change_mtu,
 	.ndo_tx_timeout      = mvneta_tx_timeout,
 	.ndo_get_stats64     = mvneta_get_stats64,
+	.ndo_do_ioctl        = mvneta_ioctl,
 };
 
 const struct ethtool_ops mvneta_eth_tool_ops = {
-- 
1.8.1.2
