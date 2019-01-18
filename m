Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4598520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BqXhKdb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWn5AZPJNwPlqyjNBIaq+vssyUsx9NyaAMrmV6MQMbM=; b=BqXhKdb8qx4+Kv
	jkywBd0urn81WIBeth5FyK30fco+0eTV3NkZiKtt82y6uIsZ04FZ0vUcyhKOnGIAtR5kW0FH5AVcy
	LMy+ZkYFotqQiz3Ir9EgbCSLAZ01xmUeolExg0mjHS4x2P7Ov0VdbAb8vX9g9n9FyZRUasY4r23RL
	azD2/eatGZ2C8EqvzH09yC/mP1fMF7yRUKIGP07AXgg5VTIdhuHGl6pQeqRAINRdvSXyFYy5bSJ2L
	MD2qgqbeRKXQVHEYZLCmNix4i3huYThLG4qK+1FcP42NjpFcrjd9f758OJ0hIaoBHT3jg+8AEdAC+
	4WepMXDaUV1KA4jQl9Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW1Y-0002ez-RK; Fri, 18 Jan 2019 15:25:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0O-0000Pb-FX
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 34998207B0; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4E6DA20955;
 Fri, 18 Jan 2019 16:24:04 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of 2.5/5G
 PMA extended abilities
Date: Fri, 18 Jan 2019 16:23:50 +0100
Message-Id: <20190118152352.26417-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072425_407575_5A511D74 
X-CRM114-Status: GOOD (  15.20  )
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

As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
whether or not we should read register (1.21) "2.52/5G PMA Extended
Abilities", which contains information on the support of 2.5GBASET and
5GBASET.

After testing on several variants of PHYS of this family, it appears
that bit 14 in (1.11) isn't always set when it should be.

PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
but don't have 1.11.14 set. Their register 1.21 is filled with the
correct values, indicating 2.5G and 5G support.

PHYs 88X2110 do have their 1.11.14 bit set, as it should.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index f45ddf3bc138..0a35bf0fac47 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -251,7 +251,7 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	int ret;
+	int ret, val;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -265,6 +265,23 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
+	 * don't set bit 14 in PMA Extended Abilities (1.11), although they do
+	 * support 2.5GBASET and 5GBASET. Their 2.5/5G PMA Extended abilities
+	 * (1.21) still have a meaningful value, so read it anyway to make sure
+	 * we enable support for these modes if needed.
+	 */
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+		__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			  phydev->supported);
+	if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+		__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			  phydev->supported);
+
 	/* Make sure we advertise all the supported modes, and not just the
 	 * default one specified in the driver's .features.
 	 */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
