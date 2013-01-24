From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 24 Jan 2013 10:28:51 +0900
Subject: [PATCH v3 0/3] introduce static_vm for ARM-specific static mapped area
Message-ID: <1358990934-4893-1-git-send-email-iamjoonsoo.kim@lge.com>
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
v2->v3:
  coverletter: refer a link related to this work
  [2/3]: drop @flags of find_static_vm_vaddr
  Rebased on v3.8-rc4

v1->v2: 
  [2/3]: patch description is improved.
  Rebased on v3.7-rc7

Joonsoo Kim (3):
  ARM: vmregion: remove vmregion code entirely
  ARM: static_vm: introduce an infrastructure for static mapped area
  ARM: mm: use static_vm for managing static mapped areas

 arch/arm/include/asm/mach/static_vm.h |   51 ++++++++
 arch/arm/mm/Makefile                  |    2 +-
 arch/arm/mm/ioremap.c                 |   69 ++++-------
 arch/arm/mm/mm.h                      |   10 --
 arch/arm/mm/mmu.c                     |   54 +++++----
 arch/arm/mm/static_vm.c               |   94 +++++++++++++++
 arch/arm/mm/vmregion.c                |  205 ---------------------------------
 arch/arm/mm/vmregion.h                |   31 -----
 8 files changed, 204 insertions(+), 312 deletions(-)
 create mode 100644 arch/arm/include/asm/mach/static_vm.h
 create mode 100644 arch/arm/mm/static_vm.c
 delete mode 100644 arch/arm/mm/vmregion.c
 delete mode 100644 arch/arm/mm/vmregion.h

-- 
1.7.9.5
