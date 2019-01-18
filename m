Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A535F20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XwT+a3v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A535F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MamlL8VXI1CSb4sF5uOjbzw5E+gL4A2wgvumx4DAzC0=; b=XwT+a3v5bdEh6X
	tqgqTjJ3TtHevy0Vc8zG99EfPbaeezr5yaX7nokv29rSMaSIVz/1uwME0IQ4eiDfku0uOe+V+OYMP
	Er6BALEECjVszmOTokblxHssCy8GDBWPQ5L6cJ7t9AWNi6ud2pU9yPj8cku1NAnLGaS6iZVWgMR8g
	IDq5M7tL2AWeO5Kw0yWSAuKhFmKKPSHsEHYeAzcnC8tKhxDAtfSEX2OObKf3OM1y0cS4hWzdSnPci
	QaC6QptZk5eeMxG11PJnR2rtz2Hh3btfplFP/ucXId+5w/mxcvolVsvEOw1RuAp+rFTcoM76XEzgA
	xqQAPSWHxRIIyAV7YMhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW1H-0001jp-6r; Fri, 18 Jan 2019 15:25:19 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0G-0000Fy-Ol
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:22 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6BDE920A32; Fri, 18 Jan 2019 16:24:13 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 03C93207A3;
 Fri, 18 Jan 2019 16:24:03 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 1/7] net: phy: Extract genphy_c45_read_abilities from
 marvell10g
Date: Fri, 18 Jan 2019 16:23:46 +0100
Message-Id: <20190118152352.26417-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072417_181235_359A12F4 
X-CRM114-Status: GOOD (  17.35  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev@vger.kernel.org, gregory.clement@bootlin.com,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, stefanc@marvell.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Marvell 10G PHY driver has a generic way of initializing the supported
link modes by reading the PHY's C45 PMA abilities. This can be made
generic, since these registers are part of the 802.3 specifications.

This commit extracts the config_init link_mode initialization code from
marvell10g and uses it to introduce the genphy_c45_read_abilities
function.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 80 ++----------------------------
 drivers/net/phy/phy-c45.c    | 96 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  1 +
 3 files changed, 101 insertions(+), 76 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 82ab6ed3b74e..f2a6d6e7041a 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -251,8 +251,7 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
-	int val;
+	int ret;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -261,81 +260,10 @@ static int mv3310_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
 		return -ENODEV;
 
-	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
-	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
-
-	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
-		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
-		if (val < 0)
-			return val;
-
-		if (val & MDIO_AN_STAT1_ABLE)
-			__set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
-	}
-
-	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT2);
-	if (val < 0)
-		return val;
-
-	/* Ethtool does not support the WAN mode bits */
-	if (val & (MDIO_PMA_STAT2_10GBSR | MDIO_PMA_STAT2_10GBLR |
-		   MDIO_PMA_STAT2_10GBER | MDIO_PMA_STAT2_10GBLX4 |
-		   MDIO_PMA_STAT2_10GBSW | MDIO_PMA_STAT2_10GBLW |
-		   MDIO_PMA_STAT2_10GBEW))
-		__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBSR)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBLR)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBER)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, supported);
-
-	if (val & MDIO_PMA_STAT2_EXTABLE) {
-		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
-		if (val < 0)
-			return val;
-
-		if (val & (MDIO_PMA_EXTABLE_10GBT | MDIO_PMA_EXTABLE_1000BT |
-			   MDIO_PMA_EXTABLE_100BTX | MDIO_PMA_EXTABLE_10BT))
-			__set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
-		if (val & MDIO_PMA_EXTABLE_10GBLRM)
-			__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-		if (val & (MDIO_PMA_EXTABLE_10GBKX4 | MDIO_PMA_EXTABLE_10GBKR |
-			   MDIO_PMA_EXTABLE_1000BKX))
-			__set_bit(ETHTOOL_LINK_MODE_Backplane_BIT, supported);
-		if (val & MDIO_PMA_EXTABLE_10GBLRM)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBT)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBKX4)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBKR)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_1000BT)
-			__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_1000BKX)
-			__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_100BTX) {
-			__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				  supported);
-			__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				  supported);
-		}
-		if (val & MDIO_PMA_EXTABLE_10BT) {
-			__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-				  supported);
-			__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-				  supported);
-		}
-	}
+	ret = genphy_c45_read_abilities(phydev);
+	if (ret)
+		return ret;
 
