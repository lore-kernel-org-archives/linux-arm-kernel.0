Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD77C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD261217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRw6aUQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD261217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j1bUhjyJjB4Z/+4CY4xQX3CfPoQxd8cCOf9iFrsSmi4=; b=QRw6aUQBXgRA2a
	9LsmiCPmuXxVn9mehP20ChSoCuQCOJSlx9CM42ONSfu4T8Fahpm7zckCrGBrJBt2vbgQQ9h2qsr3F
	4lgsscVeNgl/69cKLtcw/5jne8LrckaWR2O+ZC1XHjEmnbThDoZ57ff5k3GBmJ/9yVn5uJ0f2Cd9x
	LdZgePru3veTk7O/qcI9kBpbXwdl86czCvzYOPEC1uhAJuq+Ggvm1EfK6qAGp/QWhPO+PVqqq7pvh
	u0wmIhRtKam4bgW/qTDDKKHrYEy3+vBHTUeS5MqEYZWHcSW7PcIzRxUycYJDB7jvNe+8Ei7en2/d5
	P7KFbBMQr05Zz/v6F+ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2ro-0003A3-Ji; Tue, 05 Feb 2019 15:42:32 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2rl-00038L-0s
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:42:30 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 708365FD40; Tue,  5 Feb 2019 23:42:26 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Date: Tue,  5 Feb 2019 23:42:24 +0800
Message-Id: <20190205154225.14264-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205154225.14264-1-wens@csie.org>
References: <20190205154225.14264-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074229_269343_0682DB65 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: devicetree@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MMC device tree bindings include properties used to signal various
signalling speed modes. Until now the sunxi driver was accepting them
without any further filtering, while the sunxi device trees were not
actually using them.

Since some of the H5 boards can not run at higher speed modes stably,
we are resorting to declaring the higher speed modes per-board.

Regardless, having boards declare modes and blindly following them,
even without proper support in the driver, is generally a bad thing.

Filter out all unsupported modes from the capabilities mask after
the device tree properties have been parsed.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

This should be backported to stable kernels in case people try to run
new device trees (that declare newly supported modes) with old kernels.
---
 drivers/mmc/host/sunxi-mmc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7415af8c8ff6..70fadc976795 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1415,6 +1415,21 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
+	/*
+	 * If we don't support delay chains in the SoC, we can't use any
+	 * of the higher speed modes. Mask them out in case the device
+	 * tree specifies the properties for them, which gets added to
+	 * the caps by mmc_of_parse() above.
+	 */
+	if (!(host->cfg->clk_delays || host->use_new_timings)) {
+		mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
+			       MMC_CAP_1_2V_DDR | MMC_CAP_UHS);
+		mmc->caps2 &= ~MMC_CAP2_HS200;
+	}
+
+	/* TODO: This driver doesn't support HS400 mode yet */
+	mmc->caps2 &= ~MMC_CAP2_HS400;
+
 	ret = sunxi_mmc_init_host(host);
 	if (ret)
 		goto error_free_dma;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
