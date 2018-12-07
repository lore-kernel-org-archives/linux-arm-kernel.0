Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920EB20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUp/IZCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920EB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MNi6QGmu6yV/A3Xwhge8ipES1StTm4IxiEqDaQd2e3U=; b=nUp
	/IZCri3iPuj34uzmL04e7C3eKkkBkpScJ5Mk95vZuHq+m9CAr2noO5ntpLrWbrlHw/qjYDJUnhCcO
	sw4/er31FzYWdfuER4epsQTrlu4cBIj10zGQwQmeBCOFImLp7GDOgf+6bN/dbAnEcZeBMfW9/ytf6
	zEOUk6Tp4i2AFPu99gnOIHmBgni0VHQhRp1DQjOdivhr/saoWQTRqwxP3XIxbsloUIBLxRifyOaYX
	1eTwAALl4QiZWlIquGK3iDCoZX+uOcxiR8a8bQdTXpmgEn/xSRXD1r6yQvzZx5TCrU21PMVkgN82r
	Z5cIIvi5/BUSX2g9D8gwCIvu9CgjRNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV4Og-0004VL-1Q; Fri, 07 Dec 2018 00:53:38 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV4Oa-0004Sq-0E
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 00:53:36 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 07 Dec 2018 09:53:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6104660062;
 Fri,  7 Dec 2018 09:53:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 7 Dec 2018 09:53:17 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
 by kinkan.css.socionext.com (Postfix) with ESMTP id F34C41A1235;
 Fri,  7 Dec 2018 09:53:16 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 0/2] Add new UniPhier PCIe host driver
Date: Fri,  7 Dec 2018 09:53:10 +0900
Message-Id: <1544143992-16385-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_165332_152725_5F31C416 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: devicetree@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series adds PCIe host controller driver for Socionext UniPhier SoCs.
This controller is based on the DesignWare PCIe core. This driver
supports LD20 and PXs3 SoCs.

v4: https://www.spinics.net/lists/linux-pci/msg78278.html

About legacy IRQ, it might be necessary to share common view from
keystone driver that have been cleaned up[1].

[1] https://lore.kernel.org/patchwork/patch/989541/

Changes since v4:
- fix an issue of using the wrong value to mask IRQ mask register

Changes since v3:
- dt-bindings: fix INTX numbering of legacy interrupt map
- change interrupts to level ones
- remove .xlate function
- merge uniphier_pcie_ltssm_disable() into uniphier_pcie_ltssm_enable()
- remove an error message on uniphier_pcie_establish_link()
- change the order between irq_domain_add_liniear() and
  irq_set_chained_handler_and_data()
- replace dummy_irq_chip with uniphier_pcie_irq_chip and its functions
- add dependency on CONFIG_HAS_IOMEM
- MAINTAINERS: add pcie-uniphier entry

Changes since v2:
- dt-bindings: remove a comment that the node name isn't important
- dt-bindings: remove "intx" interrupt
- dt-bindings: define 'legacy-interrupt-controller' node and its properties
- return an error value when link up fails
- remove devm_request_irq() and a handler for MSI IRQ
- use chained interrupt instead of devm_request_irq() for legacy IRQ
- add unipher_pcie_config_legacy_irq() to get legacy IRQ from
  'legacy-interrupt controller' node
- replace 4 statments to handle INTX with for_each_set_bit()
- remove initialization of pp->root_bus_nr
- remove indivisual interrupt enable bit definitions
- rename 'irq_domain' member to 'legacy_irq_domain' in private structure
- use pci_irqd_intx_xlate() for irq_domain_ops.xlate function

Changes since v1:
- follow capitalization conventions in the descriptions
- use C style comments except for the SPDX line

Kunihiko Hayashi (2):
  dt-bindings: PCI: Add UniPhier PCIe host controller description
  PCI: uniphier: Add UniPhier PCIe host controller support

 .../devicetree/bindings/pci/uniphier-pcie.txt      |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier.c         | 471 +++++++++++++++++++++
 5 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
