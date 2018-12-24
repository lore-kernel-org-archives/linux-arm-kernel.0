Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437E32173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eW8re1Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437E32173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KVoW1dqCjd1TChNGdCwyYwhM3GLIYei1xKRiuyuyidg=; b=eW8re1Ts3NslEw
	ls8UNgy4Ylve5awwN1B5BP35MWOGub2x00SAAc2OFj0dN0ekZ36kO7M//lXrMWIKkaEUVtQ0jf/VY
	My+i8JUSbaOt9fJ1AF8ihh4eoLh9ru06GVcr3S1TyOKtpUDDaxRLlE/3VuhxnX3avDOsB6WEUAwxY
	mw71BYDP6KQ3SgzcIz6AXDZtfRcvb7CibzwmjSusc/2//ZSGaVFIpFVQYZbcWSN6pLrYLnj9om9+h
	cmTBUPsom1S+/92P6WlroPIE1+pNwIyXd4WAKOHQVfMcZKXD1ZnYJDb8EaVYc5tsPBoVNF2V0CEKd
	PD1FrVF5nuH4FIPgihjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbJus-0003Eg-RR; Mon, 24 Dec 2018 06:40:42 +0000
Received: from gateway24.websitewelcome.com ([192.185.50.71])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbJup-00032X-Mo
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 06:40:41 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id B147A1EB8F
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 00:40:26 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id bJucgHGDGdnCebJucgQH2U; Mon, 24 Dec 2018 00:40:26 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=50094 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gbJub-000Gyx-OC; Mon, 24 Dec 2018 00:40:25 -0600
Date: Mon, 24 Dec 2018 00:40:25 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
Message-ID: <20181224064025.GA9588@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gbJub-000Gyx-OC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:50094
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_224039_832238_4DDFFE41 
X-CRM114-Status: UNSURE (   9.15  )
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 4e18f629f823..ce306631e844 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -48,8 +48,8 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SCG1_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -136,8 +136,8 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_PCC2_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC2_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -183,8 +183,8 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_PCC3_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC3_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
@@ -228,8 +228,8 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 	struct clk_hw **clks;
 	void __iomem *base;
 
-	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
-			   IMX7ULP_CLK_SMC1_END, GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SMC1_END),
+			   GFP_KERNEL);
 	if (!clk_data)
 		return;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
