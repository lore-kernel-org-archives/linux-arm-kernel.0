From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Oct 2016 16:32:29 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <1477491766.2482.159.camel@baylibre.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
 <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
 <1477400900.2482.51.camel@baylibre.com>
 <dee26f0b-e175-f8a0-2b73-08e8e324841c@arm.com>
 <1477405332.2482.87.camel@baylibre.com>
 <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
 <1477409478.2482.113.camel@baylibre.com>
 <CACRpkdbGo4BJOdzkgBrE9jT-rKodd4zssCnOtOuGS+OqV-Uc6Q@mail.gmail.com>
 <1477491766.2482.159.camel@baylibre.com>
Message-ID: <CACRpkdYqoU0foW1izcZapbgUm+NO4quz9AZZBmts4841BRcigA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 4:22 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Tue, 2016-10-25 at 20:20 +0200, Linus Walleij wrote:

>> However the semantic is such, that it is not necessary to call
>> to_irq()
>> before using an IRQ: the irqchip and gpiochip abstractions should be
>> orthogonal.
>
> Linus,
>
> They are orthogonal. You can request an irq from the irqchip controller
> without the gpiochip, like any other irq controller.

OK good, sorry if I'm stating the obvious.

> irq_create_mapping (and irq_create_fwspec_mapping) internally calls
> irq_find_mapping. So if the mapping already exist (the irq is already
> used before calling to_irq), the existing mapping will be returned. The
> mapping will be actually created only if needed. It seems to be in line
> with your explanation, no ?

Yes, but you want to call irq_create_mapping() in slowpath (irq setup)
and irq_find_mapping() in fastpath (irq handler). Else the first IRQ
may result in unwelcomed surprises.

> There is really a *lot* of gpio drivers which use irq_create_mapping in
> the to_irq callback, are these all wrong ?

Yes they are all wrong. They should all be using irq_find_mapping().

> If this should not be used, what should we all do instead ?

Call irq_create_mapping() in some other place.

Yours,
Linus Walleij
