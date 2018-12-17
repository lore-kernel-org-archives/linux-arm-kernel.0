Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3560217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="utvpxr1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3560217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=syZsXVwi+9Feh7iCOA0MOVUTqI6fPJNDvVjU5UtVo0I=; b=utvpxr1HPmUOem
	oiLPKAn0QYEqrNg7ZJvrUL8yFrCyzj/turNJdrk+/o15D97wsezIdEIE1sRU3QSZtADNm8JxnoLie
	8/4K9+/qEaxdLzHW8v7dZSckb5mOqMGDqaI6K+J0Al7G0YIOSS+gJdC3Bqe1tY2XOZhWBztzBlEnN
	0W7yTm/beRpix+FpGXnrwnLlXLYH8j7v845eTJl5oUqpr05UtJRhv+bbXjG+TPFxP8rB+8Do3xmZq
	xhqwgbl9UTVsIt9xY6gCAjMjK2Npi3He5Qf0gTl8+PvKgVTZi5B9SfOLX7/i205kspjZ04QZjTk0H
	5EMbSDM8jLkQkXVnRuIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkCH-0002gu-EQ; Mon, 17 Dec 2018 04:08:01 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9v-0000Ho-9p
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:45 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 8670C5FDB8; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 10/15] Bluetooth: hci_bcm: Wait for device to come out of
 reset after power on
Date: Mon, 17 Dec 2018 12:04:44 +0800
Message-Id: <20181217040449.31437-11-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200536_464316_B036570A 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The datasheets for BCM20702 and BCM43438 both have power up time
sequence graphs, however they are slightly different. Both chips
also have an internal power-on-reset, which holds the chip in reset
for a short time after the regulators are enabled.

For the BCM20702, the time period from when the regulators are enabled,
until the chip settles and comes out of sleep state, is 6564 ~ 8171 us.

For the BCM43438, the graph only shows the time period from when the
regulators are enabled until the chip responds by driving the host's
CTS line low, assuming the host has already driven its RTS line low.
This is shown to be 6.5 sleep cycles, with the sleep clock at 32.768
kHz. This is around 2 ms.

Wait a full 10 ms after the regulators are enabled to account for signal
rising times.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f2101038284e..538ce8059bff 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -256,6 +256,9 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
 	}
 
+	/* wait for device to power on and come out of reset */
+	usleep_range(10000, 20000);
+
 	dev->res_enabled = powered;
 
 	return 0;
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
