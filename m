From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 19:36:46 +0000
Subject: [PATCH 0/2] arm64: PCI_IOBASE fixes
Message-ID: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown reported build failures in the page table dump code, due to
lack of an explicit include for PCI_IOBASE.

While looking into that I spotted that the VA space allocated for PCI
I/O overlaps with the fixmap allocation, and that in a couple of places
we erroneously assume that the I/O space is 16MiB while the allocted VA
space (and associated IO_SPACE_LIMIT) cover 32MiB.

The first patch fixes the VA space allocation, preventing overlap and
removing erroneous assumptions about the I/O space size. I'm still not
that sure of my understanding of the fixmap code and the entries below
__end_of_permanent_fixed_addresses (which aren't accounted for in
mem_init or the page table dump code), but at least they now live at the
very bottom of the kernel mapping and can't potentially overlap with
anything.

The second patch adds the missing explicit includes for the remaining
definitions used in the dump code, and has been updated from the
previous posting [2] to take the effects of patch 1 into account.

I've built and boot tested a v3.19-rc4 defconfig with these patches applied.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315228.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315326.html

Mark Rutland (2):
  arm64: Fix overlapping VA allocations
  arm64: mm: dump: add missing includes

 arch/arm64/include/asm/io.h     | 5 +++--
 arch/arm64/include/asm/memory.h | 4 +++-
 arch/arm64/mm/dump.c            | 8 ++++++--
 arch/arm64/mm/init.c            | 3 ++-
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.9.1
