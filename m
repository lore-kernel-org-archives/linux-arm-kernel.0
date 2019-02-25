Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E18B2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r680hz/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E18B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LgkeAV/LG4nNWMsJblImfjMjYGVgBFQun2p3ulKQYN8=; b=r680hz/XB4epoF
	RrnbC8zGOREefy4pV0ZhO+v1Of9WdnjFy7YT5hMBA/U3oS2sByAQcQwmTfoxUdJP2AlMDiQyFp0/O
	nQr7AWORvHgqGDCpJQZfbs/knWB5DE//oqIwgJIuG4zg4z+kLOcIBFDo5wUy3lJFhzakYhMDVb/KL
	d8nRzFQaqr+l4cxLnXWc5V0nOgV5aSfd8BLDTQX8jqkvpEPDfObJhqWujSJvUv7iKOSl8StZDGus2
	6KRTbxvVTPGXwyg/rJpCcQVw873FEQgC5KeVVhjKU4HwEPQSfgHqpcOVyqx9k1PrTlnneF5yNMmQU
	MPZG/gYauHGO4ijctDTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyItu-0004JG-WF; Mon, 25 Feb 2019 16:14:43 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIta-0003sl-9X
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:14:24 +0000
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B4019E0008;
 Mon, 25 Feb 2019 16:14:15 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 2/2] net: phy: marvell10g: Use the generic C45 helper
 to read the 2110 features
Date: Mon, 25 Feb 2019 17:14:07 +0100
Message-Id: <20190225161407.19510-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
References: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_081422_475976_DE4C6631 
X-CRM114-Status: GOOD (  11.85  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Contrary to the 3310, the 2110 PHY correctly reports it's 2.5G/5G
abilities. We can therefore use the genphy_c45_pma_read_abilities helper
to build the list of features.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index ab71da55c1e0..79106e70010f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -472,7 +472,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.phy_id		= MARVELL_PHY_ID_88E2110,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x2110",
-		.features	= PHY_10GBIT_FEATURES,
+		.get_features	= genphy_c45_pma_read_abilities,
 		.probe		= mv3310_probe,
 		.soft_reset	= gen10g_no_soft_reset,
 		.config_init	= mv3310_config_init,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
