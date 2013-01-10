From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 08:19:37 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130109231758.GA27065@obsidianresearch.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <201301092119.57067.arnd@arndb.de>
 <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
 <201301092210.49452.arnd@arndb.de> <50EDF95F.4070209@wwwdotorg.org>
 <20130109231758.GA27065@obsidianresearch.com>
Message-ID: <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 04:17:58PM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 09, 2013 at 04:12:31PM -0700, Stephen Warren wrote:
> > On 01/09/2013 03:10 PM, Arnd Bergmann wrote:
> > > On Wednesday 09 January 2013, Thierry Reding wrote:
> > >> What happens on Tegra is that we need to map 256 MiB of physical memory
> > >> to access all the PCIe extended configuration space. However, ioremap()
> > >> on such a large region fails if not enough vmalloc() space is available.
> > >>
> > >> This was observed when somebody tested this on CardHu which has a 1 GiB
> > >> of RAM and therefore remapping the full 256 MiB fails.
> > ...
> > > Have you checked if the hardware supports an alternative config
> > > space access mechanism that does not depend on a huge address range?
> > > A lot of them provide an index/data register pair somewhere, as the
> > > original PC implementation did.
> > 
> > That would be nice, but I've talked to the HW engineers, and there's no
> > indication that any alternative mechanism exists.
> 
> It seems to be convention that extended config space is often only
> accessible through mmio space, that was true on x86 last I checked
> too..
> 
> You could decrease the size of the mapping to only span the bus
> numbers that are configured for use via DT.

That won't work, unfortunately. The mapping is such that the bus number
is not encoded in the uppermost bits, the extended register number is.
So the only thing that we could do is decrease the size of the extended
register space for *all* devices.

> Are there any concerns about these config registers being accessed
> from a context where a new mapping can't be made? Interrupt? Machine
> Check? PCI-E Advanced Error Reporting?

I haven't checked but I would expect configuration space accesses to not
happen in interrupt context. Usually they are limited to enumeration and
driver probe.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/c8eabd3f/attachment-0001.sig>
