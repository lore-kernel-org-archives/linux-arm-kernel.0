From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 29 Jul 2012 14:09:56 +0000
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <5013B750.6060608@gmail.com>
 <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
Message-ID: <201207291409.56645.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 July 2012, Haojian Zhuang wrote:
> On Sat, Jul 28, 2012 at 5:56 PM, Daniel Mack <zonque@gmail.com> wrote:
> >> Since we have DT support at here. Could we use property for interrupt priority?
> >
> > Not sure what you mean here. Can you elaborate? I couldn't find any
> > reference to IRQ priorities in other platforms either.
> >
> > Maybe we can also add that in a separate patch, which would also help in
> > tracking possible regressions du to such a change?
> >
> cpu_has_ipr() returns true if CPU isn't PXA25x.
> My point is that we can avoid to use cpu_is_xxx() while DT is used. We only need
> to append a property "marvell,intc-priority" is DTS. So the code could
> be changed
> in below.
> if (of_find_property(np, "marvell,intc-priority", NULL))
>            __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));

I think we can do even better if we extend the binding for this interrupt controller
driver to have either #interrupt-cells=<1> or #interrupt-cells=<2>, depending on the
chip that is being used. If the it is <1> (for pxa25x), then any driver would
just use a bare interrupt number. If it's <2> (for all others), the driver would
specify both the interrupt number and the priority, and we set up the register at
the time when the interrupt gets enabled.

Do you think that would work?

	Arnd
