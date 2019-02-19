Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49201217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jlKq1tqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49201217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WfRwBVc4gWF1Jr4ssnxXK07e1w1H/tCcxdZmjQP9MVA=; b=jlKq1tqHDRw9OJ
	Z/U52h69wkDUiUL4+s4UK/nqs42UoFnkWA+SSGwvqJEOlkXc3grzckQiDoWeBG/h4lHg58d5LXXnp
	jphkOh5BgV8XK21muiBZY2apewMcNmnEhSVVTnxl/W2orfJFycXNPIq8KwCq4zBI9XEBorHvDoZiL
	f2/hAQNlMZCFBB6nxwyfsObzQO0vCYCl+TIkCZQVDy3gY0tigMkP5ZWwk5sVzDE6FifKnO9PRAShH
	6tb5vsi0XkMjWwEJSAGXn1HGoJwKM8NfNHtgY1ry8l1ddThkNcxU3cdhSE7jTt095tJQkEhASLVlU
	YbG/FZvDAorDgWol19Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8cB-0004R2-TM; Tue, 19 Feb 2019 16:51:27 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8c7-0004Pu-Lw
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:51:25 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9462E1C000F;
 Tue, 19 Feb 2019 16:51:16 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Date: Tue, 19 Feb 2019 17:51:14 +0100
Message-Id: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_085123_866367_5CFA5C1C 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

nck() looks at the last id in an array and unfortunately,
at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
number of peripheral clocks is 1 instead of a maximum of 31.

Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/at91sam9x5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 2fe225a697df..d37e7ed9eb90 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		return;
 
 	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
-					   nck(at91sam9x5_systemck),
-					   nck(at91sam9x35_periphck), 0);
+					   nck(at91sam9x5_systemck), 31, 0);
 	if (!at91sam9x5_pmc)
 		return;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
