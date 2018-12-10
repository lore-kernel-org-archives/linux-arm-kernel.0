Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF43C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B478E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+jlsgQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sztaot3U5ZNgdvhdaQzHwF6BJCyExaFS/skOpe25rgQ=; b=S+jlsgQgSoxLeqLM5wwEWmMUeQ
	4GmLUYJrBHAnnDKZ2IXcpzkdS6Ww8xYXEPVGkSYDmIp1l1Gbe59r4zpEgVdsW0keRQ89zq+PKfCPI
	SSwXGJOYCX+A6bso7capiFPVepNvaQpXUN32AlCvzkLspNtj4lJxxWU3Flhp64JDLgYcpfzw1Bhuo
	ytQPGXTWExDUGiTmXlNYq8lM2M7JX1XKLNsCar+kQziIx6V3+pTVEZeTkUDECiPY5tYCYHed8T+Dq
	tcqGs2OgpAD3LCBzdO6D6kERMeqXsJNFFEZYJweo6wr7bkug9TJuQhZvZbA2mxHtykknRzpf7XUaW
	i3XUoZ2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSk7-0002Ey-Qn; Mon, 10 Dec 2018 21:05:31 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSiK-0007Jn-O9
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:03:53 +0000
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
 by pokefinder.org (Postfix) with ESMTPSA id CF0C64C3C7D;
 Mon, 10 Dec 2018 22:03:18 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
Date: Mon, 10 Dec 2018 22:03:06 +0100
Message-Id: <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_130341_753311_5A733100 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rejecting transfers should be handled by the core. Also, this will
ensure proper locking which was forgotten in this open coded version.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-exynos5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c1ce2299a76e..fe2f2031ea36 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -183,7 +183,6 @@ enum i2c_type_exynos {
 
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	struct completion	msg_complete;
@@ -715,11 +714,6 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 	struct exynos5_i2c *i2c = adap->algo_data;
 	int i, ret;
 
-	if (i2c->suspended) {
-		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
-		return -EIO;
-	}
-
 	ret = clk_enable(i2c->clk);
 	if (ret)
 		return ret;
@@ -847,8 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
 	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
-
+	i2c_mark_adapter_suspended(&i2c->adap, true);
 	clk_unprepare(i2c->clk);
 
 	return 0;
@@ -871,7 +864,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	exynos5_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
+	i2c_mark_adapter_suspended(&i2c->adap, false);
 
 	return 0;
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
