Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2535FC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7E820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gVlUxtqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7E820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrIy5Rjnz6lIu34Ec2UCd1d7eSFvxVZaYr4HhAvKgDE=; b=gVlUxtqKdh8m7P
	HUBt3Ojocktqzd4SAZQzrVXUoP+kPZ5BdKiQ1K6EUE9/OE9tSeoUUV2ELIYr9aufDUxOdIHBj2Ilc
	V8r5JvAC/EIRFKjig3aIVtqUehPTGR/lnsX8WOdaAYjKS3rCMXTxIcHTZqrd17dVb0P3a/QaKCPCm
	Ot8I52QGvrnrIWVD+6u1vrXM1VhMSQ8Ocn1CJ57plQTVU6lJNPzBCjzHZet76BxXN8SV8TOf6REmz
	NFS25j2dMdQc86R3j2MfxQtRYFp0hqLMdnE66FhfB2cdhLgzOYNSpGCNwdG4oFkk/6JE0mEN7EPJk
	OxE2WeDG1LPoTDUEZMsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSktF-0008Do-Ea; Fri, 30 Nov 2018 15:39:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSksc-0007ag-Q6
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:39:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A955C20D0D; Fri, 30 Nov 2018 16:38:48 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id B44AB207B0;
 Fri, 30 Nov 2018 16:38:37 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/6] ata: libahci_platform: comply to PHY framework
Date: Fri, 30 Nov 2018 16:38:28 +0100
Message-Id: <20181130153833.11421-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130153833.11421-1-miquel.raynal@bootlin.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073859_197984_83DEC685 
X-CRM114-Status: GOOD (  17.68  )
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

Current implementation of the libahci does not take into account the
new PHY framework. Correct the situation by adding a call to
phy_set_mode() before phy_power_on() and by adding calls to
ahci_platform_enable/disable_phys() at suspend/resume_host() time.

Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/libahci_platform.c | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ef356e70e6de..982638b37fee 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -254,6 +254,8 @@ enum {
 	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
 							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
+	AHCI_HFLAG_MANAGE_PHYS		= (1 << 26), /* let the core manage the
+							PHYs when relevant */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4b900fc659f7..f5a64eb1fea8 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 		if (rc)
 			goto disable_phys;
 
+		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+
 		rc = phy_power_on(hpriv->phys[i]);
 		if (rc) {
 			phy_exit(hpriv->phys[i]);
@@ -378,7 +384,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
  * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
- * 5) phys (optional)
+ * 5) phys (optional), PHY handling during suspend/resume will be skipped if the
+ *    flag AHCI_HFLAG_MANAGE_PHYS is missing.
  *
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
@@ -458,6 +465,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		}
 	}
 
+	if (flags & AHCI_HFLAG_MANAGE_PHYS)
+		hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
@@ -738,6 +748,9 @@ int ahci_platform_suspend_host(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
+	if (hpriv->flags & AHCI_HFLAG_MANAGE_PHYS)
+		ahci_platform_disable_phys(hpriv);
+
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
@@ -756,6 +769,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
 int ahci_platform_resume_host(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
@@ -766,6 +780,9 @@ int ahci_platform_resume_host(struct device *dev)
 		ahci_init_controller(host);
 	}
 
+	if (hpriv->flags & AHCI_HFLAG_MANAGE_PHYS)
+		ahci_platform_enable_phys(hpriv);
+
 	ata_host_resume(host);
 
 	return 0;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
