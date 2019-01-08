Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:28:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACBF2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QKva9dLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACBF2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WKO3+eNGvAlY2bd0szuONmP1ztZowMSBaUePs+xkdrk=; b=QKva9dLMac/+iG
	wQ9mREJoYyn18dNESFBBjAI6wW/v7YFkgrZkduQTCQcJw96qQ+0uDrqoqF3YplayZAit8Sdbe3ljZ
	0D3Sc7Ka5/vJc9zaqhEPlGm7pAPl3EaLaZXQ9tqJj+tSC24zhjFb5N+NsWlOCQXt+zQerbZWc212v
	b7l1J0gaXUeFoqclUytNSGjEgaicxWFqFGibOxWUBqiu3TRUh9o+/SpLFgrKyX+WaGzFpGCXHg5kD
	OiMLgxaJlgl9IogRBv9Rm7X6CfpsHH4/fa/m7+SMMVMkW2mvcgKpf5DALw5frya7pkIwnldJPQWVe
	cCqb+V9hycpadG+g5dZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguEa-0005AS-Md; Tue, 08 Jan 2019 16:28:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguBM-0000bv-SI
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:24:53 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8E83B20A16; Tue,  8 Jan 2019 17:24:47 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2E93E209C2;
 Tue,  8 Jan 2019 17:24:47 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 07/15] PCI: aardvark: Add suspend to RAM support
Date: Tue,  8 Jan 2019 17:24:32 +0100
Message-Id: <20190108162441.5278-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082449_257818_658D561E 
X-CRM114-Status: GOOD (  14.98  )
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
 drivers/pci/controller/pci-aardvark.c | 45 ++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3fb14e37eb59..999bbe27761a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1028,7 +1028,7 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
 	return ret;
 }
 
-static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
+static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
@@ -1119,6 +1119,47 @@ static int advk_pcie_setup_reset_gpio(struct advk_pcie *pcie)
 	return 0;
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
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		return ret;
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
@@ -1133,6 +1174,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(dev, res);
@@ -1210,6 +1252,7 @@ static struct platform_driver advk_pcie_driver = {
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
