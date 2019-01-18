Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99461C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B9A20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MFW81atP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B9A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XFSN6yb5JOh1no36HcXTqJ1bmXKugLUbLMiPaoz8Rdo=; b=MFW81atPCE4InN
	90cYUc8sqPuRQqChl0UP1GyaEJGq03PjUoYUbxmTmjAJfaVB9LDjv6v18LpS5ATUlugL+9UoaSgUW
	So3yMu7LuUmiIACvRY4Z5kf729OmFNzxuuBR15A3bLcN8uPInSeIPgr6EKGT0x5FY4bmInRPK7miv
	X7PEp2YJMKA4xPOvs71bFqQSLK0OGrIvwEVuOiND3I4Aew6S00Ef1geXN6IN/ghE0cATjLl+5+F7w
	kSMZlVb8AIIE6eBuOPE/VSKAHpTsbfanqXwY1nAwGp0DxMO45qr9Mt0mf2gwTINjuEyz2NX6JA0r9
	+2UwIld/GjLq9f/hwEWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW0l-0000jv-7C; Fri, 18 Jan 2019 15:24:47 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0G-0000GJ-Or
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:20 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0FEEB207B0; Fri, 18 Jan 2019 16:24:14 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id A61B2207B6;
 Fri, 18 Jan 2019 16:24:03 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 3/7] net: phy: Read 2.5G and 5G extended abilities
Date: Fri, 18 Jan 2019 16:23:48 +0100
Message-Id: <20190118152352.26417-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072417_214535_5B8C52B7 
X-CRM114-Status: GOOD (  11.55  )
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

Register 1.21 "2.5G/5G PMA Extended abilities" contains the information
indicating whether or not 2.5GBASET and 5GBASET are supported by a PHY,
as per the 802.3bz specification.

If the bit 14 is set in the 1.11 "PMA Extended abilities" register, the
modes specified in the above-mentionned 1.21 register should be taken
into account.

This commit adds that logic into the genphy_c45_read_abilities function.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-c45.c | 14 ++++++++++++++
 include/uapi/linux/mdio.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61ca4f89e94a..ee32eba3dc20 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -377,6 +377,20 @@ int genphy_c45_read_abilities(struct phy_device *phydev)
 			__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
 				  supported);
 		}
+
+		if (val & MDIO_PMA_EXTABLE_NBT) {
+			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+					   MDIO_PMA_NG_EXTABLE);
+			if (val < 0)
+				return val;
+
+			if (val & MDIO_PMA_NG_EXTABLE_2_5GBT)
+				__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					  supported);
+			if (val & MDIO_PMA_NG_EXTABLE_5GBT)
+				__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+					  supported);
+		}
 	}
 
 	linkmode_copy(phydev->supported, supported);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index e2ab03606c1b..546509898867 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -45,6 +45,7 @@
 #define MDIO_AN_ADVERTISE	16	/* AN advertising (base page) */
 #define MDIO_AN_LPA		19	/* AN LP abilities (base page) */
 #define MDIO_PCS_EEE_ABLE	20	/* EEE Capability register */
+#define MDIO_PMA_NG_EXTABLE	21	/* 2.5G/5G PMA/PMD extended ability */
 #define MDIO_PCS_EEE_WK_ERR	22	/* EEE wake error counter */
 #define MDIO_PHYXS_LNSTAT	24	/* PHY XGXS lane state */
 #define MDIO_AN_EEE_ADV		60	/* EEE advertisement */
@@ -201,6 +202,7 @@
 #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
 #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
 #define MDIO_PMA_EXTABLE_10BT		0x0100	/* 10BASE-T ability */
+#define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
 
 /* PHY XGXS lane state register. */
 #define MDIO_PHYXS_LNSTAT_SYNC0		0x0001
@@ -272,6 +274,10 @@
 #define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
 #define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
 
+/* 2.5G/5G Extended abilities register. */
+#define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
+#define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
+
 /* LASI RX_ALARM control/status registers. */
 #define MDIO_PMA_LASI_RX_PHYXSLFLT	0x0001	/* PHY XS RX local fault */
 #define MDIO_PMA_LASI_RX_PCSLFLT	0x0008	/* PCS RX local fault */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
