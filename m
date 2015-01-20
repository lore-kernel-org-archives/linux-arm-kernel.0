From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jan 2015 10:53:07 +0100
Subject: [PATCH v6 2/3] gpio: Cygnus: add GPIO driver
In-Reply-To: <54B9A8A2.6090209@broadcom.com>
References: <rjui@broadcom.com>
 <1418696307-19392-1-git-send-email-rjui@broadcom.com>
 <1418696307-19392-3-git-send-email-rjui@broadcom.com>
 <CACRpkdYGksEseGaO49=1rUi5WBdOxwAd-F1gpgZn+BFatRCdDg@mail.gmail.com>
 <54B55068.8050500@broadcom.com>
 <CACRpkdZef8S-EAbShjJ1eg+-3wQKn+yx4u1k_Mf8F7uFkJYdFw@mail.gmail.com>
 <54B9A8A2.6090209@broadcom.com>
Message-ID: <CACRpkdYydCO9Wu3fMyh0qt=e_hxT5ch2gqNhEsfQpf5WYUS-kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 1:11 AM, Ray Jui <rjui@broadcom.com> wrote:
> On 1/16/2015 2:14 AM, Linus Walleij wrote:

>> Some hardware designs put the software-controlled biasing
>> resistors in the GPIO block electronically connected to the actual
>> pins, so that e.g. the biasing will be available if some MMC or
>> whatever is using the same pins in another muxing. In such
>> situations it's quite evident that they need to be a combined
>> GPIO and pin controller.
>>
>> I have some regrets that bolting a second pin controller to the
>> GPIO chip make things a bit complex but it's a price we have
>> to pay for getting some kind of generic interface.
>
> Okay. In summary, I think both of us think the following approach makes
> sense in my situation:
> - leave pinmux in pinctrl-bcm-cygnus.c
> - leave pinctrl + gpio in pinctrl-bcm-cygnus-gpio.c under drivers/pinctrl/*
>
> But by thinking about this more, I thought this would create duplicated
> pinctrl descriptors in our system, one from the pinmux driver, and the
> other from this pinctrl+gpio driver. That is probably undesirable?

No, there are several systems with multiple pin controllers and the
framework easily handles multiple pin controllers in the same
system just as well as we handle multiple GPIO chips.

> By reviewing various drivers in the pinctrl directory, I found what
> pinctrl-u300.c and pinctrl-coh901.c does seems to serve as a good model
> for me to follow:
> - pinctrl-u300.c is the pinmux driver
> - pinctrl-coh901.c is the gpio+pinctrl driver

Yeah, I don't know if the separation between them is as beautiful
as it should be. I used it when developing the pin control
subsystem.

> The GPIO pinctrl logic is in the coh901 block, so pinctrl-coh901.c
> exposed two public functions u300_gpio_config_get, u300_gpio_config_set
> that pinctrl-u300.c can use. The u300 populates all pinmux/pinctrl
> related functions into the subsystem. This way there's only one pinctrl
> descriptor, populated through pinctrl-u300.c.
>
> Does that model make more sense to you?

Yeah I wrote it myself so I'm maybe blind for any dumbness in
the code. But I think it's kind of elegant. But it is not using the
generic pinctrl device tree bindings so it's kind of oldstyle and
bloated in that sense.

Yours,
Linus Walleij
