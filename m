Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32611C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322B206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ICk+OFA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7PpnGNPGMY9i9UO5HwMPCsBNCBDMg+WblPSaxh2hgCU=; b=ICk+OFA6CmEAjw2qMsOOUwNan/
	Qf+0peBvnwwieXYLqdUmvQI964qhZSBF9ptbZBUgbryrXliMLcOYMKc+VaSJPxHkC50f47vzQzAL1
	PHu1a/RZRyJ+Dy8XMo6vaakt/qUzTBMEH3mjmVa9/O8/oWmSOrC3U5wqBCo5sE8Xi4GROHM0CD3mx
	CLA8UGoYtUErR2bBaJ3KYyKAcTNrcesjC4MusV2iKSWGvkBtMQRcN0TxfsL6gK7jzhWweqeeL2eGZ
	BHg5bCL+vO9zBkbYWCvGU8+Xt7o4SbeDLm5A4Q+Igoo49vGlUSwDOWmdvpqLIMzCRYXXtOFbtpB8a
	05QIETdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5AN-0004ZN-Gm; Fri, 08 Feb 2019 12:21:59 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs59s-00044c-Cz
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:21:31 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFbiK-1gtgdU1rYs-00H7fx; Fri, 08 Feb 2019 13:21:18 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RESEND V3 2/2] pinctrl: bcm2835: Direct GPIO config changes to
 generic pinctrl
Date: Fri,  8 Feb 2019 13:21:13 +0100
Message-Id: <1549628473-4485-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549628473-4485-1-git-send-email-stefan.wahren@i2se.com>
References: <1549628473-4485-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:RhGv0flQUBQtEYAjfa5Ht7rZVZ/VHte+tz3fXU85yPSKsmvNuns
 dge3M6MlxlY2Lmr3p8rxZlUEBI8pn3kQuv3XNtxwpnjldeTPV3s8MMu68Ewo9SxM7CtjKom
 yWoe30XsIfCFT77j0bidgyxjaOaD4jnx85+1r3/aIaZlOzOnMc4/YJi0wtMuUF1QahnHwxF
 JUZPrqF4GL+1eLXmWuoiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HI/CnvdLlE0=:OomwtQh3nS7myJf3Iuexxn
 ewwbg+YpEONFRpAbXCO8HJryD7I5j4FDUuBRmGn4Yps9FDMeVAatjrm6Iz81CLwdaCkg7t0g4
 OLMyxqHrRa0wLV9lfy60BqG74+PIr6/rg+xcztxaCDETaGsV8dC+fuFKUQsRCeXvN470C8fqR
 6a07yPit9Ts397ob4r0fHx59eqq97Ipse0NfpwtzKVPsWW3aVRJuTylFOmGsRRPQkaZxG/3pD
 8V34u9cvT8Xkw2eUUDzho1LIox9Eq71GMSrYRYl6+IJKED6deumSLEmjuZsGMTddtjZa0RMfC
 cVQaiNOdVOtKvE3CmZRwy+gldtjiRJUpb6jlVeUBFHFUgnt6AUbSy1lpopC8bV3GLR5UiHhb9
 5m85w+I72A+ZIellIEVc8SJj4xe1nmc1Q++ENra+VOEPfICPHyTvOm8+89l96pjQvcH0JIDTU
 +Mq95+fstMAzoIqs/a4Y1W2CFnL+8OTeg/9Fj/HeRDUEOWjm1aMZbkAzizQsPQPHWv0+XJbjY
 aOaodcYrJhYRP5TEat6jXj+emd1KnXnB9V41J7N6sb2GbHtQ0wPNHiUhFudGRBy17GOMOWY+q
 TpjfoZwZkGcWxUbtpidcWkpLXAJF5T2va6BoIHT8P8krDMBijCtsoyOAALM5xgdcyr8axndmf
 r0/XzD3ivMEaCjRYF9AUgXvnHOoCd6xwyrc4W8n/4+Lbvse9b3ljt27bPMtWcT4q0C9M2DQ5q
 Ze72QPbD/FZD/lkMHppuSPBaC4pP6zsvi3zDfuOiXjWBxcf4xMOUscuVpAY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042128_736833_B89AF721 
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-gpio@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to support GPIO config changes direct these to the generic pinctrl.
This also requires an adjust of the return code for unsupported parameter
otherwise gpiod_configure_flags wont work as expected.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 19eb4fd..183d1ff 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -341,6 +341,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.get_direction = bcm2835_gpio_get_direction,
 	.get = bcm2835_gpio_get,
 	.set = bcm2835_gpio_set,
+	.set_config = gpiochip_generic_config,
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
@@ -960,7 +961,7 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		default:
-			return -EINVAL;
+			return -ENOTSUPP;
 
 		} /* switch param type */
 	} /* for each config */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
