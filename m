From: rabin@rab.in (Rabin Vincent)
Date: Wed, 23 Feb 2011 20:52:07 +0530
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <20110223131805.GK29559@n2100.arm.linux.org.uk>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
	<20110223131805.GK29559@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin+F_wYaeUGakwLMuDp8PxjFGWZh8p9f_wGOcUK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 18:48, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 23, 2011 at 06:24:50PM +0530, Rabin Vincent wrote:
>> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
>> does, so it can become one. ?This is also needed for changing the GIC
>> implementation to a different flow handler.
>
> So you want to allow other people to request the GPIO interrupt?

No, but we request it without IRQF_SHARED so why would other people be
able to do so?  If they had done it before, there will be an error here.

> You also want to have the IRQ tracing code called once for entry into
> this handler and once for each GPIO interrupt which is pending?

Because the GPIO interrupts come via a different parent interrupt (the
secondary handler stuff) when in certain low power states, it may be
useful to see which parent the interrupt comes from.  Not a deal breaker
though.

> You want to have the overhead of dealing with the inprogress stuff, etc?
>
> I really don't like the idea of getting rid of the interrupt chaining
> and reverting back to the proven-to-be-broken 2.2 kernel way of handing
> this kind of thing - which is exactly what you're doing here.

I thought it was the recommendation in the other thread to have chained
interrupts that do nothing but the normal irq handling to just use that.
With the GIC fasteoi change we will anyway not have the interrupt being
masked.  The secondary irq handler chip uses handle_simple_irq so that
should be OK too.

Anyway, I guess there's no strong reason to drop the chained handler,
and we can do without any unnecessary overheads so I will just preserve
the chained handler and do only the eoi here (along with the GIC
conversion).
