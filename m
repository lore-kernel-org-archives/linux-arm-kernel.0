Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89155218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vd/RISKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89155218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qhtfKsbwi3aKAplkiglm+dqkmoviaAdnMENz83UAa4c=; b=Vd/RISKLoNafAK8vzwawoU/+YV
	L4aJwkaIZ+7UpMJ7hhilVPhxUaCVY1Xdjn/IKww3nY77V90rghgsyKOBuMmk1jWLEHNujC2vszghX
	BQiAIToMo1EQYtePZ7tI5RczdF8TZBvS6rxlw8rbN9+sG4TJmaczNLfk+Aob5SSZoJF7Zf315y8ra
	VmCUzNoKe4vMSjW7Iw4zvccJiOO9KiPJbJv2c1ZWI0REnpK9PivWcSH8+lLaOTxSim6lLSUyenY4o
	y4uP4Bo32N+InLuww5XpwVJ7nEVCJi5YLXc60WECgCLJCAdJ/UkzubRxoIsTmBha6U30+bUIKmkUM
	iOKZD8Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyr2e-00065S-Le; Wed, 27 Feb 2019 04:42:00 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyr1b-0004no-0W; Wed, 27 Feb 2019 04:40:59 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 69CC474E1EE0FF3A0483;
 Wed, 27 Feb 2019 12:40:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1R4em8h003706;
 Wed, 27 Feb 2019 12:40:48 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022712410885-2029139 ;
 Wed, 27 Feb 2019 12:41:08 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: benh@kernel.crashing.org
Subject: [PATCH 5/8] PCI: aardvark: fix a leaked reference by adding missing
 of_node_put
Date: Wed, 27 Feb 2019 12:40:40 +0800
Message-Id: <1551242443-27300-5-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-27 12:41:09,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:40, Serialize complete at 2019-02-27 12:40:40
X-MAIL: mse01.zte.com.cn x1R4em8h003706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_204055_534510_505C4511 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: heiko@sntech.de, hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, minghuan.Lian@nxp.com, paulus@samba.org,
 thomas.petazzoni@bootlin.com, Wen Yang <wen.yang99@zte.com.cn>,
 ryder.lee@mediatek.com, mpe@ellerman.id.au, kishon@ti.com,
 linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, wang.yi59@zte.com.cn, rjui@broadcom.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 tyreld@linux.vnet.ibm.com, matthias.bgg@gmail.com, linux-omap@vger.kernel.org,
 mingkai.hu@nxp.com, roy.zang@nxp.com, sbranden@broadcom.com,
 yamada.masahiro@socionext.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/pci-aardvark.c:826:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 798, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c..56ecb16 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -794,6 +794,7 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 	struct irq_chip *irq_chip;
+	int ret = 0;
 
 	pcie_intc_node =  of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
@@ -806,8 +807,8 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
 					dev_name(dev));
 	if (!irq_chip->name) {
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_node;
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
@@ -819,11 +820,13 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 				      &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_node;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(pcie_intc_node);
+	return ret;
 }
 
 static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
