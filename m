Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8384C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844B72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="conUIWy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwwmaGx9GqtmkBIa0ujp74yRIgpOFYL2fmXpKRo4dBI=; b=conUIWy7rEv+Jm
	xJQZkgwqH7TS2h/nDzprUIWxr61/lQN7PLLtfYwYVcRwPx1iqbezKgQ2WTu5/fok2rH2g4Y6CCGDy
	id0i7iSWtlfxXMBbERsvIBJFc/3NLQ/04f/F9oRjfzFPvVxfffdR49WOJ9mwhncJL7GDQgK9SLSpu
	AkkU3+VRROwvrhK9895WIrdJEq82rYfFQ1N6xXBOAXjFrUPP6aVwNSQBkdxsczuRvsnlfx0L5xEKe
	/1JiZDCMOdSGlG+Dy5Ln0XHUVYIM1xVwnXh7EimXfy3ORUKoaQkbTFduDIwuJYLuFq2jedfNWLcGD
	c+d6dmHk3Q2jcz1ZgOVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1ek-0008I8-Ps; Wed, 12 Dec 2018 10:22:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1eW-000876-VF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:22:06 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B659220DC3; Wed, 12 Dec 2018 11:22:03 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5298B2082C;
 Wed, 12 Dec 2018 11:21:45 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 04/12] PCI: aardvark: Add clock support
Date: Wed, 12 Dec 2018 11:21:34 +0100
Message-Id: <20181212102142.16053-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022205_229096_9AC203F7 
X-CRM114-Status: GOOD (  14.28  )
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

The IP relies on a gated clock. When we will add S2RAM support, this
clock will need to be resumed before any PCIe registers are
accessed. Add support for this clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index da695572a2ed..108b3f15c410 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -8,6 +8,7 @@
  * Author: Hezi Shahmoon <hezi.shahmoon@marvell.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -190,6 +191,7 @@
 
 struct advk_pcie {
 	struct platform_device *pdev;
+	struct clk *clk;
 	void __iomem *base;
 	struct list_head resources;
 	struct irq_domain *irq_domain;
@@ -1083,6 +1085,29 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
 	return ret;
 }
 
+static int advk_pcie_setup_clk(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int ret;
+
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk) && (PTR_ERR(pcie->clk) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->clk);
+
+	/* Old bindings miss the clock handle */
+	if (IS_ERR(pcie->clk)) {
+		dev_warn(dev, "Clock unavailable (%ld)\n", PTR_ERR(pcie->clk));
+		pcie->clk = NULL;
+		return 0;
+	}
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		dev_err(dev, "Clock initialization failed (%d)\n", ret);
+
+	return ret;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1118,6 +1143,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_clk(pcie);
+	if (ret)
+		return ret;
+
 	ret = advk_pcie_setup_phy(pcie);
 	if (ret)
 		return ret;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
