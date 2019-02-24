Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06863C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98E8206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G29ksmmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98E8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6v9FmtY6ERsTXhrbhqURM2dn93QaFGwupGxJO9BJnT4=; b=G29ksmmFJNVlR0
	9MQcJ5qIeVIOHzuoavoleirA3/r1eKa+VmJ8ZayFClnkLzoInx44DlwBSNmZe+WasDvHVK9lPMU2h
	//NicL5qLtquWsgqDjxRJWIw0HQJzHYBuVMYUGK44lS3NUgEiha15x0GG/5coTY47/FliYoUEjOhM
	hbSlM/1cPOkJ+7P1+D8NB76nvFjUvSYWjUVlf5uyLBj7b7RfFS6j6J66xuBA2UQ5UeyxBndtxcYA2
	jhm152HfJK7UgmeuJC/icFYSOj9I/bzdOtTKa7uuIOkq3ZsJaG1YLc14gBsjM6E06F4z+KVPMy+/E
	WySC0Q2ZkHL1nnGGn/Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxuPB-0007Zq-Nk; Sun, 24 Feb 2019 14:05:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxuP8-0007Yf-BS; Sun, 24 Feb 2019 14:05:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD79A1688;
 Sun, 24 Feb 2019 06:05:15 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DDF73F690;
 Sun, 24 Feb 2019 06:05:12 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Kalle Valo <kvalo@codeaurora.org>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH 2/4] mwifiex: Fetch wake-up interrupt from 'wake-up' subnode
 when it exists
Date: Sun, 24 Feb 2019 14:04:24 +0000
Message-Id: <20190224140426.3267-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_060518_397988_436E37AA 
X-CRM114-Status: GOOD (  14.81  )
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

Encoding the wake-up interrupt as part of the PCI DT node is completely
broken, as it violates the most basic rules of PCI description in OF:
the interrupts described in such node are supposed to apply to the
PCI device, and not to some non-PCI stuff on the side.

In such a configuration, both the PCI device and the wake-up widget
end-up trying to share an interrupt. Of course, this doesn't work:
The PCI device can only generate interrupts through the root port,
while the wake-up widget uses sideband signaling that bypasses PCI
altogether. Clearly, this was never tested.

So let's first try and obtain the wake-up interrupt from a 'wake-up'
subnode, and fallback to the main DT node otherwise. This ensures
that old DTs will carry on working as bad as before (with the added
warning to let the user know about the situation), and new DT will
enjoy legacy interrupts in case MSIs are unavailable.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 20cee5c397fb..2105c2b7c627 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1590,17 +1590,26 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 {
 	int ret;
 	struct device *dev = adapter->dev;
+	struct device_node *wup_node;
 
 	if (!dev->of_node)
 		goto err_exit;
 
 	adapter->dt_node = dev->of_node;
-	adapter->irq_wakeup = irq_of_parse_and_map(adapter->dt_node, 0);
+	wup_node = of_get_child_by_name(adapter->dt_node, "wake-up");
+	if (!wup_node)
+		wup_node = adapter->dt_node;
+	adapter->irq_wakeup = irq_of_parse_and_map(wup_node, 0);
 	if (!adapter->irq_wakeup) {
 		dev_dbg(dev, "fail to parse irq_wakeup from device tree\n");
 		goto err_exit;
 	}
 
+	if (dev_is_pci(dev) && adapter->dt_node == wup_node)
+		dev_warn(dev,
+			 "wake-up interrupt outside 'wake-up' subnode of %pOF\n",
+			 adapter->dt_node);
+
 	ret = devm_request_irq(dev, adapter->irq_wakeup,
 			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
 			       "wifi_wake", adapter);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
