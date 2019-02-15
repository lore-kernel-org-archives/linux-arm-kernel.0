Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13819C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:00:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9AE21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jBBJPaXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9AE21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uYj/lj/brsctzqhSneaqZ/tuEfQCtdQw50iwtG7JlXA=; b=jBBJPaXmfJzT8y
	7LyZASmNYZnJX7YlgCOX1CwFhz2EkbEZ4syhvA15kqw1yAM8gN9KXyv2B6PcXp1husfq5tkMrlHwo
	E3+BkcvBFl9pgmd+XyyoIf8PXtWw3Yo/gy5Kkoy4aQD7J3Us8i5u6T8821fXqGyEaCBJwnEueSIRe
	fWu0XXYxvXfX/p3L2/dYrCG6TTxIt+XHpho5pW2NN06EBHQcF28d2+1IPwt8Mns/PVtNwwsJci+ED
	PNGYZ0VEQoHbGHbYEepdsv2yAD+Kv99cBblsaTuYQUbApCCUJLxHDrov3c/zJZrRoA9cWIWZKZZIT
	wEhdtrbuNNE7GMoaqepg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guWXz-0006S6-Vp; Fri, 15 Feb 2019 06:00:27 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guWXY-0004lf-Kd; Fri, 15 Feb 2019 06:00:06 +0000
X-UUID: 9d3c4c2fd7d647bbab02853428eb02bc-20190214
X-UUID: 9d3c4c2fd7d647bbab02853428eb02bc-20190214
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2119198285; Thu, 14 Feb 2019 21:59:46 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 21:59:44 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 13:59:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 13:59:42 +0800
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date: Fri, 15 Feb 2019 13:59:35 +0800
Message-ID: <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_220000_830615_192826D2 
X-CRM114-Status: GOOD (  13.41  )
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
Cc: srv_heupstream@mediatek.com, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
before send CMD6 to switch card's timing to HS mode, it reduce clock
frequency to 50Mhz firstly, the original intention of reduce clock
is to make "more stable" when doing HS switch. however,reduce clock
frequency to 50Mhz but without host timming change may cause CMD6
response CRC error. because host is still running at hs400 mode,
and it's hard to find a suitable setting for all eMMC cards when
clock frequency reduced to 50Mhz but card & host still in hs400 mode.

so that We consider that CMD6 response CRC error is not a fatal error,
if host gets CMD6 response CRC error, it means that card has already
received this command.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
---
 drivers/mmc/core/mmc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 09c688f..03d1c17 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1248,8 +1248,25 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
-	if (err)
-		goto out_err;
+	/*
+	 * as we are on the way to do re-tune, so if the CMD6 got response CRC
+	 * error, do not treat it as error.
+	 */
+	if (err) {
+		if (err == -EILSEQ) {
+			/*
+			 * card will busy after sending out response and host
+			 * driver may not wait busy de-assert when get
+			 * response CRC error. so just wait enough time to
+			 * ensure card leave busy state.
+			 */
+			mmc_delay(card->ext_csd.generic_cmd6_time);
+			pr_debug("%s: %s switch to HS got CRC error\n",
+				 mmc_hostname(host), __func__);
+		} else {
+			goto out_err;
+		}
+	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
-- 
1.8.1.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