-	linkmode_copy(phydev->supported, supported);
 	linkmode_and(phydev->advertising, phydev->advertising,
 		     phydev->supported);
 
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 03af927fa5ad..31806b432734 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -267,6 +267,102 @@ int genphy_c45_read_mdix(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 
+/**
+ * genphy_c45_read_abilities - read supported link modes from PMA
+ * @phydev: target phy_device struct
+ *
+ * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
+ * 1.8.9 is set, the list of supported modes is completed with the values in the
+ * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
+ * modes. If bit 1.11.14 is set, then the list is also completed with the modes
+ * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
+ * 5GBASET are supported.
+ */
+int genphy_c45_read_abilities(struct phy_device *phydev)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
+	int val;
+
+	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+
+	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
+		if (val < 0)
+			return val;
+
+		if (val & MDIO_AN_STAT1_ABLE)
+			__set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT2);
+	if (val < 0)
+		return val;
+
+	/* Ethtool does not support the WAN mode bits */
+	if (val & (MDIO_PMA_STAT2_10GBSR | MDIO_PMA_STAT2_10GBLR |
+		   MDIO_PMA_STAT2_10GBER | MDIO_PMA_STAT2_10GBLX4 |
+		   MDIO_PMA_STAT2_10GBSW | MDIO_PMA_STAT2_10GBLW |
+		   MDIO_PMA_STAT2_10GBEW))
+		__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
+	if (val & MDIO_PMA_STAT2_10GBSR)
+		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, supported);
+	if (val & MDIO_PMA_STAT2_10GBLR)
+		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, supported);
+	if (val & MDIO_PMA_STAT2_10GBER)
+		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, supported);
+
+	if (val & MDIO_PMA_STAT2_EXTABLE) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
+		if (val < 0)
+			return val;
+
+		if (val & (MDIO_PMA_EXTABLE_10GBT | MDIO_PMA_EXTABLE_1000BT |
+			   MDIO_PMA_EXTABLE_100BTX | MDIO_PMA_EXTABLE_10BT))
+			__set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
+		if (val & MDIO_PMA_EXTABLE_10GBLRM)
+			__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
+		if (val & (MDIO_PMA_EXTABLE_10GBKX4 | MDIO_PMA_EXTABLE_10GBKR |
+			   MDIO_PMA_EXTABLE_1000BKX))
+			__set_bit(ETHTOOL_LINK_MODE_Backplane_BIT, supported);
+		if (val & MDIO_PMA_EXTABLE_10GBLRM)
+			__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_10GBT)
+			__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_10GBKX4)
+			__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_10GBKR)
+			__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_1000BT)
+			__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_1000BKX)
+			__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+				  supported);
+		if (val & MDIO_PMA_EXTABLE_100BTX) {
+			__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				  supported);
+			__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				  supported);
+		}
+		if (val & MDIO_PMA_EXTABLE_10BT) {
+			__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+				  supported);
+			__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+				  supported);
+		}
+	}
+
+	linkmode_copy(phydev->supported, supported);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(genphy_c45_read_abilities);
+
 /* The gen10g_* functions are the old Clause 45 stub */
 
 int gen10g_config_aneg(struct phy_device *phydev)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f1c19bf8c658..a639c3c2d3af 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1017,6 +1017,7 @@ int genphy_c45_read_pma(struct phy_device *phydev);
 int genphy_c45_pma_setup_forced(struct phy_device *phydev);
 int genphy_c45_an_disable_aneg(struct phy_device *phydev);
 int genphy_c45_read_mdix(struct phy_device *phydev);
+int genphy_c45_read_abilities(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
