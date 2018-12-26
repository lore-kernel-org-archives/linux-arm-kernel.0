Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:58:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AF521726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZGY2Fq7D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aDC3lT5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AF521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=HDGsrAlNRJDQ4uw8J7s+xK5o6STs5XAyfdZddlT5dIQ=; b=ZGY
	2Fq7DxLUBYqkvdcx/0n84AtIIW5OaSLGRzTmpU5nVcEMRGlqWGeL1eGdHOUbPEcCkdfyDhPRwN2Q2
	55c7nULHsEPqWpeFtdPqe/hpWByTysBaIZlmuKBvBlMLOGxZvydaH2AnR4DQdYPLV+Q9WsCvIynnB
	R4ExARhrsHhRgb3SFvj9NWRa8U1ZEG6Cc1HsO6u7Vv8z+x6nK9L4CWBUl4uzfrpu13YesXZB3M81P
	h5OHPngIvljZwUA0g/Ia7htPoprtxmIrFTFDa9J3Iv3xcOt3h2jYIrcKS3KCoJvGFmU8zgwr4+e6i
	eFgUBrwmfuqswk6iQqwN/tb0izM9KIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbzOR-0005uh-Cp; Wed, 26 Dec 2018 02:57:59 +0000
Received: from mta-p8.oit.umn.edu ([134.84.196.208])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbzOM-0005tK-Au
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 02:57:58 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 504EAB1C
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 02:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xR6eUI1QgddH for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:57:43 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com
 [209.85.166.197])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2C212A63
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 20:57:42 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id p66so17574023itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 18:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bhyNc1efrIcsohjpviRrNYPtA0fyraSlCXmX66e+qJg=;
 b=aDC3lT5NDrWmPbvmp5vcZeIvwtyNIJfW0PprDSEXRmjA9VRM7LCR54KUJ8xcSSMYo5
 E25wzBxzenUZbYohu2+3LWkOA0sonsx/sR05lLZM2VpMITMO7HZApyllgw80TnC/5jm7
 uPSKhquK7x3eJLci+QdBDSfS+ywzzl3jPHBmGSu9rHlUBhP65VZD3Cfj+vZzCbzG4sGX
 Awi1ehsV2mHEDAvbYRpUIgs6g/92+Ll2wYnqWdd1QNJcASnUkIJRLxJ0cOCpz5FiRz8i
 GPAgdaQCSpHApJwNqMlTbcZ4HB6/+/ipfYXHolNsnww8Zs73re4WDrsC/l4U6QQCHJsN
 MHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bhyNc1efrIcsohjpviRrNYPtA0fyraSlCXmX66e+qJg=;
 b=kshqOOBSybTepa3TkSi8gEKbh6x4z42qAERWrYt9WCeePp0uz4PartKpHYpTk7aPaB
 6ErQkUStL29TNAUQ1e8YfPnrQ3P2hKvjw0QAaJSnRzX1UT7Yx9bJnt/mNNdNQBnXikkH
 J0VIhq5N1J/RpK1COmQDEsA9cMSiLOUtJ2x3XNM1Y7TMbSKw67wGZSlIiuvZM5T0KbOE
 nW0On1GNX/lmm4nnO4zGUZ8eGJXmC+2u3NMl62MG2ROsyZ96tXrx8j8hRQLGqtwPvJux
 naL4m/oWgr2iMg0NmcrkMpL1tFqxMeTZxRtF0F72K62p6WpvfKqpyHl0/FVg+DcZXwP/
 7xlg==
X-Gm-Message-State: AA+aEWbauuMfc0xnpB2/DVhMsMpkYMpoyXKnHcmHYGsHm0nqGTYa421G
 VzexY8ywfh927jmNlC0EpdlqIdqJFOkeYtFiHiT216pZZEgt1CdotXi7VC6N75YDxxrPdN1PBvT
 FoKdhm4ai4hk8WKfbMsiaMAXUzE11oNsxk6niMK0=
X-Received: by 2002:a24:f909:: with SMTP id l9mr11222485ith.74.1545793061879; 
 Tue, 25 Dec 2018 18:57:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN52EogG7kT/jqoSUzzUacufuuLL4phDyf0eIYVY4uj+lVuqtwCUGerGAXsaUvDaDYd2Fs58zA==
X-Received: by 2002:a24:f909:: with SMTP id l9mr11222472ith.74.1545793061683; 
 Tue, 25 Dec 2018 18:57:41 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net.
 [173.230.104.22])
 by smtp.gmail.com with ESMTPSA id b192sm11676951itb.12.2018.12.25.18.57.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Dec 2018 18:57:40 -0800 (PST)
From: Kangjie Lu <kjlu@umn.edu>
To: kjlu@umn.edu
Subject: [PATCH] net: stmicro: fix a missing check of clk_prepare
Date: Tue, 25 Dec 2018 20:57:14 -0600
Message-Id: <20181226025714.72643-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_185754_463707_D0864A52 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Chen-Yu Tsai <wens@csie.org>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, pakki001@umn.edu,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index d07520fb969e..62ccbd47c1db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -59,7 +59,9 @@ static int sun7i_gmac_init(struct platform_device *pdev, void *priv)
 		gmac->clk_enabled = 1;
 	} else {
 		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
-		clk_prepare(gmac->tx_clk);
+		ret = clk_prepare(gmac->tx_clk);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
