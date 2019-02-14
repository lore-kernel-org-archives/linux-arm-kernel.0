Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:24:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C52021900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YOe8yEcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C52021900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=formelder.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Date:To:
	From:Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=U20KPDFsbc6biu8NrV1hRHRO0Gkp327TrlFbwH4szdg=; b=YOe
	8yEcg0gKWlJzLSCFMKufX9sucGjjwZTuR6tGapLIncU+F99CjFkGzl5aS07xx+m2mYWuXEmXTPMC5
	/akcxlB3XDyj7F1gnn9UGEQN/KY23EFlND6WyePOv+GKC8iL93rA4xrzx9WI861cn3UYEEPEIust+
	WeOUxggbZpWmfE/95CFa/4VRPLbcPrwWZLQdGvm4N8eVmD4T+jEyCQsX8Hjyp0v1xOQbCJov8TlRD
	xu4LizTiNLuLeKp/EmopAaK4HGziM/fZgeI65IPfaDgmaiQU1JIQn9pT+njryBnNXo3J7mgGENhzn
	Nl/M1TGclEfXoyRcFuY5UZPDkX1PjUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guOUu-0003I9-K1; Thu, 14 Feb 2019 21:24:44 +0000
Received: from customer-2a00-7660-0ca7-0000-0000-0000-0000-0b1b.ip6.gigabit.dk
 ([2a00:7660:ca7::b1b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guOUr-0003Hj-Ng
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 21:24:43 +0000
Received: by customer-2a00-7660-0ca7-0000-0000-0000-0000-0b1b.ip6.gigabit.dk
 (Postfix, from userid 1000)
 id F21E74AC6E; Thu, 14 Feb 2019 22:24:37 +0100 (CET)
Message-Id: <641301f26ac895e39b15d62a2ba069b853ab5b09.1550178066.git.rask@formelder.dk>
From: Rask Ingemann Lambertsen <rask@formelder.dk>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Date: Thu, 14 Feb 2019 16:47:41 +0100
Subject: [PATCH] regulator: axp20x: Fix AXP806 dcdcb copy/paste bug
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_132441_927804_B9F126C9 
X-CRM114-Status: UNSURE (   8.58  )
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
Cc: Olliver Schinagl <oliver@schinagl.nl>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

An obvious copy/paste bug was introduced with the conversion to sybolic
register masks. The result is contradictory output like this:

vcc-dram: Bringing 1100000uV into 1450000-1450000uV
vcc-dram: 1450 <--> 1550 mV at 1050 mV

This patch fixes it:

vcc-dram: 1450 <--> 1550 mV at 1500 mV

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1b51d557ab55..f03cae440f7f 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -791,7 +791,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			AXP806_DCDCA_V_CTRL, AXP806_DCDCA_V_CTRL_MASK,
 			AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCA_MASK),
 	AXP_DESC(AXP806, DCDCB, "dcdcb", "vinb", 1000, 2550, 50,
-		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL,
+		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCB_MASK),
 	AXP_DESC_RANGES(AXP806, DCDCC, "dcdcc", "vinc",
 			axp806_dcdca_ranges, AXP806_DCDCA_NUM_VOLTAGES,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
