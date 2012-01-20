From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Jan 2012 16:45:40 +0100
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120120130310.GO1068@n2100.arm.linux.org.uk>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 2:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 20, 2012 at 01:59:16PM +0100, Per Fransson wrote:
>> Use irq_set_affinity() to initialize the kernel view of irq affinity
>> when programming the GIC registers.
>
> Why is this necessary?

Necessary: we don't quite know. (Maybe should have been RFC, but
this patch is better than being silent of it...)

On the Ux500 all shared peripheral IRQs (32 thru 127) are delivered
to CPU0 (hardwired, will not work on CPU1), I have heard that this
is sort of what everybody does but don't know for sure. (Marc?)

Currently the gic_set_affinity() in common/gic.c isn't called for any
IRQs so they are left in their power-on state (from U-Boot or
similar) which is essentially correct (we checked dumps of the
registers).

However when we look at the irq descriptors in e.g. crash:

    crash> irq -s
    IRQ NAME                 AFFINITY
     36 Nomadik Timer Tick   0
     43 uart-pl011           0-1
     44 nmk-i2c              0-1
     46 pl022                0-1
     53 nmk-i2c              0-1
     54 nmk-i2c              0-1
    (... etc ...)

So the descriptors think the IRQs are shared except for the
timer. Which isn't true. So this patch makes the map match
reality.

> And if it is necessary, why do you think it
> should be ux500 specific?

Good question. If this is the case for all SMP gic users maybe we
should make the code #ifdef CONFIG_SMP inside gic.c instead?
(Sans the check for the modem IRQs, they should probably also
be made affine to CPU0.)

Yours,
Linus Walleij
