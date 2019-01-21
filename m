Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9686CC31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6729321773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oHlJFKfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6729321773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=k93ATkDhmyS6ybLnTUE5KRs4OKYI8+oiQ8u/3Wt/Mok=; b=oHlJFKfBdsWd+G7f0SNR6UDGfk
	RyNK/pXzrDBGANoQsvAzMDaBGJyJs6GHFHCUIT06fENIEKZVA0eGlldpWDLtbWyAHJ8mskRU3p6Ac
	2j4Av7MO6bokPXRnL9I2f4Zv4iKvwUJ9YSWv71MteLd0QyYpJlGUIXU4MGgOIacLxuepXdvT/Y4Wq
	OevTpCgMBG4Eu+txeXsIU7/tS4vZoAIR+lQs3E25vlr4c4POuL7CXhiTkgnqZRvutqtmlqwJAH6XR
	49Zwj8rUtLbWr5Xm/7oLnofFJ+Ql6GbXWOmZTBXaXFj6xhyngCCBedxECAgEe4IqlQEAC24iw17Ib
	P1HnAOFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTlK-0006pK-Nc; Mon, 21 Jan 2019 07:12:50 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTkS-0005rY-AD
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:11:59 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MD9jV-1gtyBr0WEz-009BRr; Mon, 21 Jan 2019 08:11:50 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RFC V2 4/4] gpiolib: Take MUX usage into account
Date: Mon, 21 Jan 2019 08:11:25 +0100
Message-Id: <1548054685-3781-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:wFSm5DiGB8t/6R0BFr7+f1DoAMk0jM+igrHUt1F1dd0LeSuTJwV
 UViS5qURs2CsTwS3qlJCVt8ZQ7i5nL5E9UF8GmtwjUl/A/b0BZ8TQIGz69VloA6Mz6eh/zs
 28UWl3l1NAJYbfnfyjztWnIgH58KowfMAu0o8hupfPzIEutwTqYDOrjiTR6D4/XxdA/iJjF
 lEdKkN8sqIVlXLDfnfANA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+GCDvMmv+8=:UJzj/QDxv+GmBEY4ZYSKgC
 GakJbrgitRBZxcxFYsLLCtfSZiC9JPF/6SoFcugT6PdXF5SD6VI8QGY84IdjkaRy8JvmHDuU4
 D3Qn7cdeFpqZK1Fji2S7youT32rVfZclH1iUiuMcY4dJydo8BOop2Mxy7nm1NN86FRa6GB9Dv
 SZIn+loFaUnAnkcrdQaK8gGj2agokXZ1SpSMfsLHsJmSSYHDy7heKOtJt0NRKnK/o5lKDpPGm
 B/HHT8uzW5cigIVk7TfQ5FBxjkTm31vU37/GN2ZnUZhFRf8JBkoEcm5ZHxx9eftC+YP7gIxik
 JdmRdv6x8D231RTwyj+30hgORp9OnYMdRyGkY4w+d8Zk7KrG3WzioBBNykUlwaxDVTJhEcaxi
 RjO9gGLhSjprW2+cmIIkBhSPhKuf54FjxxMHn9zaBv9UbfOSdqHCb+H/qg15VtEGJ/5vIQPf6
 FNIEyxmY/7TuusBXXhqS6y3Ha3BiFPa/ZJrd2/RGk7hwz7kR1rZODfAwDuEMPW5rCkXKVDUTE
 fYO2veFOdkD0NDZ7X0qRGmBy4tt5df6wP0PRmwcY4w9A5jW5UsVXBn5bVqB66YroQUymoKp40
 H6z5cdAa+bOT/zao2GOJLhCjslyIL0Ysfmqk5ZGHGgqv6XI/C+3f2Yo/52EkZkvk2lfXGCsGJ
 L7ZT1r9wHJxv5nnL5E7xLTAQ9bGy2wfRtkj86/8R3CxsuJxeQJAhyt/1qPT0HjZjeHumd37hd
 jSfZGr2OPXyPz4lVcIxKnjCLzfISTIelCh/BOt747rrSs9TZ45L5spHLPwg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231156_656053_600BF706 
X-CRM114-Status: GOOD (  18.45  )
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

