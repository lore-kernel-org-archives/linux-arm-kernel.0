Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADAC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACB520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P+DNuZ6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACB520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=enoP2qKkqjGltn/5Knp8HhIKtQTIHVtj3hWo62NLss8=; b=P+DNuZ6nMtmKGH
	sLDKt3ZmUbo9b0tHepThW8EnxQRAu80LXSG89pRu6QFIAEdsn/HQ8J0OUSEkUVw89yRFv3eto5dsz
	jVQ60fm9t3rX1OTA62i1Lnfkotf3BheMA/+8zbI2V5hMFDxI61JQa7/P34d7PMQ49X6I0MUnZ0V6f
	jfZaiUsdaIT54qfedaWZzyJzc8Z8k/0SveP5XxYz3fWjcdGtNkwSqyqIXbVT3uvSbgih325zvQKMQ
	F7nbsJS7zi1QmxBUcIsLOb4xda2VpNeJvn0uRkb29JpD49zSmFyA1QQueXfwoPfsQGkFt73GV4hdm
	6BFUYQsXa4ddzHjlLNMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpRVd-00051K-2a; Fri, 01 Feb 2019 05:37:01 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpRV1-0004Qh-EM; Fri, 01 Feb 2019 05:36:28 +0000
X-UUID: 89f47488da6d4edca29b81f3d7c88f6e-20190131
X-UUID: 89f47488da6d4edca29b81f3d7c88f6e-20190131
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 880612553; Thu, 31 Jan 2019 21:36:21 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 21:36:19 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 13:36:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 13:36:10 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v3 1/2] PCI: mediatek: Enable the whole memory mapped IO range
Date: Fri, 1 Feb 2019 13:36:06 +0800
Message-ID: <1548999367-11733-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
References: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 18A9FA841BB559D2EFB2D7B455CE214262B6A26F60324E17095F577292C51CA82000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_213623_938075_E0100BA9 
X-CRM114-Status: GOOD (  11.93  )
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

Mediatek's HW assigned a bus address range(typically start from
0x2000_0000 to 0x2fff_ffff for both mt2712 and mt7622) for PCIe usage.
This bus address range is called memory mapped IO range, when CPU or
other HW access those address, PCIe RC HW should response to this
access. Normally the RC will translate those access request to TLPs
and send to corresponding EP side. It's like the total memory address
resource which could be allocated by EP and RC's BARs.

Although those address range is available for allocated, but it should
be enabled by the PCIE_AHB_TRANS_BASE register, what size will be
enabled is determined by AHB2PCIE_SIZE bits in this register.

In previous code we did not enable the full size of HW assigned address
range, if the EP's BAR requested size is bigger than the size we enabled
and smaller than the HW available size. The access request which target
at these un-enabled address will be blocked by RC, and EP side will
never get those TLPs.

Previous code never run into a system error in production because even
half of those range(128MB) is bigger enough for typical EP device's BAR
request(4MB).

But all those HW assigned bus range should be enabled. And it's Okay to
do that. RC will never forward a request to EP when this request is not
suitable for EP's BAR range.

Using resource_size(mem) instead of mem->end - mem->start to fix this,
since the MMIO window size for both MT2712 and MT7622 are all
0x1000_0000, this change will change the values of fls(size) from
fls(0xfff_ffff) to fls(0x1000_0000) and calcalate the whole memory
mapped IO range size.

This change also eliminate the following complain generated by
scripts/coccinelle/api/resource_size.cocci:

pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c..c42fe5c 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	struct resource *mem = &pcie->mem;
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
-	size_t size;
 	int err;
 
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
@@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	val = lower_32_bits(mem->start) |
+	      AHB2PCIE_SIZE(fls(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
