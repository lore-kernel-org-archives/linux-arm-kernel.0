Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B234C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E22621934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6OzOdXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E22621934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DMXN/QZq3mX1TH/iHL1GKDcJpEVH6b52mB+IR7dhzIM=; b=g6OzOdXpdJs2Nl
	OeqMJO7l0hC1CPUUtASbdIcruB/rhTj9GyZw7+WfD6nb4fXTUAaJTUStCBHz8g6BWpa8iYf6K1WTd
	weQzY/8PucQPA2vxq80T3ZCQwJjt7YwSJRq2AavEoJpZOE8i256TxgJTDZy9eCYGDD48pQvyHYzLz
	KLP2VBr8cuLfhh8KcGfxGtkhSkK/MqHJPeUxEKk1BYSKQUDt09RSGDcWeCTDkHxSTI6wwqLSxEm0f
	ejY05zUzCiDwfTNi9XJVU+1Fvf3QY0YDkHc04rnGPU3PHDtutM/EKE0FThgdlDWDBARdkO3VxehLJ
	yPN/r0BvKZwGoWY/oPzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gansk-0001Ma-Vs; Sat, 22 Dec 2018 20:28:23 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ganrN-0008Aa-Oy
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:27:02 +0000
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
 by pokefinder.org (Postfix) with ESMTPSA id 8B3232E35D2;
 Sat, 22 Dec 2018 21:26:36 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 5/9] i2c: zx2967: don't open code to reject transfers when
 suspended
Date: Sat, 22 Dec 2018 21:26:19 +0100
Message-Id: <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_122658_124819_CBADE102 
X-CRM114-Status: UNSURE (   9.43  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Jun Nie <jun.nie@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index b8f9e020d80e..cb1f45647a8b 100644
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
@@ -470,9 +466,7 @@ static int __maybe_unused zx2967_i2c_suspend(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = true;
 	clk_disable_unprepare(i2c->clk);
-
 	return 0;
 }
 
@@ -480,9 +474,7 @@ static int __maybe_unused zx2967_i2c_resume(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = false;
 	clk_prepare_enable(i2c->clk);
-
 	return 0;
 }
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
