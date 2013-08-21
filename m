From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 01:44:42 +0200
Subject: [PATCH v2] pinctrl: queue GPIO operations instead of defering
In-Reply-To: <52154BF9.1060704@wwwdotorg.org>
References: <1376751410-14560-1-git-send-email-linus.walleij@linaro.org>
 <52126EDE.5060000@wwwdotorg.org>
 <CACRpkdasWurMctYTMZCHS+fwhvmnREaQD1vN54QYpMToTuFjsg@mail.gmail.com>
 <52154BF9.1060704@wwwdotorg.org>
Message-ID: <CACRpkdbOd+16L7w5VFJi2bdnwh94gLv3hR=qE+_ao9HrNOFfPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 1:23 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Shouldn't this simply be fixed inside whichever driver is performing
> circular operations, rather than leaving the driver performing circular
> operations, and attemping to make the subsystems support something that
> can't be supported?

It was part of that series, but I thought about it and saw that
it'd be nice if the GPIO probing would not have to defer
due to the pin controller not being up yet anyway.

I'll just reword the subject like that... like some nice
optimization.

Actually I think we should be able to register GPIO ranges
before the backing pin controller is up as well for the
same reason, letting such things queue up will make
the boot more optimal in some cases and get people
away from playing around with initcall levels.

>> This is what the other patch we're discussing is doing.
>> The one that harvests and requests interrupt GPIO's when
>> a gpiochip is added...
>
> It would have been good to mention the two patches were related, or did
> I just miss that?

In the first posting it was. I need to refine the motivation
per above instead.

> So that's another reason for me to object to that other patch. If that
> whole process was triggered inside the IRQ controller implementation,
> which is logically part of the GPIO controller implementation for the
> same HW, the call direction would also be GPIO -> pinctrl or IRQ -> GPIO
> -> pinctrl, and hence have no circular issues.

Hm not quite following, but it was not triggered from the IRQ
controller. It was triggered from the gpiolib-of.c trying to
do gpio_request() and gpio_set_input() right after registering
a GPIO controller. (Which should be possible, it's a bug in
its own right that this is not possible on the Nomadik driver...)

Yours,
Linus Walleij
