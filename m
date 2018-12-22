Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A8AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:28:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A3121934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nT89v94H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A3121934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xi19NPyIiQ41qWjvvabrGPARB6YRNngeRjF1zsE7YM=; b=nT89v94HN9+slW
	Ov7xjMJUpGaYLsyRIkbWis7PvGdQfSjz6x9ylkzvKqJCJImFhvAAxMRCFhJ5owjeIXXdGIi7Dfu1/
	trZbgUcoFdeuypQRhtl50+JyzF5e4SYlIJI2OpLVaExMdDOZWRO4MnRE+pWIw1X41snZjdxyvsUBC
	ElVFRbmxbnl6a4TA7vDkpAsUy4HeNwQq3zUHGA1gPP0VzWEuMkxd58HCeg+9ABHlEHx36gb9OA7dJ
	y2Km7EACrg5JMxse5gV+7HB7pFmeutgmjzWfu/nm/E2b4spo0hOEML1ANfu75eysp3pU8Vxk8rsqm
	59jzyN2lp7XyuDOqlFTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gantA-0001oo-QW; Sat, 22 Dec 2018 20:28:48 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ganrN-0008B4-Ox
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:27:02 +0000
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
 by pokefinder.org (Postfix) with ESMTPSA id 8D1732E35FD;
 Sat, 22 Dec 2018 21:26:39 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 8/9] i2c: exynos5: don't open code to reject transfers when
 suspended
Date: Sat, 22 Dec 2018 21:26:22 +0100
Message-Id: <20181222202623.4521-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_122658_143076_F9DCF103 
X-CRM114-Status: GOOD (  11.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-exynos5.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c1ce2299a76e..81b9c3cf4e75 100644
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
@@ -847,10 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
 	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
-
 	clk_unprepare(i2c->clk);
-
 	return 0;
 }
 
@@ -871,7 +862,6 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	exynos5_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
 
 	return 0;
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
