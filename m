From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Oct 2014 10:52:47 +0100
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <2988580.WvjMBY1UOc@wuerfel>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <1412779948-28769-2-git-send-email-yvo@apm.com>
 <CACRpkdY3-Y0eA_o2enfxbqWUpwPoo_5oM9t=uU=QSTAw4MPf9Q@mail.gmail.com>
 <2988580.WvjMBY1UOc@wuerfel>
Message-ID: <CACRpkdao2F1NK-3QpqSOLzFdvjWFVU4HqcqZPA2fXHpQN=BUsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 3:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 October 2014 14:14:43 Linus Walleij wrote:
>> On Wed, Oct 8, 2014 at 4:52 PM, Y Vo <yvo@apm.com> wrote:

>> > +       apm_gc->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
>> > +                                  GFP_KERNEL);
>> > +       if (!apm_gc->irq)
>> > +               return -ENOMEM;
>> > +       memset(apm_gc->irq, 0, sizeof(u32) * XGENE_MAX_GPIO_DS);
>> (...)
>> > +       for (i = 0; i < apm_gc->nirq; i++) {
>> > +               apm_gc->irq[default_pins[i]] = platform_get_irq(pdev, i);
>>
>> So the IRQs for all the GPIO pins are handled somewhere else instead
>> of being a cascaded IRQ controller.
>>
>> This means that the IRQ lines from each individual GPIO pin is
>> connected to a unique IRQ line on a secondary interrupt controller,
>> instead of the GPIO block being a cascaded interrupt controller
>> in its own right.
>>
>> Is this correct?
>
> See the discussion I had on this. Yes, each line is connected to a
> GIC SPI interrupt by itself. I've discussed this with Marc Zyngier
> and Thomas Gleixner at the conference last week, and we concluded
> that we will need a new generic interface to get data out of the
> parent interrupt controller in a proper way. The current implementation
> just maps the GIC registers and reads them directly, which of course
> is not a proper way to do it.

Hmmmmmm. OK shall we hold this driver until the infrastructure
issues are resolved?

The following is a recurring pattern among GPIO controllers:
the GPIO controller can go offline (asycnhcronous) and while it
is offline a secondary logic triggers an IRQ that wakes the system
up, however the GPIO logic cannot really "see" that IRQ since
it was sleeping when it arrived.

Thus a latent IRQ is pending in the wakeup logic. This concept
exists in drivers/pinctrl/nomadik/pinctrl-nomadik.c and I strongly
prefer to call these "latent irqs" as it's a clear unambigous
terminology.

So is this a case of latent IRQs pending in the GIC?

Yours,
Linus Walleij
