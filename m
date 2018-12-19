Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9936CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66730217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GbeR3oMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66730217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NfQTYwn5g4gqLL7MXo1SZFOHD0hQqnjB9sTzzXHfZEM=; b=GbeR3oMGvhMt6DS2SeFJgWKoTE
	43dCakyGHo5aTMTdxGWX3YQgxkCUIydE1DiOlUlW/nNbygafifYnIYnG4K12B1vn3jFD+9rcimxh7
	FtybOPFUn4sriL4RSyx6Kw4b+SvAuEIS0h1SS73AT3rSiJgL0nZe+6r2ziD9lnDz77Sg2klAPKITp
	5Pka/VpYgI0jLEhsnL3P5nDFA/bVFbksll8oKmCYG4wkYT/OULpptaW6JdqORjslqDJ/WGFaOGw10
	ue6FFVdt+RpFK5cpaP+RSgWk5jRjHTV2H0UmZ3zQD2LVA4hKSSpLTsEnJwTS0vhkmhQuUD/DlrHUI
	wu/6Qljg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf3k-0004Op-1l; Wed, 19 Dec 2018 16:51:00 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf1n-00015U-Me
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:49:05 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id E11302E35D4;
 Wed, 19 Dec 2018 17:48:38 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 07/10] i2c: sprd: use core helper to mark adapter suspended
Date: Wed, 19 Dec 2018 17:48:23 +0100
Message-Id: <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084900_691492_22C37B42 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Baolin Wang <baolin.wang@linaro.org>,
 Orson Zhai <orsonzhai@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rejecting transfers should be handled by the core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sprd.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index e266d8a713d9..961123529678 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -86,7 +86,6 @@ struct sprd_i2c {
 	u32 count;
 	int irq;
 	int err;
-	bool is_suspended;
 };
 
 static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
@@ -284,9 +283,6 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
 	struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
 	int im, ret;
 
-	if (i2c_dev->is_suspended)
-		return -EBUSY;
-
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
 		return ret;
@@ -590,10 +586,7 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
-
+	i2c_mark_adapter_suspended(&i2c_dev->adap);
 	return pm_runtime_force_suspend(dev);
 }
 
@@ -601,10 +594,7 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
-	i2c_dev->is_suspended = false;
-	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
-
+	i2c_mark_adapter_resumed(&i2c_dev->adap);
 	return pm_runtime_force_resume(dev);
 }
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
