Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE702080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aKEAggw6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PaBeUMaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE702080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u6jeCwGUMmgjSm2EGBikIWz2N5lvsMqJrmX1oA4yKBU=; b=aKEAggw6DmqJtD
	4axZdZ1eCjL3kPlviZOdxEl51VQ9oLCFCI9YQzGDQxQOaOyTsaVEU/kAkxSn1jrqR5EkWTHZGNthX
	TiTlcQdTbxuYWgw0sqHg/44kCtIZD5qLr/ROLnxf7ndnQxpzqJXfAvSJgHMZnByW11877k0PlLqYx
	PTVPyrEqrtmgE4cUxt4S//ooAqJtwODaPuq75kA1wys/cGaIymlHG7i5gmwIMLRLSsFr7swGpe9oK
	o4ycQgfUqAcHbVqpNHaexJJEzkSnJ3QgSZb2oPTwPvN/0Q2FXAYTwRDr117ktSH+bj8L1FbwMZLrh
	T/LWiUJRSosuOtG7ojfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbCU-0000Bl-M0; Wed, 19 Dec 2018 12:43:46 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbBZ-0007om-41
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:42:51 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgXcU126318;
 Wed, 19 Dec 2018 06:42:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545223353;
 bh=tUqtMhWdpAvQJvFjUSGA83BB/8fhxvBVfFQdnpC737Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PaBeUMaXd8/XPHx12/5eYnkTBusopQc1o98+U5Y/P9Q2LfqCS4uuWOKDNYdzb0k+3
 rYzLKq6Ras0uVMORaFtQqEQbyOJM05v9N3Zcy7hUo9A7nIWcOth70H7RAojgGCU3wr
 h+mJ2q8cei7MY1c2LtPmsiCbaJaqzPeyb5G0KDR0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgXxt051563
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:42:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZl003940;
 Wed, 19 Dec 2018 06:42:30 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 02/10] PCI: keystone: Use "dummy_irq_chip" instead of new
 irqchip for legacy interrupt handling
Date: Wed, 19 Dec 2018 18:11:59 +0530
Message-ID: <20181219124207.13479-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219124207.13479-1-kishon@ti.com>
References: <20181219124207.13479-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_044249_502632_AD625EFB 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 kishon@ti.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instead of creating a new irqchip with empty callback functions, use
dummy_irq_chip. Since there is nothing to do in the irqchip callback
functions, use handle_simple_irq instead of handle_level_irq.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 24 ++---------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5286a480f76b..1ef443009da5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -266,31 +266,12 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_pcie_ack_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_pcie_mask_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
-{
-}
-
-static struct irq_chip ks_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_pcie_ack_legacy_irq,
-	.irq_mask = ks_pcie_mask_legacy_irq,
-	.irq_unmask = ks_pcie_unmask_legacy_irq,
-};
-
 static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
 				       unsigned int irq,
 				       irq_hw_number_t hw_irq)
 {
-	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
-				 handle_level_irq);
+	irq_set_chip_and_handler(irq, &dummy_irq_chip,
+				 handle_simple_irq);
 	irq_set_chip_data(irq, d->host_data);
 
 	return 0;
@@ -298,7 +279,6 @@ static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
 
 static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
 	.map = ks_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
 };
 
 /**
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
