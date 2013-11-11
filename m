From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 11 Nov 2013 15:26:48 -0800
Subject: [RFC 0/4] Intermix Lowmem and vmalloc
Message-ID: <1384212412-21236-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an RFC for a feature to allow lowmem and vmalloc virtual address space
to be intermixed. This has currently only been tested on a narrow set of ARM
chips.

Currently on 32-bit systems we have


                  Virtual                             Physical

   PAGE_OFFSET   +--------------+     PHYS_OFFSET   +------------+
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 | lowmem       |                   |  direct    |
                 |              |                   |   mapped   |
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 +--------------+------------------>x------------>
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |  not-direct|
                 |              |                   | mapped     |
                 | vmalloc      |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 +--------------+                   +------------+

Where part of the virtual spaced above PHYS_OFFSET is reserved for direct
mapped lowmem and part of the virtual address space is reserved for vmalloc.

Obviously, we want to optimize for having as much direct mapped memory as
possible since there is a penalty for mapping/unmapping highmem. Unfortunately
system constraints often give memory layouts such as

                  Virtual                             Physical

   PAGE_OFFSET   +--------------+     PHYS_OFFSET   +------------+
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |xxxxxxxxxxxx|
                 | lowmem       |                   |xxxxxxxxxxxx|
                 |              |                   |xxxxxxxxxxxx|
                 |              |                   |xxxxxxxxxxxx|
                 |              |                   |            |
                 |              |                   |            |
                 +--------------+------------------>x------------>
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |  not-direct|
                 |              |                   | mapped     |
                 | vmalloc      |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 +--------------+                   +------------+

                 (x = Linux cannot touch this memory)

where part of physical region that would be direct mapped as lowmem is not
actually in use by Linux.

This means that even though the system is not actually accessing the memory
we are still losing that portion of the direct mapped lowmem space. What this
series does is treat the virtual address space that would have been taken up
by the lowmem memory as vmalloc space and allows more lowmem to be mapped



                  Virtual                             Physical

   PAGE_OFFSET   +--------------+     PHYS_OFFSET   +------------+
                 |              |                   |            |
                 | lowmem       |                   |            |
                 <----------------------------------+xxxxxxxxxxxx|
                 |              |                   |xxxxxxxxxxxx|
                 | vmalloc      |                   |xxxxxxxxxxxx|
                 <----------------------------------+xxxxxxxxxxxx|
                 |              |                   |            |
                 | lowmem       |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 |              |                   |            |
                 +----------------------------------------------->
                 | vmalloc      |                   |            |
                 |              |                   |  not-direct|
                 |              |                   | mapped     |
                 |              |                   |            |
                 +--------------+                   +------------+

The goal here is to allow as much lowmem to be mapped as if the block of memory
was not reserved from the physical lowmem region. Previously, we had been
hacking up the direct virt <-> phys translation to ignore a large region of
memory. This did not scale for multiple holes of memory however.

Open issues:
	- vmalloc=<size> will account for all vmalloc now. This may have the
	side effect of shrinking 'traditional' vmalloc too much for regular
	static mappings. We were debating if this is just part of finding the
	correct size for vmalloc or if there is a need for vmalloc_upper=
	- People who like bike shedding more than I do can suggest better
	config names if there is sufficient interest in the series.

Comments or suggestions on other ways to accomplish the same thing are welcome.

 arch/arm/Kconfig                |    3 +
 arch/arm/include/asm/mach/map.h |    2 +
 arch/arm/mm/dma-mapping.c       |    2 +-
 arch/arm/mm/init.c              |  104 +++++++++++++++++++++++++++------------
 arch/arm/mm/ioremap.c           |    5 +-
 arch/arm/mm/mm.h                |    3 +-
 arch/arm/mm/mmu.c               |   40 ++++++++++++++-
 include/linux/mm.h              |    6 ++
 include/linux/vmalloc.h         |    1 +
 mm/Kconfig                      |   11 ++++
 mm/vmalloc.c                    |   37 ++++++++++++++
 11 files changed, 175 insertions(+), 39 deletions(-)

Thanks,
Laura
