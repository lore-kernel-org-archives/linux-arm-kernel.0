Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA2E2064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D+bJOKzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA2E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uZmF6zTarXKjzfcQNucV1GxORE9kMC/ZoRc/jQ4hW5E=; b=D+bJOKzNP/YQYB
	0T22SptBYBl00R0BnG9hKTTeOJwnQ/VAr/1t3Pjp4s7pGstHB/Abn05lnZR6ntOA07pX27FO0vaoX
	GHrdFKNdRYVusmRwK7wicUv2PYkeHTPHVb51SJRQvjDJjWqGkk9rN8ZJr+i53VHrdHo28zZKBAnpq
	zeJKvNnCCZb1TQjsPwwyoyvZAnJcR6/SMsfGZmWRSmhjuOuxWGQBCJU4d1L1/dN3fgH9R3ha/KmKz
	8stf2o7qVDbyTZdWcU0Yo/WZcPXDUDMgUCoE6qpxI/eRZb8RuINAx+Ef1jpsjszNCZM8TzbIEV0OJ
	9a3f5im64oTg63AGeokg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghedO-0003mI-J0; Thu, 10 Jan 2019 18:00:50 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghebw-00010p-H7
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:59:25 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id CCD9C1002F3;
 Thu, 10 Jan 2019 18:59:18 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id GuJ5w0lho0Ks; Thu, 10 Jan 2019 18:59:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 994CD1002F9;
 Thu, 10 Jan 2019 18:59:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0ZLcfJBxow8y; Thu, 10 Jan 2019 18:58:56 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 233091002FA;
 Thu, 10 Jan 2019 18:58:55 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>
Subject: [PATCH v5 07/10] Platform: OLPC: Add a regulator for the DCON
Date: Thu, 10 Jan 2019 18:58:42 +0100
Message-Id: <20190110175845.1203986-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_095921_596075_57911C33 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All OLPC ECs are able to turn the power to the DCON on an off. Use the
regulator framework to expose the functionality.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Use idiomatic form of return on error
- Avoid mixing bool and int

 drivers/platform/olpc/Kconfig   |  1 +
 drivers/platform/olpc/olpc-ec.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
index 559f843199d7..858ac1d2290a 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -1,4 +1,5 @@
 config OLPC_EC
+	select REGULATOR
 	bool
 
 config OLPC_XO175_EC
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index a91f78245f5e..8566bcf2938d 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
 
 struct ec_cmd_desc {
@@ -36,6 +37,10 @@ struct olpc_ec_priv {
 	struct work_struct worker;
 	struct mutex cmd_lock;
 
+	/* DCON regulator */
+	struct regulator_dev *dcon_rdev;
+	bool dcon_enabled;
+
 	/* Pending EC commands */
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
@@ -346,9 +351,61 @@ static struct dentry *olpc_ec_setup_debugfs(void)
 
 #endif /* CONFIG_DEBUG_FS */
 
+static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
+{
+	unsigned char ec_byte = state;
+	int ret;
+
+	if (ec->dcon_enabled == state)
+		return 0;
+
+	ret = olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
+	if (ret)
+		return ret;
+
+	ec->dcon_enabled = state;
+	return 0;
+}
+
+static int dcon_regulator_enable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, true);
+}
+
+static int dcon_regulator_disable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, false);
+}
+
+static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return ec->dcon_enabled ? 1 : 0;
+}
+
+static struct regulator_ops dcon_regulator_ops = {
+	.enable		= dcon_regulator_enable,
+	.disable	= dcon_regulator_disable,
+	.is_enabled	= dcon_regulator_is_enabled,
+};
+
+static const struct regulator_desc dcon_desc = {
+	.name	= "dcon",
+	.id	= 0,
+	.ops	= &dcon_regulator_ops,
+	.type	= REGULATOR_VOLTAGE,
+	.owner	= THIS_MODULE,
+};
+
 static int olpc_ec_probe(struct platform_device *pdev)
 {
 	struct olpc_ec_priv *ec;
+	struct regulator_config config = { };
 	int err;
 
 	if (!ec_driver)
@@ -376,6 +433,16 @@ static int olpc_ec_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	config.dev = pdev->dev.parent;
+	config.driver_data = ec;
+	ec->dcon_enabled = true;
+	ec->dcon_rdev = devm_regulator_register(&pdev->dev, &dcon_desc,
+								&config);
+	if (IS_ERR(ec->dcon_rdev)) {
+		dev_err(&pdev->dev, "failed to register DCON regulator\n");
+		return PTR_ERR(ec->dcon_rdev);
+	}
+
 	ec->dbgfs_dir = olpc_ec_setup_debugfs();
 
 	return err;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
