Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD49C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94182085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ia8K0Yv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94182085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=W7MBwIYxhK4nRBPJ1fTVBunLFzInQfz1MEYsgKXFKME=; b=ia8
	K0Yv9SODCAF84f+KPZ90b5PFEsGFcwYEg7Me5d6tly7xbrqpuGx+vRXLKlCgrbEX5AIiB0oCSW8OT
	YCb2b5N4ZyJ6e/goiY1Z5qgSspj7j0C8rB+gPqeaA9HFkoz6ukDnSWzwdyN0KH2RvLgEs78AIBSDQ
	O9TwXzZRAwoCHPwaHxEHJX/6kkYpS3LFP+E4tcnd9b3x6kNjEyZaWxmJyG89Uk4QfWvVxAIWFy0oM
	1XtY6IJLYkepMr+zgyM8J49YfSXCeQUbf6crbLG5nnU9Wu8UNuadpoTEwwiZFErgUo7Vis5APTDtE
	JwAKvc6fjNtpDcXiw6fhWWe30XNiE3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnTxG-000325-A2; Sat, 26 Jan 2019 19:49:26 +0000
Received: from mail.ispras.ru ([83.149.199.45])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnTx9-00031j-Px
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 19:49:22 +0000
Received: from localhost.localdomain (109-252-62-199.nat.spd-mgts.ru
 [109.252.62.199])
 by mail.ispras.ru (Postfix) with ESMTPSA id 50449540082;
 Sat, 26 Jan 2019 22:49:12 +0300 (MSK)
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: David Wu <david.wu@rock-chips.com>
Subject: [PATCH] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date: Sat, 26 Jan 2019 22:48:57 +0300
Message-Id: <1548532137-15618-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_114920_075606_235908B8 
X-CRM114-Status: UNSURE (   8.19  )
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
Cc: ldv-project@linuxtesting.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b923362ee55..3b174eae77c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1342,8 +1342,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	}
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
