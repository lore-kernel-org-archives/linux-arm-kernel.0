Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:50:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8081217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tlRzOVdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8081217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fgSZPRIMchje6Y2Qj4RqYjdoPiFKVbgTJrpG3rzQIcY=; b=tlRzOVddi92RTIn2L1VCW4OyVS
	cNlwqLRIzwpSrebvdRBvDk1MF9BYqSA9S1cHVX8EzZ2ixYV/l2Sah7E/FJmHPcO4D3KSjkcXwIhYw
	4Za3j8unGqmeKf2CsHKZ9kKQ9oeTWOsrBqmGiBoD+10g7GhmE3taMYvGzvFdwA+nZoSkPykxxDLZW
	7x1Nnk9h27/K4UjrbIU0ktV9ENPUE3YQdgc/cs5ibCbaGK205JS/PC3VilmZa9GtPlSFukkzF65cI
	HK8HzxmmUlqnV+HBfGEy7A/745SjTACdKlPJ5eHDn7mXOLoSn+xU/4ab6eFxLrlUTMGhvpjyRgSeL
	r6r3Fn/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf3W-00049v-47; Wed, 19 Dec 2018 16:50:46 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf1n-00015Z-Ma
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:49:05 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id 669CA2E3606;
 Wed, 19 Dec 2018 17:48:40 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 09/10] i2c: s3c2410: use core helper to mark adapter suspended
Date: Wed, 19 Dec 2018 17:48:25 +0100
Message-Id: <20181219164827.20985-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084900_786708_DE791CAE 
X-CRM114-Status: GOOD (  11.78  )
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
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 2f2e28d60ef5..53bc021f4a5a 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -104,7 +104,6 @@ enum s3c24xx_i2c_state {
 struct s3c24xx_i2c {
 	wait_queue_head_t	wait;
 	kernel_ulong_t		quirks;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	unsigned int		msg_num;
@@ -703,9 +702,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	unsigned long timeout;
 	int ret;
 
-	if (i2c->suspended)
-		return -EIO;
-
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -1246,7 +1242,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 {
 	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
+	i2c_mark_adapter_suspended(&i2c->adap);
 
 	if (!IS_ERR(i2c->sysreg))
 		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->sys_i2c_cfg);
@@ -1267,7 +1263,7 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
 		return ret;
 	s3c24xx_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
+	i2c_mark_adapter_resumed(&i2c->adap);
 
 	return 0;
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
