Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE84C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6252D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVGK9V9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rn3wdYFL8c8Nqb497lCcvzrlqT75u3ZlA8z1Vh01kM8=; b=TVGK9V9ttRhgWh
	R/qMPCJdlr1dgWB/BK3NmEMzbHlIDJaHGw3XDQnQ9FPMk7iEqILqx1ABZWz8zoeHb9BW/d3wrCmm7
	o4TY4OC0V550E44AHcttEoccejBuf9XyD/XDye3d0qrcSeEAMPs+MIO23LX6VNIvOSKP7L19m61cW
	I4qBtTfRusz+mSswDWtuzTUrls/+BQywFIlKaaM8wMKdOtcLfNT8XTaKXi8PE4lKwXgUrSITy11Hm
	YSjRMFN2Dwa4auCHYX4gSzTXlyvPHVhggYLS6S+z9Y6V+Z+k8FmfKwYou3JXN0gruTLZRfRQeBcdm
	fOuhvGvjGCcZ5ARXaC6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQsy-0002XY-L0; Wed, 05 Dec 2018 06:42:16 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQsu-0002WB-QY; Wed, 05 Dec 2018 06:42:14 +0000
X-UUID: 5c7e1529137d4a2c90eeb9353aa17171-20181205
X-UUID: 5c7e1529137d4a2c90eeb9353aa17171-20181205
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <ryder.lee@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 224579953; Wed, 05 Dec 2018 14:41:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Dec 2018 14:41:20 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 5 Dec 2018 14:41:20 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: mediatek: fix the PCIe MAC clock parent
Date: Wed, 5 Dec 2018 14:41:10 +0800
Message-ID: <2e828830d051ae641cfd55a6590cb243539d6ca8.1543991319.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_224212_998492_AE35A026 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PCIe function doesn't work as the clock tree of MAC layer is wrong.
Hence fix the clock table.

Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 200ba14..d623399 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -446,8 +446,8 @@
 	FACTOR(CLK_TOP_TO_USB3_DMA, "to_usb3_dma", "hif_sel", 1, 1),
 	FACTOR(CLK_TOP_FROM_TOP_AHB, "from_top_ahb", "axi_sel", 1, 1),
 	FACTOR(CLK_TOP_FROM_TOP_AXI, "from_top_axi", "hif_sel", 1, 1),
-	FACTOR(CLK_TOP_PCIE1_MAC_EN, "pcie1_mac_en", "univpll1_d4", 1, 1),
-	FACTOR(CLK_TOP_PCIE0_MAC_EN, "pcie0_mac_en", "univpll1_d4", 1, 1),
+	FACTOR(CLK_TOP_PCIE1_MAC_EN, "pcie1_mac_en", "sata_sel", 1, 1),
+	FACTOR(CLK_TOP_PCIE0_MAC_EN, "pcie0_mac_en", "sata_sel", 1, 1),
 };
 
 static const struct mtk_gate peri_clks[] = {
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
