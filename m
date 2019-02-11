Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF98C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6939E20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/qg878a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6939E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q+4cYYW2cKIKkuIwwyF8vbwpv/AzEeblw8JlgUbxAJo=; b=o/qg878ay1/M0N
	suRPpvb0068Oczu0GadRY1DOQBC4ZIZN9hIC12zROMNaD3cl5qrD2jedGTay3FZr/lQo+YpD656Ke
	BcVw2jaBaqJlq0bDajXvvHnHmKgRCS0SfVV8QunoN9Wrc22wPd8IcKJv40QR65mdqeocYf0r6SVAs
	g8lA6TwFDc8zEghe0/+n3YFkJy0G1KHHWOZzW4G3YBRu3VnzH8GCjIDNz7MbMZFiZYZSf7uM7piLd
	NY0AG9lhfX5cA0q2Gk7bop+XRAKJfaTJHrcooAB8vx2+bJ76XosJMsbuHjiQFxxTvsltYVLuQIhxZ
	aOyNROVl7U2RnUrZDQdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCX0-0003M7-Q6; Mon, 11 Feb 2019 14:25:58 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCWu-0003JP-3P
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:25:56 +0000
X-Originating-IP: 90.88.22.177
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 86C1124000F;
 Mon, 11 Feb 2019 14:25:41 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 1/4] net: phy: Mask-out non-compatible modes when
 setting the max-speed
Date: Mon, 11 Feb 2019 15:25:26 +0100
Message-Id: <20190211142529.22885-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_062552_519825_62DB7DE8 
X-CRM114-Status: GOOD (  13.69  )
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

When setting a PHY's max speed using either the max-speed DT property
or ethtool, we should mask-out all non-compatible modes according to the
settings table, instead of just the 10/100BASET modes.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-core.c   | 45 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 53 ------------------------------------
 include/linux/phy.h          |  1 +
 3 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index cdea028d1328..855abf487279 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -4,6 +4,7 @@
  */
 #include <linux/export.h>
 #include <linux/phy.h>
+#include <linux/of.h>
 
 const char *phy_speed_to_str(int speed)
 {
@@ -338,6 +339,50 @@ size_t phy_speeds(unsigned int *speeds, size_t size,
 	return count;
 }
 
+static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
+{
+	const struct phy_setting *p;
+	int i;
+
+	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
+		if (p->speed > max_speed)
+			linkmode_clear_bit(p->bit, phydev->supported);
+		else
+			break;
+	}
+
+	return 0;
+}
+
+int phy_set_max_speed(struct phy_device *phydev, u32 max_speed)
+{
+	int err;
+
+	err = __set_phy_supported(phydev, max_speed);
+	if (err)
+		return err;
+
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_set_max_speed);
+
+void of_set_phy_supported(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	u32 max_speed;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return;
+
+	if (!node)
+		return;
+
+	if (!of_property_read_u32(node, "max-speed", &max_speed))
+		__set_phy_supported(phydev, max_speed);
+}
+
 /**
  * phy_resolve_aneg_linkmode - resolve the advertisements into phy settings
  * @phydev: The phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3d14e48aebc5..65e18293d8e5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1964,44 +1964,6 @@ int genphy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(genphy_loopback);
 
-static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
-{
-	switch (max_speed) {
-	case SPEED_10:
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				   phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				   phydev->supported);
-		/* fall through */
-	case SPEED_100:
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
-				   phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				   phydev->supported);
-		break;
-	case SPEED_1000:
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
-int phy_set_max_speed(struct phy_device *phydev, u32 max_speed)
-{
-	int err;
-
-	err = __set_phy_supported(phydev, max_speed);
-	if (err)
-		return err;
-
-	linkmode_copy(phydev->advertising, phydev->supported);
-
-	return 0;
-}
-EXPORT_SYMBOL(phy_set_max_speed);
-
 /**
  * phy_remove_link_mode - Remove a supported link mode
  * @phydev: phy_device structure to remove link mode from
@@ -2132,21 +2094,6 @@ bool phy_validate_pause(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_validate_pause);
 
-static void of_set_phy_supported(struct phy_device *phydev)
-{
-	struct device_node *node = phydev->mdio.dev.of_node;
-	u32 max_speed;
-
-	if (!IS_ENABLED(CONFIG_OF_MDIO))
-		return;
-
-	if (!node)
-		return;
-
-	if (!of_property_read_u32(node, "max-speed", &max_speed))
-		__set_phy_supported(phydev, max_speed);
-}
-
 static void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 378da9a6165e..20344c7744d8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -673,6 +673,7 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
+void of_set_phy_supported(struct phy_device *phydev);
 
 static inline bool __phy_is_started(struct phy_device *phydev)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
