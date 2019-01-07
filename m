Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60647C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317A421736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HKlXoj9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317A421736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TK56uAzh/oYAHreiyk8GJesrvufVG2meVpjZH4TIx8U=; b=HKlXoj9wV95SHf
	ZxAF/2ePzspBpIkPOrkqgIrBTQ2ZISfzZwb1DgVaa9wP4wKj4NvvTLZXzdRS1wq6lNxaF2v/I5yVi
	B4lluQCDJXStcqBYI23yOfum9gMrS91v7Af1nyksmrFQIQNGccQ2odjw2tNVLMw0q4UikGtR5+viU
	NZsi5og/0Npyy7LOnF+cf6fKEmR5VeIeo3i0zxHEQRImW8xKiN5nO2RofjK2jOwMEu/PnZw9h0YHM
	xlDiEHlwfw0ESngbm/OyZNcLmJFHf84GYIF0XNl0/oZtZ06hfE0qjzis/Rgm+PTpvB31nUjUIdhzK
	6cZK68kTj/0D1UjPlcfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggUql-0006T4-Vt; Mon, 07 Jan 2019 13:21:51 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggUqi-0006Sb-0S
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 13:21:49 +0000
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x07DLdVp000356;
 Mon, 7 Jan 2019 22:21:39 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Mon, 07 Jan 2019 22:21:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp
 [153.232.38.183]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x07DLY0H000344
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Mon, 7 Jan 2019 22:21:39 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: fractional-divider: check parent rate only for general
 approximation
Date: Mon,  7 Jan 2019 22:21:24 +0900
Message-Id: <20190107132124.27788-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_052148_299204_26534A20 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Custom approximation of fractional-divider may not need parent clock
rate checking. For example Rockchip SoCs work fine using grand parent
clock rate evne if target rate is greater than parent.

This patch removes parent clock rate check from custom approximation.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/clk-fractional-divider.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 545dceec0bbf..b0fc5509e0ff 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long m, n;
 	u64 ret;
 
-	if (!rate || rate >= *parent_rate)
+	if (!rate)
 		return *parent_rate;
 
-	if (fd->approximation)
+	if (fd->approximation) {
 		fd->approximation(hw, rate, parent_rate, &m, &n);
-	else
+	} else {
+		if (rate >= *parent_rate)
+			return *parent_rate;
+
 		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
+	}
 
 	ret = (u64)*parent_rate * m;
 	do_div(ret, n);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
