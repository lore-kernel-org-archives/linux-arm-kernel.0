Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:33:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01272146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSNjRDKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01272146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sCOu16FdPYOsNOZCCkUlLJgtrqaf1CcN/EHOzV4VAbk=; b=MSNjRDKn+mxWSL
	QbjjP84Xe69vaP9tF+R4y7LaJJ7nOI4d0l7sIM3ICwCpBATE65skgQcV5T/46TFjHqP2YAyr0ezEH
	JMFoOm5RVsUhREb3QD6p97Au13+E1dJt05yYFwFouGN5Yo6vDcgQDpxJWkhNmxXMxb3xjMEi4j+A5
	hGKGsU9JJqlIVErBG4jeJoC1GnhLvMptt1ezenudpaoY04yVDfJ3Ob97ixOlypkQuS7SHdQWB1Z+e
	PKCGBRMD/WVSp4RUYsesOvmhkrp3WZTg28zj9pmT1YgmVXT8by9UCkdjG7eIDSiC+7svVWpUSa7Bh
	5I8TGdckrfr+hrF1MJOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSknL-0005Ak-T6; Fri, 30 Nov 2018 15:33:31 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkmc-0004V9-Up
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:32:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5325820714; Fri, 30 Nov 2018 16:32:35 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 96AAB20743;
 Fri, 30 Nov 2018 16:32:24 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 1/4] clk: core: clarify the check for runtime PM
Date: Fri, 30 Nov 2018 16:32:11 +0100
Message-Id: <20181130153214.9058-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130153214.9058-1-miquel.raynal@bootlin.com>
References: <20181130153214.9058-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073247_148905_546EEDE2 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the core->dev entry is populated only if runtime PM is
enabled. Doing so prevents accessing the device structure in any
case.

Keep the same logic but instead of using the presence of core->dev as
the only condition, also check the status of
pm_runtime_enabled(). Then, we can set the core->dev pointer at any
time as long as a device structure is available.

This change will help supporting device links in the clock subsystem.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..b799347c5fd6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 {
 	int ret = 0;
 
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
@@ -106,7 +106,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -226,7 +226,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	 * taking enable spinlock, but the below check is needed if one tries
 	 * to call it from other places.
 	 */
-	if (core->dev) {
+	if (core->dev && pm_runtime_enabled(core->dev)) {
 		pm_runtime_get_noresume(core->dev);
 		if (!pm_runtime_active(core->dev)) {
 			ret = false;
@@ -236,7 +236,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 	ret = core->ops->is_enabled(core->hw);
 done:
-	if (core->dev)
+	if (core->dev && pm_runtime_enabled(core->dev))
 		pm_runtime_put(core->dev);
 
 	return ret;
@@ -3272,8 +3272,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	}
 	core->ops = hw->init->ops;
 
-	if (dev && pm_runtime_enabled(dev))
-		core->dev = dev;
+	core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
