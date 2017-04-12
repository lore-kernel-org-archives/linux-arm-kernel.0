From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Apr 2017 12:20:22 +0100
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <1491917983.7236.9.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
Message-ID: <20170412112022.GY17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 11:39:43PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> > +static inline void __iomem *ioremap_nopost(phys_addr_t offset,
> > size_t size)
> > +{
> > +???????return ioremap_nocache(offset, size);
> > +}
> > +
> 
> No this is wrong as I explained.
> 
> This is a semantic that simply *cannot* be generically provided accross
> architectures as a mapping attribute.
> 
> The solution to your problem lies elsewhere.

I disagree.  Sure, it may not be supportable across all architectures,
but we're not introducing something brand new here.

What we're trying to do is to fix some _existing_ drivers that are
already using ioremap() to map the PCI IO and configuration spaces.
Maybe it would help if those drivers were part of this patch set,
rather than the patch set just introducing a whole new architecture
interface without really showing where the problem drivers are.

The issue here is that if we make this new ioremap_nopost() fail by
returning NULL if an architecture does not provide an implementation,
then these drivers are going to start failing on such architectures.

It is only safe to do that where we know for certain that the drivers
are not used - but I don't think that's the case here (it's difficult
to tell, because no drivers are updated in this series, so we don't
know which are going to be affected.)

So, the question is:

- is it better to provide a default implementation which provides the
  functionality that existing drivers are _already_ using, albiet not
  entirely correctly.

or:

- is it better to break drivers on architectures when they're converted
  to fix up this issue.

What, I suppose, we could do is not bother with a default implementation,
but instead litter drivers with:

+#ifdef ioremap_post
+	base = ioremap_post(...);
+#else
	base = ioremap(...);
+#endif

which gets around your objection - not providing a default that's weaker
than required, but also not breaking the drivers.  The problem is that
we end up littering drivers with ifdefs.

However, I'm willing to bet that the architectures that you're saying
will not be able to support the weaker semantic won't have any need to
use these drivers, or if they do, the drivers will need the method of
accessing stuff like PCI IO and configuration spaces radically altered.

So, maybe the best solution is to not provide any kind of default
implementation, add a HAVE_IOREMAP_POST Kconfig symbol, have architectures
select that when they do provide ioremap_post(), and make the drivers
depend on that (so we don't end up trying to build these drivers on
architectures where they can never work.)  Down side to that is reduced
build coverage.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
