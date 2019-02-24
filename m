Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36313C10F18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0637C20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C/uvt6uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0637C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8P/XMouJk04Sv3KEXEQeGNz2qWmFmCaTiAN21T6jhsE=; b=C/uvt6uMyCrGSn
	6xGTkLa8fDNn35on2JDlLRAAKAJDG+FMwp/VuZR4e/QcoKOjhdHOROtzpULDxVDFYJ6CYx728yq6U
	4k48PSmp1LQort6FPuLbcLU1A0mCoczeZuLtpGGee08OrbsVfuLfuhxBdSzaABfkTYNPvnQF9meOM
	tCAESZYtQ09tYKIQ0op4qQvU8CNlVMqyZv22jGJAT38+9JQfR0+0lieHU2bUf++kIJBLwykNKTwL/
	8VCotc9ym0rgXX92KHUMovIUA0eQcVklo4cqXjluWRbOi5U2HJ1WewWYBp/iem09pnvMl41AtizHj
	pGDaQvN3Pys2b2sWxqxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxuPT-0007n4-Fo; Sun, 24 Feb 2019 14:05:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxuP9-0007ZL-VM; Sun, 24 Feb 2019 14:05:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3950E16A3;
 Sun, 24 Feb 2019 06:05:19 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF9E3F690;
 Sun, 24 Feb 2019 06:05:15 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Kalle Valo <kvalo@codeaurora.org>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH 3/4] mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN rather
 than disabling it too late
Date: Sun, 24 Feb 2019 14:04:25 +0000
Message-Id: <20190224140426.3267-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_060520_009694_41148D7F 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The mwifiex driver makes unsafe assumptions about the state of the
wake-up interrupt. It requests it and only then disable it. Of
course, the interrupt may be screaming for whatever reason at that
time, and the handler will then be called without the interrupt
having been registered with the PM/wakeup subsystem. Oops.

The right way to handle this kind of situation is to flag the
interrupt with IRQ_NOAUTOEN before requesting it. It will then
stay disabled until someone (the wake-up subsystem) enables it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 2105c2b7c627..82cf35e50579 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1610,6 +1610,7 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 			 "wake-up interrupt outside 'wake-up' subnode of %pOF\n",
 			 adapter->dt_node);
 
+	irq_set_status_flags(adapter->irq_wakeup, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, adapter->irq_wakeup,
 			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
 			       "wifi_wake", adapter);
@@ -1619,7 +1620,6 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 		goto err_exit;
 	}
 
-	disable_irq(adapter->irq_wakeup);
 	if (device_init_wakeup(dev, true)) {
 		dev_err(dev, "fail to init wakeup for mwifiex\n");
 		goto err_exit;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
