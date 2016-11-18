From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Nov 2016 14:32:30 +0100
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <20161118124805.GJ1041@n2100.armlinux.org.uk>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <9481995.AMBiYg893F@wuerfel> <20161118124805.GJ1041@n2100.armlinux.org.uk>
Message-ID: <2339821.zs8sl71mMv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 12:48:07 PM CET Russell King - ARM Linux wrote:
> On Fri, Nov 18, 2016 at 01:14:35PM +0100, Arnd Bergmann wrote:
> > @@ -41,6 +43,9 @@ void scu_enable(void __iomem *scu_base)
> >  {
> >       u32 scu_ctrl;
> >  
> > +     if (scu_base)
> > +             scu_base = scu_base_addr;
> > +
> 
> This looks to me like nonsense.
> 
> >  #ifdef CONFIG_ARM_ERRATA_764369
> >       /* Cortex-A9 only */
> >       if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
> > @@ -85,6 +90,9 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> >       unsigned int val;
> >       int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
> >  
> > +     if (scu_base)
> > +             scu_base = scu_base_addr;
> > +
> 
> Ditto.
> 
> Rather than doing this, I'd much prefer to always store the SCU base in
> the SCU code, and remove the "void __iomem *scu_base" argment from all
> these functions.

Ok, then we just need one scu_probe_*() variant for each of the
four methods of initializing it (iotable, of_iomap,
ioremap(scu_a9_get_base) and hardcoded.

The intention of doing the fallback for the NULL argument was
to avoid having to add lots of new API while also allowing
the change to be done one platform at a time.

If we remove the argument from the other functions, they either
need to get a new name, or we change them all to the new prototype
at once. Either way works fine, do you have a preference between
them?

	Arnd
