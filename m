From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Jul 2015 11:29:37 +0100
Subject: [PATCH] ARM: psci: boot_secondary: replace __pa with virt_to_idmap
In-Reply-To: <20150630202537.GI7557@n2100.arm.linux.org.uk>
References: <1435661062-4127-1-git-send-email-grygorii.strashko@ti.com>
 <20150630161836.GC28372@leverpostej>
 <20150630202537.GI7557@n2100.arm.linux.org.uk>
Message-ID: <20150702102937.GA13036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 09:25:37PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 30, 2015 at 05:18:37PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > On Tue, Jun 30, 2015 at 11:44:22AM +0100, Grygorii Strashko wrote:
> > > On some PAE systems (e.g. TI Keystone), memory is above the 32-bit
> > > addressable limit, and the interconnect provides an aliased view of
> > > parts of physical memory in the 32-bit addressable space. This alias
> > > is strictly for boot time usage, and is not otherwise usable because
> > > of coherency limitations.
> > > 
> > > On such systems, the idmap mechanism has to be used to pass correct
> > > boot address of secondary CPU to FW.
> > > virt_to_idmap() will fall-back to existing virt_to_phys() macro if
> > > such conversation is not required.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Nicolas Pitre <nico@linaro.org>
> > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > Cc: Vitaly Andrianov <vitalya@ti.com>
> > > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > > ---
> > >  arch/arm/kernel/psci_smp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > The code itself looks sane to me, though the commit message would be
> > better with Russell's suggested rewording.
> > 
> > This will also conflict with my migration to a common PSCI client
> > implementation [1,2] (especially given the absence of virt_to_idmap on
> > arm64), but I'm happy to fold it in or rebase atop of it.
> > 
> > Russell, are you able to take a look at the migration patch [2]? How
> > would you prefer for the two patches to be taken?
> 
> Well, the first thing that stands out about patch [2] is that it's
> introducing a load of magic hex numbers, where before we had a struct
> with nice definitions.  (I'm thinking about highbank_suspend_finish()
> and calxeda_idle_finish().)  This seems to be a backwards step.

The existing suspend parameter packing/unpacking didn't work now that
there are multiple possible formats for the suspend parameter from
PSCIv1.0 onwards, and the core PSCI code won't do any more
packing/unpacking, treating the suspend parameter as a mostly opaque
token.

I could retain the struct and packing functions for the two cases you
mention, but it seemed somewhat misleading. I'll see if I can figure out
something better than a raw hex value.

Other than that, were you happy with the arch/arm changes?

> There's two options on how to handle this.  Either accept the
> virt_to_idmap() change first, and then sort out the resulting difference,
> maybe by having ARM64 grow a virt_to_idmap() of its own (which is just
> a virt_to_phys()) or we do it the other way around.  Either way, we
> need a new macro, and the established name for it is virt_to_idmap().
> The order doesn't matter as the end result would be the same.

Ok. I guess it's easier to take Grygorii's patch first (with updated
commit message), and I'll fix the rest of my patches to cater for that.
I'll add that to the front of my series for the moment.

Thanks,
Mark.
