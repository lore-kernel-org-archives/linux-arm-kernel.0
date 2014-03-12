From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:49:39 +0100
Subject: [PATCH] irq: Consider a negative return value of irq_startup() as
 an error
In-Reply-To: <alpine.DEB.2.02.1403080857160.18573@ionos.tec.linutronix.de>
References: <1393345719-3707-1-git-send-email-jjhiblot@traphandler.com>
 <alpine.DEB.2.02.1402262119560.4174@ionos.tec.linutronix.de>
 <CACRpkdZ6D1XfDBdJEcR8G2HWkNcZSfz08Yvx8f0s+CqTUmybkg@mail.gmail.com>
 <alpine.DEB.2.02.1403080857160.18573@ionos.tec.linutronix.de>
Message-ID: <CACRpkdb=51_D6kxWcmSSRdr3kROXiwJbRzQDS-1VxEJpBjVyUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 8, 2014 at 10:15 AM, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 7 Mar 2014, Linus Walleij wrote:
>> I'll see what Jean-Jacques comes up with and take it from there unless
>> he's interested in taking it all the way.
>
> Thought more about it while trying to come up with a persuasive
> argument for the other Linus to take the irq_startup change that late
> in the cycle:
>
> Using startup is the wrong point in __setup_irq() because we call
> chip->irq_set_type() before we call chip->irq_startup(). And we want
> this to be in that order to avoid spurious interrupts.
>
> Proper solution below. That leaves the startup/unmask logic untouched
> and provides separate callbacks for this kind of requirements. That
> makes it also simpler to have common functions for all gpios as you
> don't have to do the mask/unmask dance in startup/shutdown. So you can
> simply create gpio_irq_request/release_resources() and let the drivers
> add those to their callbacks.
>
> If you agree, I put that into a separate branch based on an upstream
> -rc so you can pull it into your gpiolib stuff and work from there.

Yeah I really like the looks of this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

We need to think about whether the gpiolib changes are serious
enough to be pushed this late in the -rc cycle though.

The thing is that the flagging of GPIO lines as IRQs was to fix
up the ages-old mess of sequential semantic dependencies between
different unrelated gpiolib and irqchip calls, and these bugs have
been around since the first irqchip was implemented in
drivers/gpio I think :-(

But if you prefer, I'll surely do it.

Yours,
Linus Walleij
