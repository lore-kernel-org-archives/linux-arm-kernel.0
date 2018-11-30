Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DF220868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eyThPPmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DF220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6XTn0Mc1XUt+95qj9Ei4vW7udWZUiyOXvdl9CmL+rlE=; b=eyThPPmkcOHhgI
	OLI4INQtXvPSIa4q7g9P1lrGRztzem+l49lRYzq5yuqMtuajmuxdK5cDfCTKqqONsRMMGPQuH8yCH
	t9dC/XdQdi/dhGN0/42o6J3UQmoDiEpVTGpb37Lq+2UcriYMUZ8BwzMRc3YTVTIKJODWx7Np43WvY
	eXsWkljMVnEiz3jJKZ7O69qx71xOinKOYIZqu1HSMAProAGB5Umilc7eEe9DeeOjqTn+LIz/p+Zoa
	4P4bm+i6iPAkj47rzyy1kst04DCBvB8zoO6kq8P8ZzFEg3onITnyRgPXx3cchfgpa+9JC8EIB5mGE
	1UCHpoHGD1Cp8NZZ6V1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSZYy-0001NO-Cx; Fri, 30 Nov 2018 03:33:56 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZYu-0001Mk-4K; Fri, 30 Nov 2018 03:33:54 +0000
X-UUID: dcebd37cea2d480980931bf9e712db21-20181130
X-UUID: dcebd37cea2d480980931bf9e712db21-20181130
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <honghui.zhang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1179112301; Fri, 30 Nov 2018 11:33:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Nov 2018 11:33:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Nov 2018 11:33:02 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v3] PCI: mediatek: Use devm_of_pci_get_host_bridge_resources()
 to parse DT
Date: Fri, 30 Nov 2018 11:33:00 +0800
Message-ID: <1543548780-3912-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_193352_425784_7F99D558 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 jianjun.wang@mediatek.com, honghui.zhang@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
DT parser.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 101 +++++++++------------------------
 1 file changed, 27 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2a1f97c..6917aec 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -197,29 +197,20 @@ struct mtk_pcie_port {
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
  * @free_ck: free-run reference clock
- * @io: IO resource
- * @pio: PIO resource
  * @mem: non-prefetchable memory resource
- * @busn: bus range
- * @offset: IO / Memory offset
  * @ports: pointer to PCIe port information
  * @soc: pointer to SoC-dependent operations
+ * @busnr: root bus number
  */
 struct mtk_pcie {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *free_ck;
 
-	struct resource io;
-	struct resource pio;
 	struct resource mem;
-	struct resource busn;
-	struct {
-		resource_size_t mem;
-		resource_size_t io;
-	} offset;
 	struct list_head ports;
 	const struct mtk_pcie_soc *soc;
+	unsigned int busnr;
 };
 
 static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
@@ -1045,55 +1036,43 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node, *child;
-	struct of_pci_range_parser parser;
-	struct of_pci_range range;
-	struct resource res;
 	struct mtk_pcie_port *port, *tmp;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+	struct resource_entry *win, *tmp_win;
+	resource_size_t io_base;
 	int err;
 
-	if (of_pci_range_parser_init(&parser, node)) {
-		dev_err(dev, "missing \"ranges\" property\n");
-		return -EINVAL;
-	}
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    windows, &io_base);
+	if (err)
+		return err;
 
-	for_each_of_pci_range(&parser, &range) {
-		err = of_pci_range_to_resource(&range, node, &res);
-		if (err < 0)
-			return err;
+	err = devm_request_pci_bus_resources(dev, windows);
+	if (err < 0)
+		return err;
 
-		switch (res.flags & IORESOURCE_TYPE_BITS) {
+	/* Get the I/O and memory ranges from DT */
+	resource_list_for_each_entry_safe(win, tmp_win, windows) {
+		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-			pcie->offset.io = res.start - range.pci_addr;
-
-			memcpy(&pcie->pio, &res, sizeof(res));
-			pcie->pio.name = node->full_name;
-
-			pcie->io.start = range.cpu_addr;
-			pcie->io.end = range.cpu_addr + range.size - 1;
-			pcie->io.flags = IORESOURCE_MEM;
-			pcie->io.name = "I/O";
-
-			memcpy(&res, &pcie->io, sizeof(res));
+			err = devm_pci_remap_iospace(dev, win->res, io_base);
+			if (err) {
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
+					 err, win->res);
+				resource_list_destroy_entry(win);
+			}
 			break;
-
 		case IORESOURCE_MEM:
-			pcie->offset.mem = res.start - range.pci_addr;
-
-			memcpy(&pcie->mem, &res, sizeof(res));
+			memcpy(&pcie->mem, win->res, sizeof(*win->res));
 			pcie->mem.name = "non-prefetchable";
 			break;
+		case IORESOURCE_BUS:
+			pcie->busnr = win->res->start;
+			break;
 		}
 	}
 
-	err = of_pci_parse_bus_range(node, &pcie->busn);
-	if (err < 0) {
-		dev_err(dev, "failed to parse bus ranges property: %d\n", err);
-		pcie->busn.name = node->name;
-		pcie->busn.start = 0;
-		pcie->busn.end = 0xff;
-		pcie->busn.flags = IORESOURCE_BUS;
-	}
-
 	for_each_available_child_of_node(node, child) {
 		int slot;
 
@@ -1125,28 +1104,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	return 0;
 }
 
-static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
-{
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct list_head *windows = &host->windows;
-	struct device *dev = pcie->dev;
-	int err;
-
-	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
-	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
-	pci_add_resource(windows, &pcie->busn);
-
-	err = devm_request_pci_bus_resources(dev, windows);
-	if (err < 0)
-		return err;
-
-	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
 static int mtk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1169,11 +1126,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = mtk_pcie_request_resources(pcie);
-	if (err)
-		goto put_resources;
-
-	host->busnr = pcie->busn.start;
+	host->busnr = pcie->busnr;
 	host->dev.parent = pcie->dev;
 	host->ops = pcie->soc->ops;
 	host->map_irq = of_irq_parse_and_map_pci;
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
