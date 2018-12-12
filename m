Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F352C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D184A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6j9rjJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q20+ZyAR1eKNkIOrx6ZY03gSzLTGhCKPFpT33y9mQZc=; b=F6j9rjJt8N1L6f
	DuicUK+d2V1L56dZ7VGHPhhj+xN1V/EOX8BC8/mNs5gPCQH4RexLaJKzBT4WT+ZEl/cCxRmgJZ5kP
	POmfTTDRENeJU04qVvIjPH30Vh5UdcwqwTDJv3JgGorxkaHekGWQIQJwe3IFaOFkWbTIMyMZdmtBt
	4v6x8nA9mDiUHg+CJ/i1uyCJZLNsZDF5bsAbpNyh4d6MwKUR/yaSplNJM/0vHJsTxAAr21MuGF7CU
	Xvy3TsUEEXW+UVngl3Swgs5oV2pOqCWKGE0GfjE0QUmQns2Jgo6fTK9XIZWPAZlBimO+766fSWpf4
	yKYYpPt/LuIxcyu6dBYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1ea-00088v-Ry; Wed, 12 Dec 2018 10:22:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1eW-00086O-S8
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:22:06 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A3F6A20D92; Wed, 12 Dec 2018 11:21:54 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3328E20734;
 Wed, 12 Dec 2018 11:21:44 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 01/12] PCI: aardvark: Configure more registers in the
 configuration helper
Date: Wed, 12 Dec 2018 11:21:31 +0100
Message-Id: <20181212102142.16053-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022205_047910_920E0CC6 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mimic U-Boot configuration to be sure all hardware registers are set
properly. This will be needed for future S2RAM operation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..b95eb2aa00bb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -100,6 +100,8 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_PHY_REFCLK				(CONTROL_BASE_ADDR + 0x14)
+#define     PCIE_PHY_REFCLK_BUF_CTRL		0x1342
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
@@ -243,6 +245,9 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	/* Set HW Reference Clock Buffer Control */
+	advk_writel(pcie, PCIE_PHY_REFCLK_BUF_CTRL, PCIE_PHY_REFCLK);
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -274,6 +279,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
+	/* Set PCIe Device Control and Status 1 PF0 register */
+	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
+		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE;
+	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+
+	/* Program PCIe Control 2 to disable strict ordering */
+	reg = PCIE_CORE_CTRL2_RESERVED | PCIE_CORE_CTRL2_TD_ENABLE;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+
 	/* Set GEN2 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
