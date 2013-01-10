From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 08:10:01 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <201301092210.49452.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <201301092119.57067.arnd@arndb.de>
 <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
 <201301092210.49452.arnd@arndb.de>
Message-ID: <20130110071001.GD15212@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 10:10:49PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Thierry Reding wrote:
> > What happens on Tegra is that we need to map 256 MiB of physical memory
> > to access all the PCIe extended configuration space. However, ioremap()
> > on such a large region fails if not enough vmalloc() space is available.
> > 
> > This was observed when somebody tested this on CardHu which has a 1 GiB
> > of RAM and therefore remapping the full 256 MiB fails.
> 
> Hmm, config space accesses are fairly rare and generally not expected
> to be fast, and 256 MB is really a huge waste of virtual address space,
> so I agree that just ioremapping the entire space is not a good
> solution.
> 
> However, it's not clear that a cache is necessary. Have you measured
> a significant performance benefit of this implementation over just
> iorempping and unmapping a single page for every config space access?

No, I had not actually implemented it that way because I figured I might
just as well implement something generic with the added benefit that
most remapping operations would be cached automatically since the PCI
enumeration algorithms usually access the configuration space of a
single device at a time, so it actually maps to the best case for an LRU
based cache approach.

> Even if we actually want a cache, how about a private implementation
> that just remembers a single page in LRU? I doubt that there are
> more drivers that would benefit from a generalized version that you
> provide.

I can move the code to the Tegra PCIe driver, but there's quite a bit of
code that isn't actually related to the PCI functionality and I'd really
like to avoid cluttering the driver with this implementation. Keeping it
in a more central location will certainly increase the code's visibility
and make it easier for other potential users to find.

Also I just noticed that I hadn't actually added a parameter to the
iomap_cache_create() function to specify the maximum number of pages, so
currently the code only uses a single page anyway. It should be trivial
to change. I guess performance was good enough with a single page that I
didn't have a reason to increase the maximum number of pages.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/8bcc062d/attachment.sig>
