From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 6 Aug 2013 19:25:45 +0400
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201308052300.22400.arnd@arndb.de>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <201308052126.08078.arnd@arndb.de>
 <20130806004223.2764bb83ce5f254b5e4fc170@mail.ru>
 <201308052300.22400.arnd@arndb.de>
Message-ID: <20130806192545.602cfa27d5e3471f62de9512@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Aug 2013 23:00:22 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 05 August 2013, Alexander Shiyan wrote:
> > On Mon, 5 Aug 2013 21:26:07 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > On Monday 05 August 2013, Alexander Shiyan wrote:
> > 
> > > > > Handling them in the irqchip driver probably seemed like a logical solution
> > > > > when the code was initially written, but if you move that access into the
> > > > > device drivers, you can probably remove the irqchip driver entirely and just
> > > > > use the generic irqchip implementation.
> > > > 
> > > > ioremap for a whole set of CPU registers is called from map_io, so ioremap
> > > > returns already mapped address, that is, it's just converting physical to
> > > > virtual addresses.
> > > 
> > > I see, that does make things better at least.
> > > 
> > > It would be nice to change the DT binding in some way so the register
> > > ranges are non-overlapping, but I'm not going to insist if the other
> > > reviewers are ok with the small inconsistency here.
> > > 
> > > Do you have any reason for not using the syscon driver for these
> > > registers?
> > 
> > I plan to use syscon for some registers to ensure the correct sequence
> > of read-modify-write. For all other registers, the access to which is not
> > needed from the different subsystems, it does not make sense and seriously
> > degrade performance due to locks.
> 
> Have you measure this? MMIO accesses are typically really slow already, they
> can be multiple orders of magnitude slower than the locks. Also, note that
> spinlocks get optimized out on uniprocessor machines.

No, I just keep in mind that any access to any register in regmap (SYSCON)
will block access to the registers of the other modules, and it will increase
the interrupt latency.

> The main reason why syscon was introduced is to handle MMIO register sets
> that span multiple devices within a small range, which is exactly what you
> have here. You could simply have a single ioremap in the syscon driver
> and refer to register offsets from drivers using the syscon binding. You
> could then actually describe all the EIO registers in a way that 
> 
> > As alternative, I can completely remove clps711x_ioremap_one() and simply
> > duplicate ioremap() for the entire range set of registers
> > (without request_mem_region). The functionality of driver will remain the same.
> > Will it be better?
> 
> That wouldn't change the binding in any way, so I don't see a reason to prefer
> one or the other (ioremap or clps711x_ioremap_one), especially since you
> explained that the registers already come with a static boot-time mapping.

What can you say about the removal "reg" property from the bindings and hard
define the physical address in the driver?

In any case, I'll make a second version of the patch, and since a lot of
comments, I will divide each functional part in the individual patches.
So I want to ask again, please apply "fixes" part of the series (1/10-4/10).
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