The user space like gpioinfo only see the GPIO usage but not the
MUX usage (e.g. I2C or SPI usage) of a pin. As a user we want to know which
pin is free/safe to use. So take the MUX usage of strict pinmux controllers
into account to get a more realistic view for ioctl GPIO_GET_LINEINFO_IOCTL.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/gpio/gpiolib.c           |  3 ++-
 drivers/pinctrl/core.c           | 23 +++++++++++++++++++++++
 drivers/pinctrl/pinmux.c         | 18 ++++++++++++++++++
 drivers/pinctrl/pinmux.h         |  7 +++++++
 include/linux/pinctrl/consumer.h |  6 ++++++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1651d7f..da3b008 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1075,7 +1075,8 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
 		    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
 		    test_bit(FLAG_EXPORT, &desc->flags) ||
-		    test_bit(FLAG_SYSFS, &desc->flags))
+		    test_bit(FLAG_SYSFS, &desc->flags) ||
+		    pinctrl_gpio_is_in_use(chip->base + lineinfo.line_offset))
 			lineinfo.flags |= GPIOLINE_FLAG_KERNEL;
 		if (test_bit(FLAG_IS_OUT, &desc->flags))
 			lineinfo.flags |= GPIOLINE_FLAG_IS_OUT;
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index c6ff4d5..6e097e4 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -760,6 +760,29 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
+bool pinctrl_gpio_is_in_use(unsigned gpio)
+{
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_gpio_range *range;
+	bool result;
+	int pin;
+
+	if (pinctrl_get_device_gpio_range(gpio, &pctldev, &range))
+		return false;
+
+	mutex_lock(&pctldev->mutex);
+
+	/* Convert to the pin controllers number space */
+	pin = gpio_to_pin(range, gpio);
+
+	result = pinmux_is_in_use(pctldev, pin);
+
+	mutex_unlock(&pctldev->mutex);
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_is_in_use);
+
 /**
  * pinctrl_gpio_request() - request a single pin to be used as GPIO
  * @gpio: the GPIO pin number from the GPIO subsystem number space
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 4d0cc18..c1f6d46 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -71,6 +71,24 @@ int pinmux_validate_map(const struct pinctrl_map *map, int i)
 	return 0;
 }
 
+bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin)
+{
+	struct pin_desc *desc = pin_desc_get(pctldev, pin);
+	const struct pinmux_ops *ops = pctldev->desc->pmxops;
+
+	if (!desc) {
+		dev_err(pctldev->dev,
+			"pin %u is not registered so it cannot be requested\n",
+			pin);
+		return false;
+	}
+
+	if (ops->strict && desc->mux_usecount)
+		return true;
+
+	return ops->strict && !!desc->gpio_owner;
+}
+
 /**
  * pin_request() - request a single pin to be muxed in, typically for GPIO
  * @pin: the pin number in the global pin space
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 3319535..1da2a75 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -16,6 +16,8 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev);
 
 int pinmux_validate_map(const struct pinctrl_map *map, int i);
 
+bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin);
+
 int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
 			unsigned pin, unsigned gpio);
@@ -43,6 +45,11 @@ static inline int pinmux_validate_map(const struct pinctrl_map *map, int i)
 	return 0;
 }
 
+static inline bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin)
+{
+	return false;
+}
+
 static inline int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
 			unsigned pin, unsigned gpio)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 0412cc9..0093a2b 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -25,6 +25,7 @@ struct device;
 #ifdef CONFIG_PINCTRL
 
 /* External interface to pin control */
+extern bool pinctrl_gpio_is_in_use(unsigned gpio);
 extern int pinctrl_gpio_request(unsigned gpio);
 extern void pinctrl_gpio_free(unsigned gpio);
 extern int pinctrl_gpio_direction_input(unsigned gpio);
@@ -62,6 +63,11 @@ static inline int pinctrl_pm_select_idle_state(struct device *dev)
 
 #else /* !CONFIG_PINCTRL */
 
+static inline bool pinctrl_gpio_is_in_use(unsigned gpio)
+{
+	return 0;
+}
+
 static inline int pinctrl_gpio_request(unsigned gpio)
 {
 	return 0;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
