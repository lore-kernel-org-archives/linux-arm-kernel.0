From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Feb 2013 16:12:25 +0000
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <CANqRtoS9uK-xmAvvP=ujVDqDBqe7+c_p5G4QOK6o=FNQEmvT5A@mail.gmail.com>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <201302261018.28463.arnd@arndb.de>
 <CANqRtoS9uK-xmAvvP=ujVDqDBqe7+c_p5G4QOK6o=FNQEmvT5A@mail.gmail.com>
Message-ID: <201302261612.25444.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 February 2013, Magnus Damm wrote:
> On Tue, Feb 26, 2013 at 7:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 25 February 2013, Magnus Damm wrote:
> > You are right that ioremap cannot be used from ->smp_init_cpus() and any
> > code called from there needs to use a static mapping for accessing
> > MMIO registers. There is nothing wrong with that. There are in fact
> > three distinct reasons why people use static MMIO mappings with
> > iotable_init():
> >
> > 1. For MMIO registers that need to be accessed before ioremap works.
> >    This usually means the SMP startup and the early printk (which I
> >    believe shmobile is not using).
> 
> Thanks for describing these.
> 
> Is there any particular reason why SMP startup needs to happen earlier
> than ioremap() is available?

I think it's mostly traditional reason I think.

> From a hardware point of view on Cortex-A9 the SCU needs to be enabled
> and the number of available cores need to be determined. The SCU
> enabling can probably happen later and the number of cores are already
> limited to the kernel configuration maximum number of cores setting,
> so it should be possible to use that to size any early per-cpu
> variables if needed. So I wonder why we're not enabling SMP later than
> we actually do? Using maxcpus=1 and late CPU hotplug from user space
> is certainly working fine.

AFAIK, on Cortex-A15 we already rely on getting the number of cores from
the device tree, which is also available at the right time, without
the need for an early mapping. It would not be hard to do the same
on Cortex-A9. Then again, the static mapping there does not do harm
as I said.
 
> Regarding early printk, you are correct that we're not using that ARM
> specific debug output. Instead we are relying on earlyprintk via early
> platform devices. This way we are not only multi-soc and multi-subarch
> already, we are also multi-arch. For really early console output we
> rely on the clocks and pin function being initialized by the boot
> loader and we also require 1:1 entity mappings so we can use printouts
> before ioremap() is functional. So yes, we like using 1:1 virt-phys
> memory maps for early printouts.

Ok.

> We do not use early printk with DT at this point. If we would be able
> to move the SMP init later then perhaps we could debug SMP issues with
> serial ports described by DT in the future?
>
> > 3. For hardcoding the virtual address to a location that is passed
> >    to device drivers as compile-time constants.
> >
> > The first two are absolutely fine, there are no objections to those.
> 
> Ok. As you probably can tell by now - I would like to get rid of the
> SMP case if possible.

I would certainly welcome a patch that moves the SMP initialization
to a later point. I'm not sure if it requires changes to architecture
independent code, but it does sound like a good idea.

> > The third one is tradtitionally used on a lot of the older platforms,
> > but with the multiplatform work, we are moving away from it, towards
> > passing resources in the platform device (ideally from DT, but that
> > is an orthogonal question here). AFAICT, shmobile is the only "modern"
> > platform that still relies on fixed virtual addresses, and it is the
> > only one I know that uses a mapping where the virtual address equals
> > the physical address.
> 
> The 1:1 mapping is deliberately chosen to be simple. So in the case
> when people do register I/O without ioremap() then at least we can
> look up the address in the data sheet. I've seen too many examples of
> people not using ioremap and instead inventing their own magic mapping
> table with undocumented hard coded address that map to something even
> more unknown. Of course we should be aiming at using ioremap(). If we
> for some reason can't then we should use 1:1 mappings.

Well, I would argue that when someone doesn't understand the basic
interfaces we expose to device drivers, they probably shouldn't
be writing kernel code. ;)

> While I agree to move more towards using ioremap(), I can't really see
> how this affects our multiplatform situation. Our device drivers have
> always been using the driver model and we do never export any virtual
> addresses in any header files. If you have any particular area that
> you think needs work related to ioremap() then perhaps we can get
> together on next conference and talk it through?

It may not be as bad as I thought. I know that at least the intc
controller is fundamentally built around this assumption (I tried changing
it, and that didn't end well), but that may be the only one, following
the recent cleanup of the pfc driver.

The main worry is probably that people will take the platform code
as example when writing device drivers, and that uses hardcoded
IOMEM() macros.  There are probably a couple of instances where that
is the best solution, but for those, I would suggest using offsets
from a base register that gets passed into iotable_init() rather
than literal numbers.

> As I mentioned before, from my point of view the main limiting factor
> for mach-shmobile multiplatform at this point is the clock framework.
> The SH clock framework does already support ioremap() though, so it is
> just a matter of making the clock code actually use it. And while
> we're doing that we may as well solve the multiplatform issue to and
> move towards common clocks.

Ok, good to hear.

	Arnd
