Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:34:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E372082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnuIneAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E372082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wScd72n9RNDOmxWg5mjMG2l58dx5wkt6t3qNxUkJAG0=; b=NnuIneAP20OEo8
	B/p/fGviYjxyhgsdqRARmjhJydlusyRSVlG6dRArip1hzdGoMb/urkvAnmM/ODpNagCyoQmNRGRjY
	Xz2v7wooCO6YrWxdzNOTWXxsGQ3PXH2npdKe58w4s78Y0WUErc+vqb04B3E1SOAJbQ7rKfIDiWN6k
	R7B609+0VHbpR2XNtzh9pJBPkEIilKweurwRObA84yEfPniVTQrhKLtQnd2ZLv5UrX9pws4Zl41oq
	k+SvieDNyfi9HRVMOsBIgHP72fUx66rcCS9WmjhLzdZqQgrpno6GXPGdzX3hlfs3jW9FEU9U8x63O
	m/eZ3hpfJ5U5xmUM4u1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWG5Z-0005BU-OC; Mon, 10 Dec 2018 07:34:49 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWG41-0003d8-Rg; Mon, 10 Dec 2018 07:33:18 +0000
X-UUID: f49045a3a7924abb96e001ffd4a9d0be-20181210
X-UUID: f49045a3a7924abb96e001ffd4a9d0be-20181210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <weiyi.lu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 979354706; Mon, 10 Dec 2018 15:32:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:53 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:53 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v3 12/12] clk: mediatek: Allow changing PLL rate when it is off
Date: Mon, 10 Dec 2018 15:32:40 +0800
Message-ID: <20181210073240.32278-14-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9CDB393E130637978A39B52F206B72FCFBAF4381EAF1B418F905F316458A4C152000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_233314_295549_D3212288 
X-CRM114-Status: UNSURE (   9.93  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

Some modules may need to change its clock rate before turn on it.
So changing PLL's rate when it is off should be allowed.
This patch removes PLL enabled check before set rate, so that
PLLs can set new frequency even if they are off.

On MT8173 for example, ARMPLL's enable bit can be controlled by
other HW. That means ARMPLL may be turned on even if we (CPU / SW)
set ARMPLL's enable bit as 0. In this case, SW may want and can
still change ARMPLL's rate by changing its pcw and postdiv settings.
But without this patch, new pcw setting will not be applied because
its enable bit is 0.

(am from https://patchwork.kernel.org/patch/9411983/)

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Acked-by: Michael Turquette <mturuqette@baylibre.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 81400601f107..03b20e3bca4e 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -96,13 +96,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
 	u32 con1, val;
-	int pll_en;
 	u32 tuner_en = 0;
 	u32 tuner_en_mask;
 	void __iomem *tuner_en_addr = NULL;
 
-	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
-
 	/* disable tuner */
 	if (pll->tuner_en_addr) {
 		tuner_en_addr = pll->tuner_en_addr;
@@ -141,8 +138,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 
 	con1 = readl(pll->base_addr + REG_CON1);
 
-	if (pll_en)
-		con1 |= CON1_PCW_CHG;
+	con1 |= CON1_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
 	if (pll->tuner_addr)
@@ -155,8 +151,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		writel(val, tuner_en_addr);
 	}
 
-	if (pll_en)
-		udelay(20);
+	udelay(20);
 }
 
 /*
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
