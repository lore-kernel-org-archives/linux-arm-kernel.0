Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1EF20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="csSoR+Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1EF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ppM3svsN4qHM7OArUbkW4PPMM900i8RkbYtzp3WGDmI=; b=csSoR+GoYBtuzP
	s1lIJlsW/rkSIaxOUHgR/31URrp7EZobVzM/xu1eD8EZmEthg7nEI2aN1eAQrSVKPr+EBuFxobub9
	47EnLKURIDHaGTa15yv4mpPAjk2IoPJJO6BufmCi2bgHaQa8A04A+G/fLB/CQB69HQ9+w6dN604cs
	aqQgHxjef1IMru8vs5BjR12LQyGXeS3dGjpM8SKxWrO41bcbPwS9EfzdRYFHeoQnwe6oAp66BYQyS
	qeugSY4KADMe2hVRVQPu/UQOWjsJ0olXaWaNlAXShMdogUO1umkjdxjZmtV3rIzABut5+mNPbLxxY
	XPUAOD//1/NBdANuQG6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkuG-00028t-Pi; Fri, 30 Nov 2018 15:40:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSksc-0007bc-SG
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:39:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DC3B020D23; Fri, 30 Nov 2018 16:38:57 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 985A620CFB;
 Fri, 30 Nov 2018 16:38:39 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/6] ata: ahci: mvebu: do Armada 38x configuration only on
 relevant SoCs
Date: Fri, 30 Nov 2018 16:38:30 +0100
Message-Id: <20181130153833.11421-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130153833.11421-1-miquel.raynal@bootlin.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073859_223720_9A7544BA 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

At the beginning, only Armada 38x SoCs where supported by the
ahci_mvebu.c driver. Commit 15d3ce7b63bd ("ata: ahci_mvebu: add
support for Armada 3700 variant") introduced Armada 3700 support. As
opposed to Armada 38x SoCs, the 3700 variants do not have to configure
mbus and the regret option. This patch took care of avoiding such
configuration when not needed in the probe function, but failed to do
the same in the resume path. While doing so looks harmless by
experience, let's clean the driver logic and avoid doing this useless
configuration with Armada 3700 SoCs.

Because the logic is very similar between these two places, it has
been decided to factorize this code and put it in a "Armada 38x
configuration function". This function is part of a new
(per-compatible) platform data structure, so that the addition of such
configuration function for Armada 3700 will be eased.

Fixes: 15d3ce7b63bd ("ata: ahci_mvebu: add support for Armada 3700 variant")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 128d6f22926d..7839a5df1fd2 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -28,6 +28,10 @@
 #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
 #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
 
+struct ahci_mvebu_plat_data {
+	int (*plat_config)(struct ahci_host_priv *hpriv);
+};
+
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
 				   const struct mbus_dram_target_info *dram)
 {
@@ -62,6 +66,22 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
+{
+	const struct mbus_dram_target_info *dram;
+	int rc = 0;
+
+	dram = mv_mbus_dram_info();
+	if (dram)
+		ahci_mvebu_mbus_config(hpriv, dram);
+	else
+		rc = -ENODEV;
+
+	ahci_mvebu_regret_option(hpriv);
+
+	return rc;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -126,13 +146,10 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	const struct mbus_dram_target_info *dram;
+	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	dram = mv_mbus_dram_info();
-	if (dram)
-		ahci_mvebu_mbus_config(hpriv, dram);
-
-	ahci_mvebu_regret_option(hpriv);
+	if (pdata->plat_config)
+		pdata->plat_config(hpriv);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -154,28 +171,31 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int ahci_mvebu_probe(struct platform_device *pdev)
 {
+	const struct ahci_mvebu_plat_data *pdata;
 	struct ahci_host_priv *hpriv;
-	const struct mbus_dram_target_info *dram;
 	int rc;
 
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->plat_data = (void *)pdata;
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-380-ahci")) {
-		dram = mv_mbus_dram_info();
-		if (!dram)
-			return -ENODEV;
-
-		ahci_mvebu_mbus_config(hpriv, dram);
-		ahci_mvebu_regret_option(hpriv);
+	pdata = hpriv->plat_data;
+	if (pdata->plat_config) {
+		rc = pdata->plat_config(hpriv);
+		if (rc)
+			goto disable_resources;
 	}
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
@@ -190,9 +210,23 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
+	.plat_config = ahci_mvebu_armada_380_config,
+};
+
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
+	.plat_config = NULL,
+};
+
 static const struct of_device_id ahci_mvebu_of_match[] = {
-	{ .compatible = "marvell,armada-380-ahci", },
-	{ .compatible = "marvell,armada-3700-ahci", },
+	{
+		.compatible = "marvell,armada-380-ahci",
+		.data = &ahci_mvebu_armada_380_plat_data,
+	},
+	{
+		.compatible = "marvell,armada-3700-ahci",
+		.data = &ahci_mvebu_armada_3700_plat_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
