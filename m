From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 00:12:39 +0100
Subject: [PATCH v4] Introduce irqchip infrastructure
In-Reply-To: <50AC065C.7000305@gmail.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AC065C.7000305@gmail.com>
Message-ID: <20121121001239.3ca7a87d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, 20 Nov 2012 16:38:20 -0600, Rob Herring wrote:

> > Remaining issues to solve:
> > 
> >  * Russell would like arch/arm/include/asm/hardware/vic.h and
> >    arch/arm/include/asm/hardware/gic.h to move elsewhere, since the
> >    corresponding code is no longer in arch/arm/. I can move them in
> >    <linux/irqchip>, but that will cause a fairly large change as there
> >    are a big number of users of those headers in arch/arm.
> 
> We need to do this. KVM will need the header as well, so we can't move
> the register definitions out either.

Which register definitions are you talking about? The one from vic.h ?

> >  * The arch/arm/include/asm/hardware/vic.h has a few offset macros
> >    that should move into the .c file of the irqchip driver, but some
> >    of those offsets are bizarrely used in some other pieces of code in
> >    arch/arm/.
> 
> Not really a good solution that I can see there. We could punt on doing
> the VIC for now.

Well, most of the VIC macro users are strange. Most of them probably
need their own macro definition instead of shamelessly borrowing the
VIC definitions.

> >  * How to get rid entirely of the headers in <linux/irqchip/>. The
> >    remaining problematic functions are <foo>_handle_irq() and
> >    <foo>_irq_init() that are used by non-DT platforms. And the special
> >    case of gic_cascade_irq().
> 
> I have patches for removing vic/gic_handle_irq. It is going to take a
> while for the others, so I don't think we should wait for that. KVM
> needs the GIC header anyway.

What is your approach to remove vic/gic_handle_irq? I'll see in your
patches I guess.

That said, I think that having <linux/irqchip/gic.h> and
<linux/irqchip/vic.h> for now is not a big problem. What we want to
avoid is to have gazillions of headers here, but as new platforms are
DT-capable, those platforms shouldn't need to add a header in
<linux/irqchip/>, so I think we could live with
<linux/irqchip/{gic,vic}.h> for a while, and progressively clean
up/improve what needs to be done. Doing the perfect migration as an
unique step is going to be difficult.

> >  * Move all the users of gic_of_init() to the irqchip mechanism
> >    (Exynos, i.MX 6, MSM, OMAP, SH Mobile, socfpga, spear13xx, tegra,
> >    ux500, vexpress) so that gic_of_init() no longer has to be
> >    exported.
> 
> I have a patch doing this. I will try to get this sent out today. I've
> split this into clean-up and then the move, so the clean-up could go in
> for 3.8. It is only dependent on patch 2.

Ok.

> > Of course, I don't expect any of this to go in 3.8, it is 3.9 material
> > if we manage to reach a consensus on the remaining issues to solve
> > (and the other issues that will certainly show up or be raised by
> > other people).
> 
> I still would like to try to get this in for 3.8. If not the move, some
> of the clean-up.

So the cleanup series for 3.8 would contain:

 [PATCH 02/16], needed for the clean up you will send later today
 [PATCH 06/16]
 [PATCH 07/16]

I think all the other ones are directly related to the introduction of
the irqchip infrastructure, so they most likely cannot be part of 3.8.

So, I can prepare a pull request with 2, 6, 7 and your upcoming clean
up patch, if you want.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
