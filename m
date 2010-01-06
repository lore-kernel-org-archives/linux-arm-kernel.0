From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:00 -0800
Subject: [PATCH 18/35] TI Davinci EMAC : add platform specific interrupt
	enable/disable logic.
In-Reply-To: <1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sriramakrishnan <srk@ti.com>

On certain SOCs, the EMAC controller is interfaced with a wrapper logic
for handling interrupts. This  patch implements a platform
specific hook to cater to platforms that require custom interrupt
handling logic

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Chaithrika U S <chaithrika@ti.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/net/davinci_emac.c   |   11 +++++++++++
 include/linux/davinci_emac.h |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/net/davinci_emac.c b/drivers/net/davinci_emac.c
index d4e72c0..8c356b5 100644
--- a/drivers/net/davinci_emac.c
+++ b/drivers/net/davinci_emac.c
@@ -487,6 +487,9 @@ struct emac_priv {
 	struct mii_bus *mii_bus;
 	struct phy_device *phydev;
 	spinlock_t lock;
+	/*platform specific members*/
+	void (*int_enable) (void);
+	void (*int_disable) (void);
 };
 
 /* clock frequency for EMAC */
@@ -1001,6 +1004,8 @@ static void emac_int_disable(struct emac_priv *priv)
 		emac_ctrl_write(EMAC_DM646X_CMRXINTEN, 0x0);
 		emac_ctrl_write(EMAC_DM646X_CMTXINTEN, 0x0);
 		/* NOTE: Rx Threshold and Misc interrupts are not disabled */
+		if (priv->int_disable)
+			priv->int_disable();
 
 		local_irq_restore(flags);
 
@@ -1020,6 +1025,9 @@ static void emac_int_disable(struct emac_priv *priv)
 static void emac_int_enable(struct emac_priv *priv)
 {
 	if (priv->version == EMAC_VERSION_2) {
+		if (priv->int_enable)
+			priv->int_enable();
+
 		emac_ctrl_write(EMAC_DM646X_CMRXINTEN, 0xff);
 		emac_ctrl_write(EMAC_DM646X_CMTXINTEN, 0xff);
 
@@ -2659,6 +2667,9 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 	priv->phy_mask = pdata->phy_mask;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
+	priv->int_enable = pdata->interrupt_enable;
+	priv->int_disable = pdata->interrupt_disable;
+
 	emac_dev = &ndev->dev;
 	/* Get EMAC platform data */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index ff55487..6d894ef 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -25,6 +25,8 @@ struct emac_platform_data {
 	u32 mdio_max_freq;
 	u8 rmii_en;
 	u8 version;
+	void (*interrupt_enable) (void);
+	void (*interrupt_disable) (void);
 };
 
 enum {
-- 
1.6.6.rc2.1.g42108
