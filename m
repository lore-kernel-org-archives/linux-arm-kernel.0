From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 23 Nov 2017 17:02:58 +0100
Subject: [PATCH v2 0/5] Memory hotplug support for arm64 - complete
 patchset v2
In-Reply-To: <cover.1511433386.git.ar@linux.vnet.ibm.com>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
Message-ID: <20171123160258.xmw5lxnjfch2dxfw@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 23-11-17 11:13:35, Andrea Reale wrote:
> Hi all,

Hi,

> 
> this is a second round of patches to introduce memory hotplug and
> hotremove support for arm64. It builds on the work previously published at
> [1] and it implements the feedback received in the first round of reviews.
> 
> The patchset applies and has been tested on commit bebc6082da0a ("Linux
> 4.14"). 
> 
> Due to a small regression introduced with commit 8135d8926c08
> ("mm: memory_hotplug: memory hotremove supports thp migration"), you
> will need to appy patch [2] first, until the fix is not upstreamed.
> 
> Comments and feedback are gold.
> 
> [1] https://lkml.org/lkml/2017/4/11/536
> [2] https://lkml.org/lkml/2017/11/20/902

I will try to have a look but I do not expect to understand any of arm64
specific changes so I will focus on the generic code but it would help a
_lot_ if the cover letter provided some overview of what has been done
from a higher level POV. What are the arch pieces and what is the
generic code missing. A quick glance over patches suggests that
changelogs for specific patches are modest as well. Could you give us
more information please? Reviewing hundreds lines of code without
context is a pain.
 
> Changes v1->v2:
> - swapper pgtable updated in place on hot add, avoiding unnecessary copy
> - stop_machine used to updated swapper on hot add, avoiding races
> - introduced check on offlining state before hot remove
> - new memblock flag used to mark partially unused vmemmap pages, avoiding
>   the nasty 0xFD hack used in the prev rev (and in x86 hot remove code)
> - proper cleaning sequence for p[um]ds,ptes and related TLB management
> - Removed macros that changed hot remove behavior based on number
>   of pgtable levels. Now this is hidden in the pgtable traversal macros.
> - Check on the corner case where P[UM]Ds would have to be split during
>   hot remove: now this is forbidden.
> - Minor fixes and refactoring.
> 
> Andrea Reale (4):
>   mm: memory_hotplug: Remove assumption on memory state before hotremove
>   mm: memory_hotplug: memblock to track partially removed vmemmap mem
>   mm: memory_hotplug: Add memory hotremove probe device
>   mm: memory-hotplug: Add memory hot remove support for arm64
> 
> Maciej Bielski (1):
>   mm: memory_hotplug: Memory hotplug (add) support for arm64
> 
>  arch/arm64/Kconfig             |  15 +
>  arch/arm64/configs/defconfig   |   2 +
>  arch/arm64/include/asm/mmu.h   |   7 +
>  arch/arm64/mm/init.c           | 116 ++++++++
>  arch/arm64/mm/mmu.c            | 609 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/acpi_memhotplug.c |   2 +-
>  drivers/base/memory.c          |  34 ++-
>  include/linux/memblock.h       |  12 +
>  include/linux/memory_hotplug.h |   9 +-
>  mm/memblock.c                  |  32 +++
>  mm/memory_hotplug.c            |  13 +-
>  11 files changed, 835 insertions(+), 16 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
