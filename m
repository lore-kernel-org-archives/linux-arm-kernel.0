From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 9 Apr 2015 14:00:18 +0200
Subject: [PATCH] RFT: pinctrl: samsung: separate wakeup irqdomain
In-Reply-To: <1428565241-5099-1-git-send-email-linus.walleij@linaro.org>
References: <1428565241-5099-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CA+Ln22GdPGJ7j6piBxAE6xBb7WUx4TSfZEOWp4728NxZ4gDW5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2015-04-09 9:40 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> The Samsung pin control driver and subdrivers sometimes use both
> an irqdomain for some IRQs and another irqdomain for wakeup irqs,
> registering the first with a call to the per-SoC callback
> .eint_gpio_init() and the second with a call to .eint_wkup_init()
> however it seems both runpaths will assign the resulting irqdomain
> to the per-bank bank.irq_domain member, making the second
> (wakeup) irqdomain overwrite the first one.
>
> I'm surprised this even works, and it seems that the S3C
> per-domain "domain data" that seems to be used in part to work
> around this bug by creating a local array with copies of the
> irqdomain (!).
>
> This patch mainly adds a new record to the GPIO/pin "bank"
> for wakeups and use this in the .eint_wkup_init() callbacks
> to pave the way for more cleanups.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Tomasz etc: I don't know if I'm just misunderstanding this,
> can you look at it and tell me how badly I misunderstand
> these Samsung wakeups, to me it is a complete mystery.

On all Samsung SoCs known to me, there is no GPIO bank which have both
eint_wkup and eint_gpio functions at the same time, so there is no way
that bank->irq_domain could be overwritten.

On S3C64xx, the arrays in domain data are necessary to work around
crazy layout of pin banks which do not fully correspond to EINT banks
in the controller.

So, in general, I don't think there is really any problem with this
driver at the moment. If, in future, a SoC shows up with both IRQ
types in the same pin bank, then it will have to be reworked, but I
don't see why such thing could show up in a SoC, because it wouldn't
really add any value.

Best regards,
Tomasz
