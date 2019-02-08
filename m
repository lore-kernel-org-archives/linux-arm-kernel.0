Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9433FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C2C20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcNmcqkb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ETCpGSnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C2C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FXcxaMwUnR3fifVI1d5JnJeWTvqA+ZkiQo1vLp+iOKQ=; b=gcNmcqkbinopqt7bo56aWMwzSn
	Chagm7F6xzT022PioOLxCwGapeknj/MMllGdIeu8sMlI3rBTyhtNxU5tfp2Yr65us+O77u9/iWnXh
	qDNHuqFzI6YwlgEVyAVCYk/kHS560ieFYicuHSRr5HiRvMILbtQ9IpVKmWC8wT25OnoU1l2DAJofP
	iOm2kBwY8RK70PUwPF9ZWkrnTGThPsWrG7WxqbeHJX/vD8QM1fvEl25P5/Jo64SFe0pOFl2m93xEe
	riCU5PC0EJntA7FqLdQGFN79b5EJ26eoH5F9oTUoP11AjvbXg+AJ2CVpDtEuJliCQcQ/g8KC/a1Ze
	T0Dt+OZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Hb-0004yR-OG; Fri, 08 Feb 2019 11:25:23 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4H5-0002SP-EQ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:25:02 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1D6E225BF22;
 Fri,  8 Feb 2019 22:14:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624472; bh=5f1yj1BwB5o7wQ5PO8mMFZK1cIcAWTQmjCu+k28EdQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ETCpGSnShkutLLscbKjBJhveStNhHYek5rBCZ1gfOBeeKvoy7Q9oQeGo1NOBh3Scu
 xIR4nkS936CCOyi/BBAkdgw2e9bepE7oStjibkwveQCjqdaaA4fFt89Quueab7zpGg
 b4CO9KH5Ob4JKfNZUdZQr8LqB+mre3twaOyJm+2U=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 70162940171; Fri,  8 Feb 2019 12:14:30 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Date: Fri,  8 Feb 2019 12:14:28 +0100
Message-Id: <5347a0203709d5039a74d7c94e23519eee478094.1549622472.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549622472.git.horms+renesas@verge.net.au>
References: <cover.1549622472.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032452_193871_3074D321 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: Marek Vasut <marek.vasut@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

The quirk code currently detects all compatible I2C chips with a shared
IRQ line on all I2C busses, adds them into a list, and registers a bus
notifier. For every chip for which the bus notifier triggers, the quirk
code performs I2C transfer on that I2C bus for all addresses in the list.
The problem is that this may generate transfers to non-existing chips on
systems with multiple I2C busses.

This patch adds a check to verify that the I2C bus to which the chip with
shared IRQ is attached to matches the I2C bus of the chip which triggered
the bus notifier and only starts the I2C transfer if they match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 8e50daa99151..dc526ef2e9b3 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -40,6 +40,7 @@
 struct regulator_quirk {
 	struct list_head		list;
 	const struct of_device_id	*id;
+	struct device_node		*np;
 	struct of_phandle_args		irq_args;
 	struct i2c_msg			i2c_msg;
 	bool				shared;	/* IRQ line is shared */
@@ -101,6 +102,9 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 		if (!pos->shared)
 			continue;
 
+		if (pos->np->parent != client->dev.parent->of_node)
+			continue;
+
 		dev_info(&client->dev, "clearing %s@0x%02x interrupts\n",
 			 pos->id->compatible, pos->i2c_msg.addr);
 
@@ -165,6 +169,7 @@ static int __init rcar_gen2_regulator_quirk(void)
 		memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
 
 		quirk->id = id;
+		quirk->np = np;
 		quirk->i2c_msg.addr = addr;
 
 		ret = of_irq_parse_one(np, 0, argsa);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
