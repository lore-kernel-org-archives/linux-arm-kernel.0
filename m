From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 06:03:35 +0000
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
 <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
Message-ID: <20141106060335.GR8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 01:33:24AM +0400, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:43 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:

> > Yes that's the point: if you use regmap mmio you get the RMW-locking
> > for free, with the regmap implementation.

> Just to be more concrete. Currently locomo_gpio_ack_irq() function uses
> one lock and one unlock for doing 3 consecutive RMW I I convert locomo
> to regmap, will that be 3 lock/unlock calls or still one? (Or maybe I'm
> trying to be over-protective here and adding more lock/unlock cycles
> won't matter that much?)

You'll get three lock/unlocks, we could add an interface for bulk
updates under one lock if it's important though.

> Next question: if I have to export regmap to several subdrivers, is it better
> to have one big regmap or to have one-map-per-driver approach?

One regmap for the physical register map which is shared between all the
users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/c6aade1d/attachment-0001.sig>
