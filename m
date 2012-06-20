From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 10:15:01 +0200
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <CAGsJ_4y38KBDfjZS_k-QfDUUFAtEwE-ciUgNOA0U2juOBeoXEA@mail.gmail.com>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
 <20110808081552.GI32513@linux-sh.org>
 <CACxGe6ssT4=kxApaKhv+=7nDcEFVW+oyByFQ_hzcfyZ4gw2C3g@mail.gmail.com>
 <CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
 <4E40912C.5040801@codeaurora.org>
 <CACRpkdZUxYP0Mbe+heEwrZE5VC+J42g_-QAusrOsUuBPT324Hw@mail.gmail.com>
 <CAGsJ_4y38KBDfjZS_k-QfDUUFAtEwE-ciUgNOA0U2juOBeoXEA@mail.gmail.com>
Message-ID: <CACRpkdazTKs_sNHVkVAYdz6CK9fwghf2n-Rrs7fi7R1Z=Gt+3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 5:25 AM, Barry Song <21cnbao@gmail.com> wrote:

> it seems people still use self-defined structure and APIs to set GPIO
> pull,

Yes. They came into existance before the pinctrl subsystem was invented.

> int nmk_gpio_set_pull(int gpio, enum nmk_gpio_pull pull)

Yes, that is one example...

> or actually you mean use "pin_config_get" and "pin_config_set" with
> self-defined configuration to set pull?

I don't quite undertand this part of question, can you elaborate?

The idea is to move this driver over to using the pinctrl API and
delete these functions (or atleast make them static so they are only
used inside the driver itself).

It's taking time since legacy code needs to be handled carefully
and tested on various hardware, sorry for that, but I'm onto it.

> but i think at least the macros of GPIO_PULL_NONE, GPIO_PULL_UP and
> GPIO_PULL_DOWN should be standardized.

You find an attempt at standardization in drivers/pinctrl/pinconf-generic.c
which is also used by the composite U300+COH901 drivers. Drivers
can select this support library and use the flags from
<linux/pinctrl/pinconf-generic.h>

The reason that it's not mandated and some modern SoCs use their
own custom definitions was that it was impossible at the time to
reach consensus (review the mailing list for the discussion, but
mainly it was Mark Brow's arguments that made me give up the
general approach).

So currently this support lib is available if your pin configs are
simple, if they are complex you can cook your own (like many
drivers do).

Yours,
Linus Walleij
