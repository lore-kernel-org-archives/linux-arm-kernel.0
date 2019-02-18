Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2345CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E465F218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OrFid42F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E465F218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RchCB7gfAmXJmtWi8JGrhUEQ8amJQaLMp4gHNMfcLvM=; b=OrFid42FvKOupuRC/+1Lvi5MGy
	s+tI6T9ZwPK/XlVM1TuSDGLPzzIf4kvfOy816ZXwYou/HIG0nbuI0t3ehuF2n5AEtDDzDWJxnfsNi
	uaLaWCWJxOmZl1NSCc2TmDYgEYG5NA4GBgl66tmyOAqtAO3Wm0RkFoXEKUZMB2vDNMBZmv2hW6Z6+
	yzvPL9DRTKYkPcqH8a0nMWHIQGYFKAXgcfJsoq1ykUMJPZl22xjOjLQvWFjsSTaNiFVE+VA5eWrh6
	8QHsU7Mb7m3kBrjZBGsmFfAzj6OtqfQPKFaZTbJ7h6rrBaJ2iPXl3piLl/GVhyIMXWwM+iGhaCyrh
	3bbTuhnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfe9-0006mR-Em; Mon, 18 Feb 2019 09:55:33 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfbb-0002eH-R6
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:53:09 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A14D1A035A;
 Mon, 18 Feb 2019 10:52:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F08881A0051;
 Mon, 18 Feb 2019 10:52:46 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C1581402F1;
 Mon, 18 Feb 2019 17:52:37 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
 kishon@ti.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org,
 l.subrahmanya@mobiveil.co.in, arnd@arndb.de, Minghuan.Lian@nxp.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP Layerscape
 SoCs
Date: Mon, 18 Feb 2019 17:46:40 +0800
Message-Id: <20190218094643.2692-3-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190218094643.2692-1-xiaowei.bao@nxp.com>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015256_288136_79A88B92 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This PCIe controller is based on the Mobiveil GPEX IP, it work in EP
mode if select this config opteration.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
depends on: http://patchwork.ozlabs.org/project/linux-pci/list/?series=88754

 drivers/pci/controller/mobiveil/Kconfig            |   17 ++-
 drivers/pci/controller/mobiveil/Makefile           |    1 +
 .../controller/mobiveil/pci-layerscape-gen4-ep.c   |  166 ++++++++++++++++++++
 3 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index c037db6..16ee617 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -27,13 +27,24 @@ config PCIE_MOBIVEIL_PLAT
 	  for address translation and it is a PCIe Gen4 IP.
 
 config PCI_LAYERSCAPE_GEN4
-	bool "Freescale Layerscpe PCIe Gen4 controller"
+	bool "Freescale Layerscpe PCIe Gen4 controller in RC mode"
 	depends on PCI
 	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want PCIe Gen4 controller support on
-	  Layerscape SoCs. The PCIe controller can work in RC or
-	  EP mode according to RCW[HOST_AGT_PEX] setting.
+	  Layerscape SoCs. And the PCIe controller work in RC mode
+	  by setting the RCW[HOST_AGT_PEX] to 0.
+
+config PCI_LAYERSCAPE_GEN4_EP
+	bool "Freescale Layerscpe PCIe Gen4 controller in EP mode"
+	depends on PCI
+	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
+	depends on PCI_ENDPOINT
+	select PCIE_MOBIVEIL_EP
+	help
+	  Say Y here if you want PCIe Gen4 controller support on
+	  Layerscape SoCs. And the PCIe controller work in EP mode
+	  by setting the RCW[HOST_AGT_PEX] to 1.
 endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
index 4f520b7..cd907a7 100644
--- a/drivers/pci/controller/mobiveil/Makefile
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
 obj-$(CONFIG_PCIE_MOBIVEIL_EP) += pcie-mobiveil-ep.o
 obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
 obj-$(CONFIG_PCI_LAYERSCAPE_GEN4) += pci-layerscape-gen4.o
