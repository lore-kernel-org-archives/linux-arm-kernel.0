Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7568B214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="So5xuHJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DcbuFZgX/JPJngNs6Ghxz7BgS6WvYtOUY4Q0/cqEh20=; b=So5xuHJ5xpfG5M
	dv37M1rC8KGAseAgcAeneK5vICMgsG1PWb/QooXPQX77Go+uOABOg5Pb70GSrysrT+KTWgsfV664k
	LrhHbQgl1PSb3AixUSOTGgYdMSxYm+Zm0R/iNF5wyetEcDqURQlXbW7vuGmssnU/c/OwV0OBBfzRt
	QLiRi0OVV9BX7AIonFA+pzUNqor+fs91mB/f545KjYqTv8XwwYu+kMVfr9gg6SWxC1ErKYPeVq7ca
	uKkwfpFDh//IifcneXz/G/z+i9qa8vuroKNgUhABICQU6WJyOb0x8X6Djvv0TE5a9k1Hq2ZuFg+4C
	q0GuSEc3LgQyFSEGjwgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZRY-0005lI-PS; Thu, 10 Jan 2019 12:28:16 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZRJ-0005a2-Jg
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:28:04 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 806E544087E;
 Thu, 10 Jan 2019 14:27:55 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date: Thu, 10 Jan 2019 14:26:22 +0200
Message-Id: <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042801_941649_2A8CC2EF 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: linux-pwm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
signal") added reset signal support. Reset is unconditionally asserted
and deasserted.

Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
NIC is in the PCIe slot.

It turns out that you can toggle the reset signal only once. Another
reset signal toggle makes access to PCI configuration registers stall
indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
boot.

Detect whether the bootloader changed the reset signal state using the
get_direction operation. If direction is output don't touch the reset
signal again. Otherwise, set direction to output and keep the reset
asserted.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

This patch depends on the mvebu get_direction implementation in the
patch #1 of this series. Since get_direction implementation is not a
pure fix it might be considered unfit for v5.0. In that case I'm OK with
reverting 3d71746c42 in v5.0 to fix the Macchiatobin regression, and
postpone this series to v5.1.
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b171b6bc15c8..132a86a1e1e7 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -257,12 +257,23 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
-	/* Get reset gpio signal and hold asserted (logically high) */
+	/* Get reset gpio signal, don't change its setting */
 	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_ASIS);
 	if (IS_ERR(pcie->reset_gpio)) {
 		ret = PTR_ERR(pcie->reset_gpio);
 		goto fail_clkreg;
+	} else if (pcie->reset_gpio &&
+			gpiod_get_direction(pcie->reset_gpio) == 0) {
+		/* Reset signal is output. The bootloader has deasserted reset
+		 * signal already. Don't do it again.
+		 */
+		dev_info(dev, "%s: leave reset signal unchanged\n", __func__);
+		devm_gpiod_put(dev, pcie->reset_gpio);
+		pcie->reset_gpio = NULL;
+	} else if (pcie->reset_gpio) {
+		/* Assert reset */
+		gpiod_direction_output(pcie->reset_gpio, 1);
 	}
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
