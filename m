From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jan 2015 18:20:34 +0000
Subject: [PATCHv2 0/2] PCI_IOBASE fixes
Message-ID: <1421950836-19869-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown reported [1] build failures in the page table dump code, due
to lack of an explicit include for PCI_IOBASE.

While looking into that I spotted that the VA space allocated for PCI I/O
overlaps with the fixmap allocation, and that in a couple of places we assume
that the I/O space is 16MiB while the allocated VA space (and associated
IO_SPACE_LIMIT) cover 32MiB.

The first patch fixes the VA space allocation, preventing overlap, and
introduces common definitions for the I/O space layout, preventing futurre
issues if the I/O space layout is modified.

The second patch adds the missing explicit includes for the remaining
definitions used in the dump code, and has been updated from the
previous posting [2] to take the effects of patch 1 into account.

I've built and boot tested a v3.19-rc4 defconfig with these patches
applied.

Since v1 [3]:
* Restore I/O space to 16MiB, per Catalin's request.
* Add PCI_IO_SIZE along with comment to ensure the I/O space size is
  consistent through all uses.
* Reorder mem_init entries for consistency.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315228.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315326.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315443.html

Mark Rutland (2):
  arm64: Fix overlapping VA allocations
  arm64: mm: dump: add missing includes

 arch/arm64/include/asm/io.h     |  5 +++--
 arch/arm64/include/asm/memory.h | 10 +++++++++-
 arch/arm64/mm/dump.c            |  8 ++++++--
 arch/arm64/mm/init.c            |  5 +++--
 4 files changed, 21 insertions(+), 7 deletions(-)

-- 
1.9.1
