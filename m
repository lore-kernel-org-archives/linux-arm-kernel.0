From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 22:10:49 +0000
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <201301092119.57067.arnd@arndb.de>
 <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
Message-ID: <201301092210.49452.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Thierry Reding wrote:
> What happens on Tegra is that we need to map 256 MiB of physical memory
> to access all the PCIe extended configuration space. However, ioremap()
> on such a large region fails if not enough vmalloc() space is available.
> 
> This was observed when somebody tested this on CardHu which has a 1 GiB
> of RAM and therefore remapping the full 256 MiB fails.

Hmm, config space accesses are fairly rare and generally not expected
to be fast, and 256 MB is really a huge waste of virtual address space,
so I agree that just ioremapping the entire space is not a good
solution.

However, it's not clear that a cache is necessary. Have you measured
a significant performance benefit of this implementation over just
iorempping and unmapping a single page for every config space access?
Have you checked if the hardware supports an alternative config
space access mechanism that does not depend on a huge address range?
A lot of them provide an index/data register pair somewhere, as the
original PC implementation did.

Even if we actually want a cache, how about a private implementation
that just remembers a single page in LRU? I doubt that there are
more drivers that would benefit from a generalized version that you
provide.

	Arnd
