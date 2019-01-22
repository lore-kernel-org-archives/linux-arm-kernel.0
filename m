Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A88320861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wyi+ctyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A88320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9fwXpChBh9HMfGL2jFjGeCej6UryDHbVGYdb6BLHnSI=; b=Wyi+ctyhKT6O8j
	1P+P3vW+jqS79cNTtvhIPJG8p0wOygu3UW8O8STcifldojNKhf7d1xTLuwFia14+xOrUonMH28a/5
	wtG04b1YR2U9fxbIu16eGpN2flHZDIAu/tG0pjvPTtrszlItDU1fblEfTKAJDXQtabHw83X5c1frR
	Zy4/P1Nuh50X+VWi7yHr7hSoc895vegz228G2/U/5DNqhHf8ntExnrSgpvHwWhmD0VjsMT89hhTmK
	BDTpG6aRoqlJbHCr177JTwYS2TG4QmNWDLgmEvxsHfPMnxxbRLiNi/MCaooUqdzniucps3DJwdu6/
	WpSdMGLb7rOM0mZpETCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrEa-0002AD-Cm; Tue, 22 Jan 2019 08:16:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrEW-00029b-VK
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:16:34 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 08FEC207B2; Tue, 22 Jan 2019 09:16:30 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id B55CE206DC;
 Tue, 22 Jan 2019 09:16:19 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
Date: Tue, 22 Jan 2019 09:16:19 +0100
Message-Id: <20190122081619.27653-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_001633_144378_9E281C0A 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to the datasheet and the reference code from Allwinner, the
bit used to de-assert the TCON reset is bit 4, not bit 3.

Fix it in the V3s CCU driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 621b1cd996db..ac12f261f8ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -542,7 +542,7 @@ static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
 	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
 
 	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
-	[RST_BUS_TCON0]		=  { 0x2c4, BIT(3) },
+	[RST_BUS_TCON0]		=  { 0x2c4, BIT(4) },
 	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
 	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
 	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
