Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A18C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F52A2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ME1Yhied"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F52A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5qOYsufBG3D5Ph8y2NN3S54lSp8sxNBS+xXLIJyOZ8=; b=ME1Yhiedy+XmV5
	VU6qcgH7ptlBd/L+Nr83MOATQ5paktkVC0QA5YAseJQsOhmQAUSyezMzA+4pvyE9mxBqC5QulDFin
	zTOgfmg1h1Zto5tJhK2nUZ2mTsf0nSAmaPE1gqAlNcTXFxJiGmFCvN764PsugVIMihjWHYomPbZkz
	wS3Wr0nrNgmYc/S6hUJyieL5dRrJ979LcgyNfW4hJ1lEa7Qrla6g1L1KHdYzO4r1rE72Xu+W6oSa6
	IxTHH60VvZT4AFEEW2R1AM42aY7rLgJRzbAJVJlk8YxXVCUUqecrLJA6+8cJIzr5OnR9fmpvUIDp2
	b0bp67rXvqMFz3z3E/gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggX2j-0002uq-8s; Mon, 07 Jan 2019 15:42:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggX2e-0002u2-LM
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:42:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3AF9D20797; Mon,  7 Jan 2019 16:42:11 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id D4B7D20714;
 Mon,  7 Jan 2019 16:42:10 +0100 (CET)
Date: Mon, 7 Jan 2019 16:42:10 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Michal Simek <michal.simek@xilinx.com>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used
 as IRQ controller
Message-ID: <20190107164210.3ecf37e8@windsurf>
In-Reply-To: <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_074216_980275_96B8D13C 
X-CRM114-Status: GOOD (  21.46  )
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
Cc: Josh Cartwright <josh.cartwright@ni.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>, Nava kishore Manne <navam@xilinx.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Borsodi Petr <Petr.Borsodi@i.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

I am reviving this old thread, because the proposed patch (almost)
solves the problem I recently reported with the bad interaction of
runtime PM with the Zynq GPIO driver (see
https://www.spinics.net/lists/linux-gpio/msg35437.html).

On Mon, 14 Aug 2017 16:33:09 +0200, Michal Simek wrote:

> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 9568708a550b..a08a044fa4aa 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1647,14 +1647,22 @@ static void gpiochip_irq_unmap(struct irq_domain
> *d, unsigned int irq)
>  static int gpiochip_irq_reqres(struct irq_data *d)
>  {
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +       int ret;
> 
>         if (!try_module_get(chip->gpiodev->owner))
>                 return -ENODEV;
> 
> +       ret = pm_runtime_get_sync(chip->parent);
> +       if (ret < 0) {
> +               module_put(chip->gpiodev->owner);
> +               return ret;
> +       }
> +
>         if (gpiochip_lock_as_irq(chip, d->hwirq)) {
>                 chip_err(chip,
>                         "unable to lock HW IRQ %lu for IRQ\n",
>                         d->hwirq);
> +               pm_runtime_put(chip->parent);
>                 module_put(chip->gpiodev->owner);
>                 return -EINVAL;
>         }
> @@ -1666,6 +1674,7 @@ static void gpiochip_irq_relres(struct irq_data *d)
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> 
>         gpiochip_unlock_as_irq(chip, d->hwirq);
> +       pm_runtime_put(chip->parent);
>         module_put(chip->gpiodev->owner);
>  }

This patch almost solves the problem. It doesn't work as-is, because it
assumes that runtime PM is used by all GPIO controllers, which is not
the case. When runtime PM is not enabled, pm_runtime_get_sync() fails
with -EACCES, and the whole gpiochip_irq_reqres() function aborts.

The following patch works fine in my case (a MMC card detect signal is
connected to a pin of a PCA GPIO expander over I2C, whose INT# pin is
itself connected to a GPIO pin of the Zynq SoC).

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 20887c62fbb3..bd9a81fc8d56 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -27,6 +27,7 @@
 #include <linux/kfifo.h>
 #include <linux/poll.h>
 #include <linux/timekeeping.h>
+#include <linux/pm_runtime.h>
 #include <uapi/linux/gpio.h>
 
 #include "gpiolib.h"
@@ -3540,12 +3541,23 @@ int gpiochip_reqres_irq(struct gpio_chip *chip, unsigned int offset)
        if (!try_module_get(chip->gpiodev->owner))
                return -ENODEV;
 
+       if (pm_runtime_enabled(chip->parent)) {
+               ret = pm_runtime_get_sync(chip->parent);
+               if (ret < 0) {
+                       module_put(chip->gpiodev->owner);
+                       return ret;
+               }
+       }
+
        ret = gpiochip_lock_as_irq(chip, offset);
        if (ret) {
                chip_err(chip, "unable to lock HW IRQ %u for IRQ\n", offset);
+               if (pm_runtime_enabled(chip->parent))
+                       pm_runtime_put(chip->parent);
                module_put(chip->gpiodev->owner);
                return ret;
        }
+
        return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_reqres_irq);
@@ -3553,6 +3565,8 @@ EXPORT_SYMBOL_GPL(gpiochip_reqres_irq);
 void gpiochip_relres_irq(struct gpio_chip *chip, unsigned int offset)
 {
        gpiochip_unlock_as_irq(chip, offset);
+       if (pm_runtime_enabled(chip->parent))
+               pm_runtime_put(chip->parent);
        module_put(chip->gpiodev->owner);
 }
 EXPORT_SYMBOL_GPL(gpiochip_relres_irq);

However, I must say that from a design perspective, I am not a big fan
of this solution. Indeed for the normal GPIO ->request() and ->free()
hooks, it is currently the GPIO driver itself that is responsible for
runtime PM get/put, so it would be weird to have the runtime PM get/put
for the IRQ request/free be done by the GPIO core.

I believe that either the GPIO core should be in charge of the entire
runtime PM interaction, or it should entirely be the responsibility of
each GPIO controller driver. Having a mixed solution seems very
confusing.

Let me know which direction should be taken so that I can submit a
proper patch to hopefully resolve this issue.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
