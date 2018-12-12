Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8381F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ux/ZkL0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8381F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H3C0tpl6cTwuk0MWZrw1zhfezPL5xWJ3jM+hAXUGi0w=; b=ux/ZkL0I5l5kfv
	2r4fO2pxtdVZYXJcqftpLWcdM70FMy+QY/vH6CeX4/nwMonkTLOzN5smFRXCOikkyiVnsP6liWwYv
	RShf96lA3UqK0qVtLF5zpT7ZTeOopCewxshiBr+ZM6pDAlk+x6x1E3eIsmu0MeamdNSh41Q2E8K5v
	x3ry/25S0WgEYD8pyejPxG7KP+tkRhLSW2Z9hueCrwAO+bCJOqsi8vcKBRuI9UqDPpAYYc+4G81/n
	3VTPyHzZ9kAoYGrDtzFgMeeToEpP9br+cnG/YDk1By7iyzUT+4cR6zUPogVts2nJZTNcCFUE0lPsn
	Xulf7U0J+rAuezOeIJIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1hR-0002bQ-4N; Wed, 12 Dec 2018 10:25:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1ej-00088d-66
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:22:35 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BF18F2082C; Wed, 12 Dec 2018 11:22:04 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id AC2E9208E3;
 Wed, 12 Dec 2018 11:21:45 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 05/12] PCI: aardvark: Add suspend to RAM support
Date: Wed, 12 Dec 2018 11:21:35 +0100
Message-Id: <20181212102142.16053-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022218_003457_E158C755 
X-CRM114-Status: GOOD (  15.32  )
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

Add suspend and resume callbacks. The priority of these are
"_noirq()", to workaround early access to the registers done by the
PCI core through the ->read()/->write() callbacks at resume time.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 108b3f15c410..7ecf1ac4036b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
 	return ret;
 }
 
+static int __maybe_unused advk_pcie_suspend(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+
+	advk_pcie_disable_phy(pcie);
+
+	clk_disable_unprepare(pcie->clk);
+
+	return 0;
+}
+
+static int __maybe_unused advk_pcie_resume(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * Empirical delay needed after enabling the clock and before
+	 * accessing any register.
+	 */
+	msleep(10);
+
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_hard_reset(pcie);
+
+	advk_pcie_setup_hw(pcie);
+
+	advk_sw_pci_bridge_init(pcie);
+
+	return 0;
+}
+
+/*
+ * The PCI core will try to reconfigure the bus quite early in the resume path.
+ * We must use the _noirq() alternatives to ensure the controller is ready when
+ * the core uses the ->read()/->write() callbacks.
+ */
+static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend,
+				      advk_pcie_resume)
+};
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1188,6 +1237,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_set_drvdata(dev, pcie);
+
 	return 0;
 }
 
@@ -1200,6 +1251,7 @@ static struct platform_driver advk_pcie_driver = {
 	.driver = {
 		.name = "advk-pcie",
 		.of_match_table = advk_pcie_of_match_table,
+		.pm = &advk_pcie_dev_pm_ops,
 		/* Driver unloading/unbinding currently not supported */
 		.suppress_bind_attrs = true,
 	},
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
