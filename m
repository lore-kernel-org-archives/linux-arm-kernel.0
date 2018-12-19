Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBF9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:50:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C938A217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mgo6/tT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C938A217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5itG6pBvCKr5Y+hT7JMkJxlh+qfRUAUHG5z9R2MVsnI=; b=Mgo6/tT7TtN7g/IfgiT2NW6hvZ
	VABv1f5B+c1Hx/3tP7cH3wln7JaVHFBoR2AXNwa1lmd7t9eVNL72sdfrNxFmx/PzH956eWntsGeWH
	6lSEJVGhXzoOpoC0FyX4JgYuHSMkBSGDKo0YZfJ03s1ZA9yqu64NGLHxY8URIId5ITdezFVP8Mtf8
	MzOwGxeOfsYskUuBj6Ky8t57z9WROuqrXBr76Nn6EyZv+QjmIKvZYYRblrofqXKoEFnZVzdm6jwJh
	iB8AL6a1Mz2sdvhBZZNB+GM6DZGP9hCeN/Y8tTdCexEw5RRXLHagdN156FOKBtGqpaFp5jUrPBblx
	tFUJaZhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf3J-0003wo-96; Wed, 19 Dec 2018 16:50:33 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf1n-00014m-MV
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:49:04 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id 644B02E35D2;
 Wed, 19 Dec 2018 17:48:37 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 05/10] i2c: zx2967: use core helper to mark adapter suspended
Date: Wed, 19 Dec 2018 17:48:21 +0100
Message-Id: <20181219164827.20985-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084900_751430_CEE1D326 
X-CRM114-Status: GOOD (  10.87  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Jun Nie <jun.nie@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rejecting transfers should be handled by the core. Also, this will
ensure proper locking which was forgotten in this open coded version
and make sure resume mark is set after enabling clocks (not before).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index b8f9e020d80e..7b98d97da3c6 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -66,7 +66,6 @@ struct zx2967_i2c {
 	int			msg_rd;
 	u8			*cur_trans;
 	u8			access_cnt;
-	bool			is_suspended;
 	int			error;
 };
 
@@ -313,9 +312,6 @@ static int zx2967_i2c_xfer(struct i2c_adapter *adap,
 	int ret;
 	int i;
 
-	if (i2c->is_suspended)
-		return -EBUSY;
-
 	zx2967_set_addr(i2c, msgs->addr);
 
 	for (i = 0; i < num; i++) {
@@ -470,7 +466,7 @@ static int __maybe_unused zx2967_i2c_suspend(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = true;
+	i2c_mark_adapter_suspended(&i2c->adap);
 	clk_disable_unprepare(i2c->clk);
 
 	return 0;
@@ -480,8 +476,8 @@ static int __maybe_unused zx2967_i2c_resume(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = false;
 	clk_prepare_enable(i2c->clk);
+	i2c_mark_adapter_resumed(&i2c->adap);
 
 	return 0;
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
