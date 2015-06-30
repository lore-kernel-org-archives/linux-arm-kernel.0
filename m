From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Jun 2015 11:59:40 -0400 (EDT)
Subject: [PATCH] ARM: psci: boot_secondary: replace __pa with virt_to_idmap
In-Reply-To: <20150630150541.GH7557@n2100.arm.linux.org.uk>
References: <1435661062-4127-1-git-send-email-grygorii.strashko@ti.com>
 <20150630150541.GH7557@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1506301153230.2617@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Jun 2015, Russell King - ARM Linux wrote:

> On Tue, Jun 30, 2015 at 01:44:22PM +0300, Grygorii Strashko wrote:
> > On some PAE systems (e.g. TI Keystone), memory is above the 32-bit
> > addressable limit, and the interconnect provides an aliased view of
> > parts of physical memory in the 32-bit addressable space. This alias
> > is strictly for boot time usage, and is not otherwise usable because
> > of coherency limitations.
> > 
> > On such systems, the idmap mechanism has to be used to pass correct
> > boot address of secondary CPU to FW.
> > virt_to_idmap() will fall-back to existing virt_to_phys() macro if
> > such conversation is not required.
> 
> I think this could do with improvement so that those who aren't aware of
> the issue can understand better.  The idmap mechanism is always used for
> secondary booting anyway.
> 
> "In this case, virt_to_phys(secondary_startup) would return the
> physical address of the secondary CPU boot entry point, but on such
> systems, this would be above the 4GB limit.
> 
> A separate function, virt_to_idmap(), has been provided to return a
> usable physical address for functions in the identity mapping, and
> this must be used in preference to virt_to_phys() or __pa() to find
> the physical entry point for functions in the identity mapping range.
> 
> For other systems, virt_to_idmap() and virt_to_phys() return identical
> physical addresses."
> 
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Cc: Vitaly Andrianov <vitalya@ti.com>
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Code-wise, this looks correct to me - but as it's PSCI stuff, I'd like
> to see Nico ack it.

I cannot pretend to be the authority on PSCI stuff. 

But this looks correct to me as well, assuming the amended commit 
message.

Acked-by: Nicolas Pitre <nico@linaro.org>

> Thanks.
> 
> > ---
> >  arch/arm/kernel/psci_smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> > index 28a1db4..244aadd 100644
> > --- a/arch/arm/kernel/psci_smp.c
> > +++ b/arch/arm/kernel/psci_smp.c
> > @@ -51,7 +51,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  {
> >  	if (psci_ops.cpu_on)
> >  		return psci_ops.cpu_on(cpu_logical_map(cpu),
> > -				       __pa(secondary_startup));
> > +					virt_to_idmap(&secondary_startup));
> >  	return -ENODEV;
> >  }
> >  
> > -- 
> > 2.4.5
> > 
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> 
> 
