From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 17:50:18 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
Message-ID: <20120120175018.GC11845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 04:45:40PM +0100, Linus Walleij wrote:
> On the Ux500 all shared peripheral IRQs (32 thru 127) are delivered
> to CPU0 (hardwired, will not work on CPU1), I have heard that this
> is sort of what everybody does but don't know for sure. (Marc?)

BTW, if you can't route IRQs to a CPU, then we'll need a hook to
refuse the affinity call.

> Currently the gic_set_affinity() in common/gic.c isn't called for any
> IRQs so they are left in their power-on state (from U-Boot or
> similar) which is essentially correct (we checked dumps of the
> registers).

No they aren't.  See the gic code:

        cpu = cpu_logical_map(smp_processor_id());
        cpumask = 1 << cpu;
        cpumask |= cpumask << 8;
        cpumask |= cpumask << 16;

        /*
         * Set all global interrupts to this CPU only.
         */
        for (i = 32; i < gic_irqs; i += 4)
                writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);

At boot, we program _all_ the GIC IRQs to point@the boot CPU as part
of the initialization, which will be logical CPU 0.

> However when we look at the irq descriptors in e.g. crash:
> 
>     crash> irq -s
>     IRQ NAME                 AFFINITY
>      36 Nomadik Timer Tick   0
>      43 uart-pl011           0-1
>      44 nmk-i2c              0-1
>      46 pl022                0-1
>      53 nmk-i2c              0-1
>      54 nmk-i2c              0-1
>     (... etc ...)

Yes, and as I said in my previous email, having the affinity mask report
more CPUs than we set the hardware to is perfectly legal.  What you've
pointed out above is that setting an affinity mask of _just_ CPU1 should
be made fail on Ux500.

In other words, when setting an affinity, if:

	affinity & online_mask & ~invalid_cpus

is zero, then we should fail the request to set the affinity.

But that doesn't mean that setting the affinity to ~0 (all CPUs, including
the invalid CPUs) should be failed.
