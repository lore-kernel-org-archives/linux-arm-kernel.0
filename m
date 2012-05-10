From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 11:26:57 +0100
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
Message-ID: <20120510102657.GD3190@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 11:02:27AM +0200, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch will allow the ab8500-core driver to be probed and set up
> > when booting when Device Tree is enabled. This includes platform ID
> > look-up which identifies the machine it is currently running on. If
> > we are undergoing a DT enabled boot, we will refuse to setup each of
> > the other ab8500-* devices, as they will be probed individually by DT.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
> > + ? ? ? else if (np)
> > + ? ? ? ? ? ? ? ret = of_property_read_u32(np, "stericsson,irq-base", &ab8500->irq_base);
> > +
> > + ? ? ? if (ab8500->irq_base == 0) {
> 
> Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> use 0 as NO_IRQ?

No it shouldn't.  We want new drivers to be rejecting on explicitly zero
IRQ numbers and not using NO_IRQ at all.  We want to get rid of NO_IRQ
entirely.

At the moment, NO_IRQ is a marker for "this is a mistake which needs
fixing" and allows them to be found by grep.

What we need is more of an effort so that platforms do not start numbering
IRQs at zero, but start at one.

(I could fix up SA11x0, which would then allow the SA1111 code to be fixed,
but I've not had time to look at that during this last cycle.  Others need
their maintainers who know the code to fix them.)

I brought up the issue of the new introduction of NO_IRQ in the previously
clean versatile express code, and failed to get any reply.

So, I think what I'll do when I've eliminated all those that I can do is
to remove the definition from our asm/irq.h and cause a load of build
errors in linux-next.  This seems to be the _only_ way to motivate people
into fixing these kinds of issues.  Which is awfully sad.  I'd much
rather people just had the carrot instead but as ever its proven many
times that people just ignore such things.
