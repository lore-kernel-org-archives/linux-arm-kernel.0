From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Sep 2012 22:08:44 +0200
Subject: [PATCH] ARM: GIC: dont warn on pre-allocated IRQ descs
In-Reply-To: <506205E4.4050803@gmail.com>
References: <1348600794-2395-1-git-send-email-linus.walleij@stericsson.com>
 <506205E4.4050803@gmail.com>
Message-ID: <CACRpkdbJ828orOkXUnjuJh1iHA8Fe3AuuQRiQiYt0XFuvsWO=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 9:28 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/25/2012 02:19 PM, Linus Walleij wrote:

>> The allocation will succeed if the platform define .nr_irqs
>> to 0 as an ideal device tree platform would do, but I think it
>> is a bit thick to require that every platform that wants to
>> use sparse IRQs must first or simultaneously switch to
>> device tree. So make this to a simple pr_debug().
>
> It's not a matter of switching to DT or not. It is a matter of whether
> an irq_chip allocates it's descriptors or not either directly or
> indirectly via irqdomain.

Yeah OK that's true.

> The gic does this, so it is secondary
> controllers which are the problem. A platform could allocate the ranges
> needed for those controllers and leave a hole for the gic to allocate.
>
> A prefer to leave this so platforms get fixed.

Since the core kernel will allocate .nr_irqs on boot I guess
this means you have to define the machine's .nr_irqs to
zero or atleast < 16 so it doesn't overlap with those the
GIC wants to use.

So I'll try that, and ad-hoc allocate descriptors needed
above that range for drivers that are not yet allocating
their descriptors ...

One question though: the real fix is obviously for all
drivers exposing an irqchip to allocate its descriptors
dynamically with exlicit alloc_descs() or using the
linear irq domain instead of relying on pre-allocated
descriptors.

Should we patch all drivers to spit out similar warnings
then?

Yours,
Linus Walleij
