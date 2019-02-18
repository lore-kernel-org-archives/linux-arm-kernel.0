Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F39C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E04C218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OcHgNhm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E04C218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bYwLj+lOvwEo0QU012PHcf9ODZVXnLo5dzphWKMOaQ0=; b=OcHgNhm7kCc+IBggK1CSuIMyhu
	Wu91AtlIzUiVK8l4QOhsMXnTSDa2S95Mlf0icukuBP+eskGRj7Qy8zvlfDd6jnwvCLM+OHON68STG
	RXoXF5vGN+mDM3xyuNlMIfmU0NWbsUL+7TiSdHTTkjCUf+mQVKeSLNzsrijKa1rNfw4uDANE3B2oQ
	b+9CNGd3zvG2HVygsDV72ClzhSK9h0M98qU3TRkPwtbJjpzQ+LcniQIwkmEgS7j5WYTXqSFmYupdL
	e8pJ5dVzlsAmSlKyxWqpiZGH6RQpfccsscTATRIFUKdwLMEcpm2QWA5KPuE98WBnEbFpbuWY0KzN7
	4rqH79/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfeL-000721-6o; Mon, 18 Feb 2019 09:55:45 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfbg-0002iB-8N
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:53:12 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 096AF200400;
 Mon, 18 Feb 2019 10:52:59 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A118B2000EA;
 Mon, 18 Feb 2019 10:52:51 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 669B740307;
 Mon, 18 Feb 2019 17:52:42 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, Zhiqiang.Hou@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
 kishon@ti.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org,
 l.subrahmanya@mobiveil.co.in, arnd@arndb.de, Minghuan.Lian@nxp.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] misc: pci_endpoint_test: Add the layerscape PCIe GEN4 EP
 device support
Date: Mon, 18 Feb 2019 17:46:43 +0800
Message-Id: <20190218094643.2692-6-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190218094643.2692-1-xiaowei.bao@nxp.com>
References: <20190218094643.2692-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015300_464011_8856649C 
X-CRM114-Status: UNSURE (   8.96  )
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
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the layerscape PCIE GEN4 EP device support in pci_endpoint_test driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
 drivers/misc/pci_endpoint_test.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 896e2df..8c3435b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -789,6 +789,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x8d80) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
