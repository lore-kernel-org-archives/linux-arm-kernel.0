From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 31 Jan 2013 10:00:05 +0900
Subject: [PATCH v4 0/3] introduce static_vm for ARM-specific static mapped area
Message-ID: <1359594008-14688-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current implementation, we used ARM-specific flag, that is,
VM_ARM_STATIC_MAPPING, for distinguishing ARM specific static mapped area.
The purpose of static mapped area is to re-use static mapped area when
entire physical address range of the ioremap request can be covered
by this area.

This implementation causes needless overhead for some cases.
For example, assume that there is only one static mapped area and
vmlist has 300 areas. Every time we call ioremap, we check 300 areas for
deciding whether it is matched or not. Moreover, even if there is
no static mapped area and vmlist has 300 areas, every time we call
ioremap, we check 300 areas in now.

If we construct a extra list for static mapped area, we can eliminate
above mentioned overhead.
With a extra list, if there is one static mapped area,
we just check only one area and proceed next operation quickly.

In fact, it is not a critical problem, because ioremap is not frequently
used. But reducing overhead is better idea.

Another reason for doing this work is for removing vm_struct list management,
entirely. For more information, look at the following link.
http://lkml.org/lkml/2012/12/6/184

Changelog
v3->v4:
  [2/3]: Changes from Nicolas' suggestion
         - embed static_vm code in ioremap.c
         - simplify struct static_vm
         - remove init_static_vm, instead, add_static_vm_early() init static_vm
         Use generic list for list management of static_vm
         Convert spin_lock to rw_lock
         Modify static_vm's flags bits
  [3/3]: Rework according to [2/3] change
  Rebased on v3.8-rc5

v2->v3:
  coverletter: refer a link related to this work
  [2/3]: drop @flags of find_static_vm_vaddr
  Rebased on v3.8-rc4

v1->v2: 
  [2/3]: patch description is improved.
  Rebased on v3.7-rc7

Joonsoo Kim (3):
  ARM: vmregion: remove vmregion code entirely
  ARM: ioremap: introduce an infrastructure for static mapped area
  ARM: mm: use static_vm for managing static mapped areas

 arch/arm/mm/Makefile   |    2 +-
 arch/arm/mm/ioremap.c  |  147 +++++++++++++++++++++++-----------
 arch/arm/mm/mm.h       |   28 ++++---
 arch/arm/mm/mmu.c      |   47 ++++++-----
 arch/arm/mm/vmregion.c |  205 ------------------------------------------------
 arch/arm/mm/vmregion.h |   31 --------
 6 files changed, 147 insertions(+), 313 deletions(-)
 delete mode 100644 arch/arm/mm/vmregion.c
 delete mode 100644 arch/arm/mm/vmregion.h

-- 
1.7.9.5
