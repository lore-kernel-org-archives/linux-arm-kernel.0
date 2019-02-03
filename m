Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421920815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JDBJL7Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7PpnGNPGMY9i9UO5HwMPCsBNCBDMg+WblPSaxh2hgCU=; b=JDBJL7HpnvderBgg4XJJXmHHNw
	rW2a4HXanH8RRHc2I7XgrcOVUG04kcB0cn+jUuSffypir7C52QHA6HkpCngm5PsOdvJJnZ7mD1/EV
	XzxQS7AsiXAjUA7sfsumsa1b2kR58197/n2k0hOy9rSvAYeY5miLi0jsZdIizzH9eV5PUbHnRNWGF
	hKCsPnhb3wGtgv3Ld+lCC7cbKvgpfHe+Weu/2FRqg2GGRjfLVQasVYkTE2m4S5iqYGIUaeBQ0XAtz
	wicyXorqNGZin+5FSK9FujgSTfJY8RIdNgukvnLh5/TuK7DdWwPpiqGL8b0CYZ4UgYo1ERLBHZWp0
	efItYIaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqHR8-0003NB-8K; Sun, 03 Feb 2019 13:03:50 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqHQe-0002wK-Ue
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 13:03:23 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpDRv-1hUYCV16i7-00qmSR; Sun, 03 Feb 2019 14:03:12 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH V3 2/2] pinctrl: bcm2835: Direct GPIO config changes to
 generic pinctrl
Date: Sun,  3 Feb 2019 14:02:34 +0100
Message-Id: <1549198954-4711-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
References: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:/kkmDn8Kp2fgDwVG2jmEha3kpKFRMEMamin5rp74QuRovb92mr8
 41pqGDBbVKhk5/1nukZSFpz8u3p73QxebcyYATILfKe+A0LJNV2EFsor1HTQeO4fP5t6vSd
 APePibFTBPg+7TQnsbvv3gIrtwGR4Wo5ILg2O+2VMxzv2fY2YNfz6sKHXs6jB6cg5nhNemn
 sCbLsQKg7PG9pt07IZtJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l9dgXZoU5q0=:WdKr8iS6XF7ll0ue1KmoKb
 Lqgqx9fTLPsNj38ZviuSTxzJO+ib41PxKIxlnnuPLXA3EUu0NuO1gpq9wwfn13179MO1e6uMt
 LkOjeYqg4NvC6MwCgVjZ79cnDIgx8ahZirvvaIpuE5Hg+ZUOaQDAyQw3OvQEzgXFEAlqZKEwo
 0uCfLXNGK3WIGYZRJYTfj0XL/DADZmW9gIxFF3/+/13YsaxXkWoL/tC6XlCVNpDI4OHRArwat
 ZPMp2T4xxb7MnP/59AQMbsFJHSjo00q34zU4+R+i0SFryeJmAQ/G57SvZjqF/c/7Pwl7P/ciC
 t22ztR8i3MMMkSNTtrvN4ROy2TJ9iP1J+uhsLEf/7hV/5bL3VGZf0g0cGFkvLfHIci5fnn7f6
 S3l8X4abwg4NbCln6FcDVJPXo3hTM0VSqdkGST3N8BJwZWlRf7HeUF8yfJpoTEBqvMsjyzkBp
 zwUygTbU237Tiazr+2CKeO992zFUTRU8UpJzOD7LD/BbRIzmqj4CMeXRF7Uw8s/k9u41Bt68L
 yvtiGtZU56uuFwGbqm69gFUPaWDBpVEw9nmjBz3sSK7nh/YdDT87DntJE0YT2y1gPxNmZRJEJ
 t6lc+AML7goN3GkXrXhsTbhbQpMS96Cz1eoOO8QShVuvI8+s3W+dmKiFRBwjm/apygDD0o3gB
 +sMVKPn1BUTXWazBU1lCfBfxpHoYiyhL8IdemH+E3EmK9P28yxuB3mYxAp0XEWIwkh8SWVe3M
 ZN00eQzZiK/GLhxIvTV1JMTs9uptjvcZjhkMdUWhKg7jGKBnWdmWMIAhcBg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_050321_279763_132D943C 
X-CRM114-Status: GOOD (  13.89  )
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
