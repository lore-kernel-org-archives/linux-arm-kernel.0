Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32327C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A3B2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A3sl9ttt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A3B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R8sTTbwzfhs/GkYrnZdCThEMIoSfQ+Wing4n0iMxv9M=; b=A3sl9ttt8I4nR5
	rLq0W80kmBManEM06K8AA/oZwxDFTnjHhhusrwsnGQphlO40vaTVlmdItjqfQCSBqitpyUOiaFXon
	HrF17LN05BWCcsWD6N/45f8+N/Ct+g46ZI0+1SzxIXP6A04nTES1nW6rvyKbXEFoQ68ohnmv5kQaT
	yOZy2O5Hl9tG/d9WokiRa5CKL6MElxOwyfhJ5UFfvrWLfWkX1z0n67wVBuVq1WjFa57n7eEHegtVU
	stErTbFVj/iAZNFIVRtXRga3mlpTdypIaOYWJgMgtEA+xCp4xPJVbJtWxusA97hpgCB0h/F3hVDgI
	E+cMrrcgli0Iof5fsBTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyItj-00041z-W6; Mon, 25 Feb 2019 16:14:32 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIta-0003sk-9x
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:14:24 +0000
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 57AD8E000D;
 Mon, 25 Feb 2019 16:14:10 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 0/2] net: phy: marvell10g: Clean .get_features by
 using C45 helpers
Date: Mon, 25 Feb 2019 17:14:05 +0100
Message-Id: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_081422_506805_F6F6F6AF 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

Recent work on C45 helpers by Heiner made the
genphy_c45_pma_read_abilities function generic enough to use as a
default .get_featutes implementation.

This series removes the remaining redundant code in
mv3310_get_features(), and makes the 2110 PHY use
genphy_c45_pma_read_abilities() directly, since it doesn't have the
issue with the wrong abilities being reported.

Maxime Chevallier (2):
  net: phy: marvell10g: Let genphy_c45_pma_read_abilities set Aneg bit
  net: phy: marvell10g: Use the generic C45 helper to read the 2110
    features

 drivers/net/phy/marvell10g.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
