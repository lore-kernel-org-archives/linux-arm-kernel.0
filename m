Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48963C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140EF2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHCJw1OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yubK26chlUHzHfkFn7pvEouzhyaK8IW8kiBhZlY7Lz0=; b=sHCJw1OIWB8oj4ExTL1gkptp3h
	MqfwXw/3xHZn/LkAEEYenANfK8f0YpDBghLhZ4T7Ib13vf5g4zGjQeC6Kxj2W7c8Dg/1H01ywsvac
	GCaBY+i3lqVnRbcRRiWGoLHGKHjFYamRvcEdLDN+eZzH0uCS422KqbKRlXCSWjUaqFhjHpTWZXI76
	SRnAFCwWgHhsFpKCNUGk+YzOBLT5XJThpqOKi2WcSVrPdhfkB2RmEZYnpVQ5n+2KUFUgdV1LSsimr
	G2jpbn0qr4v0hjS2kkyCJLH8jU0gDHsEhSzW2LpncWIBZ958EmTyVa/MuuJJot8RbhquvUR5Ykznk
	k+pP9hMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSjI-0000H4-0f; Mon, 10 Dec 2018 21:04:40 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSiK-0007KL-OF
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:03:45 +0000
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
 by pokefinder.org (Postfix) with ESMTPSA id 46C014C3C85;
 Mon, 10 Dec 2018 22:03:20 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [RFC/RFT 10/10] i2c: rcar: add suspend/resume support
Date: Mon, 10 Dec 2018 22:03:08 +0100
Message-Id: <20181210210310.12677-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_130341_741770_5D19CA31 
X-CRM114-Status: UNSURE (   9.79  )
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
 linux-kernel@vger.kernel.org,
 Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Because the adapter will be set up before every transaction anyhow, we
just need to mark it as adapted to the I2C core.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 254e6219e538..30cff066e0da 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1017,10 +1017,35 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rcar_i2c_suspend(struct device *dev)
+{
+	struct rcar_i2c_priv *priv = dev_get_drvdata(dev);
+
+	i2c_mark_adapter_suspended(&priv->adap, true);
+	return 0;
+}
+
+static int rcar_i2c_resume(struct device *dev)
+{
+	struct rcar_i2c_priv *priv = dev_get_drvdata(dev);
+
+	i2c_mark_adapter_suspended(&priv->adap, false);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rcar_i2c_pm_ops, rcar_i2c_suspend, rcar_i2c_resume);
+
+#define DEV_PM_OPS (&rcar_i2c_pm_ops)
+#else
+#define DEV_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
 		.of_match_table = rcar_i2c_dt_ids,
+		.pm	= DEV_PM_OPS,
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