+obj-$(CONFIG_PCI_LAYERSCAPE_GEN4_EP) += pci-layerscape-gen4-ep.o
diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
new file mode 100644
index 0000000..dc3589d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe controller EP driver for Freescale Layerscape SoCs
+ *
+ * Copyright (C) 2018 NXP Semiconductor.
+ *
+ * Author: Xiaowei Bao <xiaowei.bao@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-mobiveil.h"
+
+struct ls_pcie_g4_ep {
+	struct mobiveil_pcie		*mv_pci;
+};
+
+#define to_ls_pcie_g4_ep(x)	dev_get_drvdata((x)->dev)
+
+static const struct of_device_id ls_pcie_g4_ep_of_match[] = {
+	{ .compatible = "fsl,lx2160a-pcie-ep",},
+	{ },
+};
+
+static void ls_pcie_g4_get_bar_num(struct mobiveil_pcie_ep *ep)
+{
+	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
+	u32 type, reg;
+	u8 bar;
+
+	ep->bar_num = BAR_5 + 1;
+
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+		type = csr_readl(mv_pci, reg) &
+		       PCI_BASE_ADDRESS_MEM_TYPE_MASK;
+		if (type & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			ep->bar_num--;
+	}
+}
+
+static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
+{
+	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+	enum pci_barno bar;
+	int win_idx;
+
+	ls_pcie_g4_get_bar_num(ep);
+
+	for (bar = BAR_0; bar < (ep->bar_num * ep->pf_num); bar++)
+		mobiveil_pcie_ep_reset_bar(mv_pci, bar);
+
+	for (win_idx = 0; win_idx < MAX_IATU_OUT; win_idx++)
+		mobiveil_pcie_disable_ob_win(mv_pci, win_idx);
+
+	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
+	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
+}
+
+static int ls_pcie_g4_ep_raise_irq(struct mobiveil_pcie_ep *ep, u8 func_no,
+				   enum pci_epc_irq_type type,
+				   u16 interrupt_num)
+{
+	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return mobiveil_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_EPC_IRQ_MSI:
+		return mobiveil_pcie_ep_raise_msi_irq(ep, func_no,
+						      interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return mobiveil_pcie_ep_raise_msix_irq(ep, func_no,
+						       interrupt_num);
+	default:
+		dev_err(&mv_pci->pdev->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static struct mobiveil_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = ls_pcie_g4_ep_init,
+	.raise_irq = ls_pcie_g4_ep_raise_irq,
+};
+
+static int __init ls_pcie_gen4_add_pcie_ep(struct ls_pcie_g4_ep *ls_pcie_g4_ep,
+					   struct platform_device *pdev)
+{
+	struct mobiveil_pcie *mv_pci = ls_pcie_g4_ep->mv_pci;
+	struct device *dev = &pdev->dev;
+	struct mobiveil_pcie_ep *ep;
+	struct resource *res;
+	int ret;
+	struct device_node *np = dev->of_node;
+
+	ep = &mv_pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	ret = of_property_read_u32(np, "max-functions", &ep->pf_num);
+	if (ret < 0)
+		ep->pf_num = 1;
+
+	ret = mobiveil_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init ls_pcie_g4_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mobiveil_pcie *mv_pci;
+	struct ls_pcie_g4_ep *ls_pcie_g4_ep;
+	struct resource *res;
+	int ret;
+
+	ls_pcie_g4_ep = devm_kzalloc(dev, sizeof(*ls_pcie_g4_ep), GFP_KERNEL);
+	if (!ls_pcie_g4_ep)
+		return -ENOMEM;
+
+	mv_pci = devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
+	if (!mv_pci)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	mv_pci->csr_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(mv_pci->csr_axi_slave_base))
+		return PTR_ERR(mv_pci->csr_axi_slave_base);
+
+	mv_pci->pdev = pdev;
+	ls_pcie_g4_ep->mv_pci = mv_pci;
+
+	platform_set_drvdata(pdev, ls_pcie_g4_ep);
+
+	ret = ls_pcie_gen4_add_pcie_ep(ls_pcie_g4_ep, pdev);
+
+	return ret;
+}
+
+static struct platform_driver ls_pcie_g4_ep_driver = {
+	.driver = {
+		.name = "layerscape-pcie-gen4-ep",
+		.of_match_table = ls_pcie_g4_ep_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(ls_pcie_g4_ep_driver, ls_pcie_g4_ep_probe);
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
