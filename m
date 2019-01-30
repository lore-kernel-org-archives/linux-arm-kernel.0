Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:42:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F05218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L5IWku00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F05218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abatec.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2ClZYZVfzPy61uBRIib6R4J4Sqo4TQY4WGAATqi7f3w=; b=L5IWku00781zM3
	+cn/i19UxRF/6GPzgj5qwdebvubYOHbG8ZXm8dVREW+ChO1pFkHudm3NIvw8CKD1buwxLbUodb5Jj
	hPR8xmlqpqSz3roda+JL6oNsfn/IP9CmMadPTO4c/klZsXF1ijpTRUHDa5lRk6OjfbJd9hwtDC52h
	Sp6MRyCYvwu4OgPdWOWN4+P1wu8xsLnp7pEt6HF0tuTmDXYS9jjLS+H0W1MYYOhW7ob7RLMlYPfgX
	a9nL0RBG7mZ2ALLX708tpon8crWLEa5E2x4B0YIQwVL0hM7PcZ1KH4RvXZ0zka+xWqCkXRvE0+fbA
	lG6hBJ5dITcb/4MdTINw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goq8B-0007Fy-Rx; Wed, 30 Jan 2019 13:42:19 +0000
Received: from mail1.abatec.at ([81.10.186.19])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goq88-0007FZ-Lq
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:42:18 +0000
Received: from exchange02.regau.abatec.at (192.168.100.22) by
 exchange02.regau.abatec.at (192.168.100.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 30 Jan 2019 14:42:11 +0100
Received: from OTTINGER (192.168.115.56) by exchange02.regau.abatec.at
 (192.168.100.22) with Microsoft SMTP Server id 15.1.1415.2 via Frontend
 Transport; Wed, 30 Jan 2019 14:42:11 +0100
From: <g.ottinger@abatec.at>
To: 
Subject: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout case
Date: Wed, 30 Jan 2019 14:42:02 +0100
Message-ID: <20190130134202.5831-1-g.ottinger@abatec.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_054216_878315_7EC65F3A 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, g.ottinger@abatec.at,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 eugen.hristev@microchip.com, s.etzlstorfer@abatec.at,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Georg Ottinger <g.ottinger@abatec.at>

Having a brief look at at91_adc_read_raw() it is obvious that in the case
of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is
omitted. If 2 different channels are queried we can end up with a
situation where two interrupts are enabled, but only one interrupt is
cleared in the interrupt handler. Resulting in a interrupt loop and a
system hang.

Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
---
 drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 75d2f7358..596841a3c 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 		ret = wait_event_interruptible_timeout(st->wq_data_avail,
 						       st->done,
 						       msecs_to_jiffies(1000));
-		if (ret == 0)
-			ret = -ETIMEDOUT;
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
-
-		*val = st->last_value;
 
+		/* Disable interrupts, regardless if adc conversion was
+		 * successful or not
+		 */
 		at91_adc_writel(st, AT91_ADC_CHDR,
 				AT91_ADC_CH(chan->channel));
 		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
 
-		st->last_value = 0;
-		st->done = false;
+		if (ret > 0) {
+			/* a valid conversion took place */
+			*val = st->last_value;
+			st->last_value = 0;
+			st->done = false;
+			ret = IIO_VAL_INT;
+		} else if (ret == 0) {
+			/* conversion timeout */
+			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
+				chan->channel);
+			ret = -ETIMEDOUT;
+		}
+
 		mutex_unlock(&st->lock);
-		return IIO_VAL_INT;
+		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
