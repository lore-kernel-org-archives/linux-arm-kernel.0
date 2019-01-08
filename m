Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D397BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B462087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CHTFXJZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B462087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jZEuuIrYLwVo/Pos8EHh6ztzXvvTmEpLgoBeOz6C/eI=; b=CHTFXJZZEAN6gF
	+eYKH4w5Ln/1qPPecEBRzQaceMFWHUq+pag1ke1M0TVO34zw9yne1GWRWL7ABXnu4NnpjYoAoVTXk
	oxw2k3FPaON2J04sJhARri3n/IsMm/W59kCE0N+PxvMjMVhVBiyR/HWLjzgE0ko31nfC+a4sfokxj
	/Y2KqT9/yzj6FP7OASltI/3wLLMznAJvO0O9sAfg8hr1Nl5hifq3zhtwdZn5JsN+VMmdZ3pyH8uQT
	orG/Heth8PGWvAIWtMzZlvKCR/vO/norTv3bMmJaZkxm6lZ8Yaav9Y981lWJSQz1Z5fUpwyAsTaiR
	sMcho0oKTlYgs7tsR+oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguCB-0002g5-VR; Tue, 08 Jan 2019 16:25:39 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguBM-0000bt-OC
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:24:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CFCE720A13; Tue,  8 Jan 2019 17:24:46 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 74101209C2;
 Tue,  8 Jan 2019 17:24:46 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 05/15] PCI: aardvark: Add PCIe warm reset support
Date: Tue,  8 Jan 2019 17:24:30 +0100
Message-Id: <20190108162441.5278-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082448_922509_F71DDE5C 
X-CRM114-Status: GOOD (  13.11  )
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

Make use of the 'warm reset' register to ensure every peace of
hardware (core, phy, endpoint card) are in a known state before doing
the hardware setup.

The Aardvark IP can trigger a reset signal upon hot reset or link
failure that will only reach the components on the board without
affecting the entire device (eg. only the endpoint card). This line is
multiplexed on MPPs so if it is not used as PCI reset and multiplexed
for instance as a GPIO, the signals produced by the PCIe IP during the
warm reset operation won't affect the state of the line.

As usual, hardware designers can implement a card reset wired to a
GPIO. Support for such reset GPIO will be added in another patch.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 27ec79defa57..cfe48e553bca 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -139,6 +139,10 @@
 #define     CTRL_MODE_MASK			0x1
 #define     PCIE_CORE_MODE_DIRECT		0x0
 #define     PCIE_CORE_MODE_COMMAND		0x1
+#define CTRL_WARM_RESET_REG			(CTRL_CORE_BASE_ADDR + 0x4)
+#define     CTRL_PCIE_CORE_WARM_RESET		BIT(0)
+#define     CTRL_PHY_CORE_WARM_RESET		BIT(1)
+#define     CTRL_PERSTN_GPIO_EN			BIT(3)
 
 /* PCIe Central Interrupts Registers */
 #define CENTRAL_INT_BASE_ADDR			0x1b000
@@ -249,6 +253,19 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	/* Warm reset */
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	reg |= CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET |
+	       CTRL_PERSTN_GPIO_EN;
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	mdelay(1);
+	reg &= ~(CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET |
+		 CTRL_PERSTN_GPIO_EN);
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	mdelay(10);
+
 	/* Set HW Reference Clock Buffer Control */
 	advk_writel(pcie, PCIE_PHY_REFCLK_BUF_CTRL, PCIE_PHY_REFCLK);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
