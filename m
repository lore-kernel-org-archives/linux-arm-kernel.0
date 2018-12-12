Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC714C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749B32084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hn4q2jkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749B32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UJNgQhApl42QY28XiCNrK9WDr8RHFcfEtyCyFS3AumU=; b=Hn4q2jkXOChkKa
	5clChey0+WWPlj5EME6eviVn6frWYTnAm9JSPUAn2hQvqZPkDs/QRgElzpv4DykBjxFqgtj2AIkUh
	BUEWe8K+agUzQP7rkgnFz44Ev9cCN4rYZEcBFrWBG5UGsw0LCr/mNjXv8jb67olLkZxeH6WuqRhwG
	9SE+6C5hFVJWpKEgrgoQSmxd4P1FwE/eO3mxl99Psdd32BlIHlUKgEJmtaKiDwRfY1oglEHVqDi8W
	i4Wf0KnJ81R3pBQEJEFRy1U5SxaiymZVMVqovnryOlYWSq0uUm2cz5xjDedsUWzP1uPhpC3vk/ths
	wG4tSwkF81re4/3WH+rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1fM-0000NW-ND; Wed, 12 Dec 2018 10:22:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1eW-00086P-SB
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:22:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 073A620734; Wed, 12 Dec 2018 11:21:55 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 905FB2073D;
 Wed, 12 Dec 2018 11:21:44 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 02/12] PCI: aardvark: Add reset GPIO support
Date: Wed, 12 Dec 2018 11:21:32 +0100
Message-Id: <20181212102142.16053-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022205_435825_05EB75A2 
X-CRM114-Status: GOOD (  14.11  )
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

The IP supports a reset GPIO. When S2RAM will be added, we must ensure
the reset line (if any) is deasserted when resuming. Add support for
it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b95eb2aa00bb..1d31d74ddab7 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -17,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
@@ -201,6 +203,7 @@ struct advk_pcie {
 	u16 msi_msg;
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
+	struct gpio_desc *reset_gpio;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -973,6 +976,55 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	return err;
 }
 
+static int advk_pcie_hard_reset(struct advk_pcie *pcie)
+{
+	if (!pcie->reset_gpio)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+	msleep(1);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	return 0;
+}
+
+static int advk_pcie_setup_reset_gpio(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	enum of_gpio_flags of_flags;
+	unsigned long gpio_flags;
+	int gpio_nb;
+	int ret;
+
+	gpio_nb = of_get_named_gpio_flags(dev->of_node, "reset-gpios", 0,
+					  &of_flags);
+	if (gpio_nb == -EPROBE_DEFER)
+		return gpio_nb;
+
+	/* Old bindings miss the reset GPIO handle */
+	if (!gpio_is_valid(gpio_nb)) {
+		dev_warn(dev, "Reset GPIO unavailable\n");
+		return 0;
+	}
+
+	if (of_flags & OF_GPIO_ACTIVE_LOW)
+		gpio_flags = GPIOF_ACTIVE_LOW |
+			     GPIOF_OUT_INIT_LOW;
+	else
+		gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+	ret = devm_gpio_request_one(dev, gpio_nb, gpio_flags,
+				    "pcie-aardvark-reset");
+	if (ret) {
+		dev_err(dev, "Failed to retrieve reset GPIO (%d)\n", ret);
+		return ret;
+	}
+
+	pcie->reset_gpio = gpio_to_desc(gpio_nb);
+
+	return 0;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1008,6 +1060,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_reset_gpio(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_hard_reset(pcie);
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
