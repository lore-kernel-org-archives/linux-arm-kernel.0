Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9B1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UPH52X3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9B1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q0GdmMnTQ+W82brtTklr/xxHGJHmr5p9Pe6faA+KxIU=; b=UPH52X3fH6zI/x
	mhGZcB0YRg19XkJhxh+Mqkpl78NRMmOWzq2AuENZi5X2cUtSZ7JjqWbCYVWMmKJVAecg3lVmm31T3
	cEV3HalxGk6I0oTW/OvFgCxgSO0uDp8Dq+Nt5Te2SwkJMRUHaWb8p40QUtqkwF0NzhXcqOQxq6puZ
	fjcZCVq6NX57s9YWiq2TxtXhQM5PNcCFR8y4Dxv3Oxq4YAxHDYSLbQ27SAGQtgcwH9fyeBMKxZVB6
	tBkKzdyIS4p8Usb1Erg5QI0MhNboJcSOnhJHaErqBiR73TGXRVp2Tll9P84MsuzC2Hey3mporkv5d
	U4ix+TQTomf59yU3NFmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGNY-0000WV-6Z; Tue, 04 Dec 2018 19:29:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGNK-0000K0-Vn
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:28:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 94F5120A5B; Tue,  4 Dec 2018 20:28:44 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 958D5207AD;
 Tue,  4 Dec 2018 20:28:33 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/7] ata: libahci_platform: comply to PHY framework
Date: Tue,  4 Dec 2018 20:28:25 +0100
Message-Id: <20181204192831.12440-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204192831.12440-1-miquel.raynal@bootlin.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112855_330306_FE535840 
X-CRM114-Status: GOOD (  16.22  )
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
phy_set_mode() before phy_power_on().

PHYs should also be handled at suspend/resume time. For this, call
ahci_platform_enable/disable_phys() at suspend/resume_host() time. These
calls are guarded by a HFLAG (AHCI_HFLAG_SUSPEND_PHYS) that the user of
the libahci driver must set manually in hpriv->flags at probe time. This
is to avoid breaking users that have not been tested with this change.

Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/libahci_platform.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ef356e70e6de..8810475f307a 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -254,6 +254,8 @@ enum {
 	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
 							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
+							suspend/resume */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4b900fc659f7..81b1a3332ed6 100644
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
@@ -738,6 +744,9 @@ int ahci_platform_suspend_host(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
+	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
+		ahci_platform_disable_phys(hpriv);
+
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
@@ -756,6 +765,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
 int ahci_platform_resume_host(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
@@ -766,6 +776,9 @@ int ahci_platform_resume_host(struct device *dev)
 		ahci_init_controller(host);
 	}
 
+	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
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
