From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Oct 2013 17:17:54 -0400
Subject: [PATCH v3 0/6] ARM: mm: Extend the runtime patch stub for PAE systems
Message-ID: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of the series which addresses the comments/suggestions
we received on v2[1]. The v1 version link is here [2]

The series trying to extend the existing v2p runtime patching for
LPAE machines which can have physical memory beyond 4 GB. Keystone
is one such ARM machine.

64 bit patching support patch is significantly revised with the inputs
from Nicolas Pitre. The patch-set is tested in various modes like
LPAE/non-LPAE, ARM/THMUB. For the THUMB2 build, we found an issue
with devicemap_init() code sequence and the last patch in the series
tries to address that. I missed that patch to be included in the
last version.

Special thanks to Nicolas for his valuable feedback on the earlier
versions.

There was a point about dual patching and avoiding two steps but there
is no easy way at least we can think of apart from ripping out the
current patch code and directly operating on pv_offsets which is
already nacked while back. In either case, this will be an optimisation
and can be carried out as a next step.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Santosh Shilimkar (4):
  ARM: mm: use phys_addr_t appropriately in p2v and v2p conversions
  ARM: mm: Introduce virt_to_idmap() with an arch hook
  ARM: mm: Move the idmap print to appropriate place in the code
  ARM: mm: Recreate kernel mappings in early_paging_init()

Sricharan R (2):
  ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses
  ARM: mm: Change the order of TLB/cache maintenance operations.

 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/include/asm/memory.h    |   73 +++++++++++++++++++++++++++++----
 arch/arm/kernel/armksyms.c       |    1 +
 arch/arm/kernel/head.S           |   60 +++++++++++++++++----------
 arch/arm/kernel/patch.c          |    3 ++
 arch/arm/kernel/setup.c          |    3 ++
 arch/arm/kernel/smp.c            |    2 +-
 arch/arm/mm/idmap.c              |    8 ++--
 arch/arm/mm/mmu.c                |   84 +++++++++++++++++++++++++++++++++++++-
 9 files changed, 199 insertions(+), 36 deletions(-)

Regards,
Santosh

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/188108.html
[2] http://lwn.net/Articles/556175/ 
-- 
1.7.9.5
