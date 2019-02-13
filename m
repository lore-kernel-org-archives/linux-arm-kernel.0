Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41301C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3D0222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qAM0mtRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3D0222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iiFM7RQE50txXPKJ44tS5yMlYJzNKT3jj3xMW0h8Wbg=; b=qAM0mtRBswA4Z1
	03QADX45euyVZepT9pOobijsCCYR5UWBiLS8u8YQE3x2tsDMY3+0quRZMODGPjQLwakhFbILBY73n
	QDZhvCNXl+LwXXpA0/D+fQ6oj2oM8nZAhzVKkFgIAFlpiqw2PTyamS3Jt2nzTH5p59NJ2pZYOrbKY
	RY3/NNzyhVFX9w35COSOe1kPaEflEJDhb96Rau2Uia3CXxL6gPVVoXRFhj4T/q4h9O7rsIH9Z2dmh
	6OnjXv0MoZ+s973UvaV01fWRG0ak0dcw2iDVoi4ffd5NSB9UrrADy0ODt4JbiqU1GIgewok87C8Ms
	0oswAiuGT50xesGmd+wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqW9-0005pi-1q; Wed, 13 Feb 2019 09:07:45 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqVY-00053A-DF; Wed, 13 Feb 2019 09:07:09 +0000
X-UUID: 4fe97b74d30247799049c8ecc36d1470-20190213
X-UUID: 4fe97b74d30247799049c8ecc36d1470-20190213
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1790356215; Wed, 13 Feb 2019 01:07:00 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 01:06:59 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 17:06:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 17:06:56 +0800
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date: Wed, 13 Feb 2019 17:06:52 +0800
Message-ID: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-TM-SNTS-SMTP: 68645DB28F340A99640835A4B7B41D19430DCE141EC0F639AD3442A3CDA9D7072000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_010708_450306_CC535A21 
X-CRM114-Status: GOOD (  14.41  )
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
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian
 Hunter <adrian.hunter@intel.com>, linux-mediatek@lists.infradead.org, Harish
 Jenny K N <harish_kandiga@mentor.com>, linux-arm-kernel@lists.infradead.org,
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
Therefore, any commands sent to the card should use HS400 timing.
reduce clock frequency to 50Mhz but without host timming change
may cause CMD6 response CRC error. because host still running at
hs400 mode, and it's hard to find a suitable setting for all eMMC
cards when clock frequency reduced to 50Mhz but card & host still
in hs400 mode.
this patch refers to mmc_select_hs400(), make the reduce clock frequency
after card timing change.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
---
 drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 09c688f..00adc2d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
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
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-- 
1.8.1.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
