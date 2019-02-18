Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D972D218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djwDtFx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D972D218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Fv1AnJsfszjENP3oelPJ+dOkMIuRzpwwGlJLSHS/ATw=; b=djwDtFx2Ng917Y5FhK4KOHF8Un
	+vbRzqemMKWmbC3mkj0nk7a8k7+BX7yHzUoAkgn2i/CB/F+LLemt00Jw/QJy2Ay2R3C+KpH8wDzUm
	ugvpimpqSWarJ8mF9tpxwGX+6J44w9LB1xLbW9Eh0WzMDRbBIFF8hzcFMSm/kUIm56ktdCH1J1wCG
	PCuGYrcCIJkNizkasFWP1x/hkar26Ovcbb94eTbRljN42pRtIvdbmMdwVcIHfkCrTCg6ws+qLmxNR
	eetIDj7ymYqGlFCFHrcjQxcF8aILiu+ue7qZA4TCWFr8qsdpJdo7R4IVxNJqzcRTd5gWIrQIRNoy1
	Fr1Dgobg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfdy-0006ZO-BM; Mon, 18 Feb 2019 09:55:22 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfbd-0002fp-AL
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:53:07 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA0411A006C;
 Mon, 18 Feb 2019 10:52:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C0B31A0094;
 Mon, 18 Feb 2019 10:52:48 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C536402CA;
 Mon, 18 Feb 2019 17:52:39 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
 kishon@ti.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org,
 l.subrahmanya@mobiveil.co.in, arnd@arndb.de, Minghuan.Lian@nxp.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] PCI: mobiveil: Add workaround for unsupported request
 error
Date: Mon, 18 Feb 2019 17:46:41 +0800
Message-Id: <20190218094643.2692-4-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190218094643.2692-1-xiaowei.bao@nxp.com>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015257_564897_A0F6DB96 
X-CRM114-Status: GOOD (  10.39  )
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

Errata: unsupported request error on inbound posted write
transaction, PCIe controller reports advisory error instead
of uncorrectable error message to RC.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
depends on: http://patchwork.ozlabs.org/project/linux-pci/list/?series=88754

 .../controller/mobiveil/pci-layerscape-gen4-ep.c   |   14 +++++++++++++-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |    4 ++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
index dc3589d..3d980f5 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4-ep.c
@@ -51,7 +51,19 @@ static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
 	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
 	enum pci_barno bar;
-	int win_idx;
+	int win_idx, val;
+
+	/*
+	 * Errata: unsupported request error on inbound posted write
+	 * transaction, PCIe controller reports advisory error instead
+	 * of uncorrectable error message to RC.
+	 * workaround: set the bit20(unsupported_request_Error_severity) with
+	 * value 1 in uncorrectable_Error_Severity_Register, make the
+	 * unsupported request error generate the fatal error.
+	 */
+	val =  csr_readl(mv_pci, CFG_UNCORRECTABLE_ERROR_SEVERITY);
+	val |= 1 << UNSUPPORTED_REQUEST_ERROR_SHIFT;
+	csr_writel(mv_pci, val, CFG_UNCORRECTABLE_ERROR_SEVERITY);
 
 	ls_pcie_g4_get_bar_num(ep);
 
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 275c68f..7dc2a12 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -120,6 +120,10 @@
 #define GPEX_BAR_SIZE_UDW                       0x4DC
 #define GPEX_BAR_SELECT                         0x4E0
 
+#define CFG_UNCORRECTABLE_ERROR_SEVERITY	0x10c
+#define UNSUPPORTED_REQUEST_ERROR_SHIFT		20
+#define CFG_UNCORRECTABLE_ERROR_MASK		0x108
+
 /* starting offset of INTX bits in status register */
 #define PAB_INTX_START			5
 
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
