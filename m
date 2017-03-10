From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Mar 2017 10:59:22 +0000
Subject: Managing shared buffers on VIVT cache systems
In-Reply-To: <CAE=AiOO4J1qGjZb5dqhniQ04aV+WBh4HU+TLsDbXgkrATB8iiw@mail.gmail.com>
References: <CAE=AiOO4J1qGjZb5dqhniQ04aV+WBh4HU+TLsDbXgkrATB8iiw@mail.gmail.com>
Message-ID: <20170310105922.GS21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 12:45:55AM -0500, Josh Beavers wrote:
> I am debugging a driver that shared buffers between the kernel and
> userspace.  These buffers are allocated by vmalloc_user() and mapped
> by arch_get_unmapped_area_topdown() in arch/arm.

... which means, as soon as you have two mappings of the same memory,
you have cache aliases.

> This driver works on other platforms, but on VIVT (Virtually Indexed
> Virtually Tagged) cache systems inconsistent data seems to be
> observed.  This is presumably due to cache aliasing (multiple virtual
> mappings of a single physical memory location).

Correct.

> Attempts at manually flushing the dcache and using a cache coloring
> approach both seem to have failed me.  In particular, I am interested
> in why arch/arm/mm/mmap.c has the comment "We unconditionally provide
> this function for all cases, however in the VIVT case, we optimize out
> the alignment rules."  Both arch_get_unmapped_area() and
> arch_get_unmapped_area_topdown() have aliasing code that is
> conditional on a VIPT cache existing, but not VIVT.

Cache colouring only works when you have colours.  VIVT caches are not
coloured.  To understand how this all works, look at the address
structure (the numbers here are just for illustration):

   31                        12 11                    0
  +----------------------------+-----------------------+
  |         page number        |      page offset      |
  +----------------------------+-----------------------+

For either a physical address or a virtual address, the page offset part
of the address are equivalent - the MMU maps a virtual page number to a
physical page number.

The address that a cache sees is made up of three basic parts:

   31                     15 14              5 4      0
  +-------------------------+-----------------+--------+
  |   Tag                   |  Index          | offset |
  +-------------------------+-----------------+--------+

Where the offset comes from is largely irrelevant for this discussion,
because it's the lower bits of the page offset.

The Index and Tag can be sourced from either the physical address or
the virtual address.  The index is sourced from bits 5 to 11,
corresponding to the page offset, and bits 12 to 14, corresponding to 
he LSBs of the page number.  The tag will be sourced from bits 31 to 15,
corresponding to the page number.

For a cache hit to occur the cache is looked up for a line matching the
tag in the specified index (an single index can contain multiple cache
lines, only one line has to match the tag for a hit to occur.)

In a VIPT system, the entire virtual index is sourced from the virtual
address, which means that it's made up of the virtual page number and
virtual page offset, whereas the tag is made up of the physical page
number.

The overlap bits between the virtual page number and index introduce
the cache colouring effect - if these bits are indentical for each and
every mapping of the same physical page, the index used to look up in
the cache will be the same, and so multiple different virtual mappings
of the same colour hit the same place in the cache.

With a VIVT system, both the tag and the index are sourced from the
virtual address.  This means that the tag is different for the various
virtual mappings of the same physical address, which means that it
has no knowledge of the translation, and so aliasing happens.

So, what this means is that in VIVT systems, if you have more than one
mapping of the same physical address, you immediately have cache aliasing
issues to deal with, and there are no software tricks to get around it.

There are essentially two options:
(a) flush the cache for _each_ virtual alias whenever you modify the
    data via one of those aliases.
(b) map the memory uncacheable, so that aliases do not happen in the
    first place.

Under Linux on ARM with VIVT caches, we do a mixture of both with the
page cache and multiple userspace mmap()s.  The page cache tends to
always have a kernel mapping which aliases with any userspace mapping.
Whenever the kernel writes to its mapping, it calls flush_dcache_page(),
which flushes the kernel mapping, and then calls into
__flush_dcache_aliases() to flush all the currently visible userspace
aliases.

When userspace sets up multiple mmap()s for the same _shared mapping_
memory in the same process address space, then the code in
make_coherent() triggers to make the mappings uncacheable, since
userspace is allowed to write to any alias and read the updated data
from any alias without issuing cache flushes.

Now for the bit you're not going to like: There is no support in Linux
for coherency between vmalloc() mappings and userspace mappings on VIVT
systems.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
