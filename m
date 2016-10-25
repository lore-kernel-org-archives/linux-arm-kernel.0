From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Oct 2016 20:10:00 +0200
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
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
Message-ID: <CACRpkdba_iaOK61KiQGvJZYuz7-PiBgtN4vxv__tJLsZ8ZVL=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 4:47 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 25/10/16 15:22, Jerome Brunet wrote:

>> There is a few problems to guarantee that gpio == hwirq.
>> 1. We have 2 instances of pinctrl, to guarantee that the linux gpio
>> number == hwirq, we would have to guarantee the order in which they are
>> probed. At least this my understanding
>
> Maybe I wasn't clear enough, and my use of gpio is probably wrong. So
> Linux has a gpio number, which is obviously an abstract number (just
> like the Linux irq number). But the pad number, in the context of given
> SoC, is constant. So we have:
>
>         pad->gpio
>         hwirq->irq
>
> Why can't you have pad == hwirq, always? This is already what you have
> in the irqchip driver. This would simplify a lot of things.

My thought as well.

We usually refer to the local numberspace on the GPIO controller
as "offsets", so line offsets 0...31 on a gpiochip with 31 lines.

The ngpio in struct gpio_chip is the number of lines on that controller,
and should nominally map 1:1 to hwirq sources.

Yours,
Linus Walleij
