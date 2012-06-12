From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 13:39:57 +0200
Subject: [PATCH] PINCTRL: SiRF: add CSR SiRFprimaII GPIO driver depending
 on pinmux APIs
In-Reply-To: <CAGsJ_4y22H-6cZquxYDm40At=sYXvBHnvJ7ZqK9z5no9MLO+Kg@mail.gmail.com>
References: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdZOTZaVp6rfuQvZaQyk0+zxeAjwHryBMYY-C1WVABaLLA@mail.gmail.com>
 <CAGsJ_4zknQjNK6-T7+av1N=7gijZ821keM=qaDEJZ9zOfnLhkw@mail.gmail.com>
 <CACRpkdb=00UP3NaBj4NhVy0wYhwkqqRB5e3Gid5hcpVhxH0wYw@mail.gmail.com>
 <CAGsJ_4yz=-szdaLWgKbTHkZtO+zqZvM35gXCHBprto=odjs41w@mail.gmail.com>
 <CACRpkdZuge1vJquaSoYjk+zFEU+yafSG3L4UhRDhAZww73-RZg@mail.gmail.com>
 <CAGsJ_4y22H-6cZquxYDm40At=sYXvBHnvJ7ZqK9z5no9MLO+Kg@mail.gmail.com>
Message-ID: <CACRpkdZ5Lj1gprCBA4Y7Mv5y4yQ8KbzuQKaSnPsR2nPdgRKkTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 3:16 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/5/29 Linus Walleij <linus.walleij@linaro.org>:

>> I don't really have an opinion on this, you can do it either way.
>>
>> It's nice to split the files into separate drivers for smaller files and
>> cleanly cut devices.
>>
>> It's also nice to have it all in one file so you can get the whole picture
>> of how the hardware works.
>
> i think i'd better to have one driver for both. if i move to
> gpio-generic driver for gpio module, gpio-generic driver will not
> request gpio from pinctrl, but i need. and on the other hand,
> gpio-generic doesn't include irq_chip, but i need.
> so to me, gpio-generic driver is much like just for a single-function
> gpio controller not good for a multi-function pinmux/gpio/irq
> controller.

OK that makes sense I thought you didn't need to cross-correlate
them.

>> Usually the problem has been to cross-reference the GPIO ranges
>> from another driver, like adding the struct gpio_chip * to the ranges,
>> but it seems you don't have this problem in your driver? If you think
>> you will run into this problem, merge it into the pinctrl driver to
>> save yourself from lots of trouble.
>
> for the range issue, basically we have a (pinmux pin, gpio, irq) pair,
> one pinmux pin can be a gpio pin and an external irq source , so
> actually, i need to pinctrl_request_gpio() in my gpio_chip.request().
> i would think prima2 pinctrl driver can be much like pinctrl-nomadik.c
> and pinctrl-coh901.c, which are all of pinmux, gpio and irq chip. ?i
> might follow them and improve pinctrl-sirf.c to include gpio/irq too.

Yep, but now I see you haven't used irqdomain to map between
gpios and IRQs so I will hit you with one more review comment.
We try to get all gpio offset -> IRQ mapping done using
irqdomains.

Yours,
Linus Walleij
