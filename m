Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A223C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E65020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sez5/kFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOaST7Ii/AImFz69vKb3bt4HhtjmmFKTqqSHZGVpS9c=; b=Sez5/kFKOK1h7c
	hfNPk6oDuytn7MstJpUZGNP/28Q2yMhema066e/Jf5vbdeDi9HM2R7CoddkR2adG/8fvqKFL/fGNh
	Xtkfx0srLDu7d6szkxOENm/ML20UpLlBcfR7nwXEsxA3YrwqoZfkxNcbzbzQSnrxR9PCNg/iypLsf
	8KPdLY2YdTRtYPnrX5q/Kle4NRU5Qn0g1Zxh4izUlfsKfiyYZtyEYsN4ohzl3s5m4YDSeIbY8QEbu
	Me/3WA0iX0wDaNyBZBOizNDX/QxXwWbd7/53qt16Zve/UUcM32VpyuBMIFDXTkD2471LnEvJw/7FR
	bwTXqduvX3RQSgG2c1yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSktS-0008VR-9T; Fri, 30 Nov 2018 15:39:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSksc-0007bd-Ss
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:39:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E007C20CFB; Fri, 30 Nov 2018 16:38:57 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8D74120CFC;
 Fri, 30 Nov 2018 16:38:40 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/6] ata: ahci: mvebu: add Armada 3700 initialization
 needed for S2RAM
Date: Fri, 30 Nov 2018 16:38:31 +0100
Message-Id: <20181130153833.11421-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130153833.11421-1-miquel.raynal@bootlin.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073859_256298_37B7C51F 
X-CRM114-Status: GOOD (  17.73  )
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

A3700 comphy initialization is done in the firmware (TF-A). Looking at
the SATA PHY initialization routine, there is a comment about "vendor
specific" registers. Two registers are mentioned. They are not
initialized there in the firmware because they are AHCI related, while
the firmware at this location does only PHY configuration. The
solution to avoid doing such initialization is relying on U-Boot.

While this work at boot time, U-Boot is definitely not going to run
during a resume after suspending to RAM.

Two possible solutions were considered:
* Fixing the firmware.
* Fixing the kernel driver.

The first solution would take ages to propagate, while the second
solution is easy to implement as the driver as been a little bit
reworked to prepare for such platform configuration. Hence, this patch
adds an Armada 3700 configuration function to set these two registers
both at boot time (in the probe) and after a suspend (in the resume
path).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 7839a5df1fd2..761d67c5bc31 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -30,6 +30,7 @@
 
 struct ahci_mvebu_plat_data {
 	int (*plat_config)(struct ahci_host_priv *hpriv);
+	unsigned int flags;
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -82,6 +83,19 @@ static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
 	return rc;
 }
 
+static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
+{
+	u32 reg;
+
+	writel(0, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_ADDR);
+
+	reg = readl(hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
+	reg |= BIT(6);
+	writel(reg, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
+
+	return 0;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -148,8 +162,7 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	if (pdata->plat_config)
-		pdata->plat_config(hpriv);
+	pdata->plat_config(hpriv);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -179,7 +192,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev, pdata->flags);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
@@ -191,12 +204,9 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
-	pdata = hpriv->plat_data;
-	if (pdata->plat_config) {
-		rc = pdata->plat_config(hpriv);
-		if (rc)
-			goto disable_resources;
-	}
+	rc = pdata->plat_config(hpriv);
+	if (rc)
+		goto disable_resources;
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
 				     &ahci_platform_sht);
@@ -215,7 +225,8 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 };
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
-	.plat_config = NULL,
+	.plat_config = ahci_mvebu_armada_3700_config,
+	.flags = AHCI_HFLAG_MANAGE_PHYS,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
