Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1FBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5392087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PTjXBiT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5392087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggoPXyMS2XByEi3LpTR4/CJNiGdtdTT4bsda51PsJnI=; b=PTjXBiT3uDjRi5
	YsLf+mmnF5v95wu6VnAl7cLljOGbA7p/mDJQ1T17ssBXquU73My970WUmMhHs3UHI+07hgpwIQdXL
	JpbJVuxx05PZZcXhMjVvSik3nrco8YCmEZLR4/s/ej/3KNGsPHsOdiJKSQ9cvwNrwWRxK93quxkkX
	o7nAVB5OZYEQfky6owkWttMRO2pMBVfxtkc/vU6Z3QwYYL6ehfvPNreRegBCmddRZN83UUqRPTKJt
	kcZpzeYsd2JjJaldJQPrkWpACeaedq1ABuPpAHiOp9xgdzEa5c3aO1AQ3ocdIwTtRDhZdKPVayMXd
	z5o6HfCfnffGrU+FfrAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7Il-0004dv-2q; Thu, 31 Jan 2019 08:02:23 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7IU-0004MQ-MK; Thu, 31 Jan 2019 08:02:08 +0000
X-UUID: ad15115ab86040e2bf553cdbecc269a5-20190131
X-UUID: ad15115ab86040e2bf553cdbecc269a5-20190131
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1172755802; Thu, 31 Jan 2019 00:01:59 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 00:01:58 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 16:01:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:01:57 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] PCI: mediatek: Enlarge PCIe2AHB window size to support
 4GB DRAM
Date: Thu, 31 Jan 2019 16:01:53 +0800
Message-ID: <1548921713-5355-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000206_894983_799D4367 
X-CRM114-Status: UNSURE (   8.55  )
X-CRM114-Notice: Please train this message.
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
Cc: youlin.pei@mediatek.com, poza@codeaurora.org, fred@fredlawl.com,
 rafael.j.wysocki@intel.com, jianjun.wang@mediatek.com,
 Honghui Zhang <honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The PCIE_AXI_WINDOW0 defines the translate window size for the request
from EP side. Request outside of this window will be treated as
unsupported request.

Enlarge this window size from fls(0xffffffff) to 2^33 to support 8GB
translate address range then EP DMA is capable of fully access 4GB
DRAM range(physical DRAM is start from 0x40000000).

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 01126b8..60326c4 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -90,6 +90,12 @@
 #define AHB2PCIE_SIZE(x)	((x) & GENMASK(4, 0))
 #define PCIE_AXI_WINDOW0	0x448
 #define WIN_ENABLE		BIT(7)
+/*
+ * Define PCIe to AHB window size as 2^33 to support max 8GB address space
+ * translate, support least 4GB DRAM size access from EP DMA(physical DRAM
+ * start from 0x40000000).
+ */
+#define PCIE2AHB_SIZE	0x21
 
 /* PCIe V2 configuration transaction header */
 #define PCIE_CFG_HEADER0	0x460
@@ -713,7 +719,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
 
 	/* Set PCIe to AXI translation memory space.*/
-	val = fls(0xffffffff) | WIN_ENABLE;
+	val = PCIE2AHB_SIZE | WIN_ENABLE;
 	writel(val, port->base + PCIE_AXI_WINDOW0);
 
 	return 0;
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
