From: prasadjoshi124@gmail.com (Prasad Joshi)
Date: Mon, 14 Mar 2011 17:23:29 +0000
Subject: [RFC][PATCH v2 00/23] __vmalloc: Propagating GFP allocation flag
	inside __vmalloc().
Message-ID: <AANLkTi=HmaOLy5Md=tg24CKRc2Cfq7p75+mtX9oa0CEJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A filesystem might run into a problem while calling
__vmalloc(GFP_NOFS) inside a lock.

It is expected than __vmalloc when called with GFP_NOFS should not
callback the filesystem code even incase of the increased memory
pressure. But the problem is that even if we pass this flag, __vmalloc
itself allocates memory with GFP_KERNEL.

Using GFP_KERNEL allocations may go into the memory reclaim path and
try to free memory by calling file system evict_inode function. Which
might lead into deadlock.

For further details
http://marc.info/?l=linux-mm&m=128942194520631&w=4
https://bugzilla.kernel.org/show_bug.cgi?id=30702

The patch passes the gfp allocation flag all the way down to those
allocating functions.

 arch/alpha/include/asm/pgalloc.h         |   18 +++++++--
 arch/arm/include/asm/pgalloc.h           |   11 +++++-
 arch/avr32/include/asm/pgalloc.h         |    8 ++++-
 arch/cris/include/asm/pgalloc.h          |   10 ++++-
 arch/frv/include/asm/pgalloc.h           |    3 ++
 arch/frv/include/asm/pgtable.h           |    1 +
 arch/frv/mm/pgalloc.c                    |    9 ++++-
 arch/ia64/include/asm/pgalloc.h          |   24 +++++++++++--
 arch/m32r/include/asm/pgalloc.h          |   11 ++++--
 arch/m68k/include/asm/motorola_pgalloc.h |   20 +++++++++--
 arch/m68k/include/asm/sun3_pgalloc.h     |   14 ++++++--
 arch/m68k/mm/memory.c                    |    9 ++++-
 arch/microblaze/include/asm/pgalloc.h    |    3 ++
 arch/microblaze/mm/pgtable.c             |   13 +++++--
 arch/mips/include/asm/pgalloc.h          |   22 ++++++++----
 arch/mn10300/include/asm/pgalloc.h       |    2 +
 arch/mn10300/mm/pgtable.c                |   10 ++++-
 arch/parisc/include/asm/pgalloc.h        |   21 ++++++++---
 arch/powerpc/include/asm/pgalloc-32.h    |    2 +
 arch/powerpc/include/asm/pgalloc-64.h    |   27 +++++++++++---
 arch/powerpc/mm/pgtable_32.c             |   10 ++++-
 arch/s390/include/asm/pgalloc.h          |   30 +++++++++++++---
 arch/s390/mm/pgtable.c                   |   22 +++++++++---
 arch/score/include/asm/pgalloc.h         |   13 ++++---
 arch/sh/include/asm/pgalloc.h            |    8 ++++-
 arch/sh/mm/pgtable.c                     |    8 ++++-
 arch/sparc/include/asm/pgalloc_32.h      |    5 +++
 arch/sparc/include/asm/pgalloc_64.h      |   17 ++++++++-
 arch/tile/include/asm/pgalloc.h          |   13 ++++++-
 arch/tile/mm/pgtable.c                   |   10 ++++-
 arch/um/include/asm/pgalloc.h            |    1 +
 arch/um/kernel/mem.c                     |   21 ++++++++---
 arch/x86/include/asm/pgalloc.h           |   17 ++++++++-
 arch/x86/mm/pgtable.c                    |    8 ++++-
 arch/xtensa/include/asm/pgalloc.h        |    9 ++++-
 arch/xtensa/mm/pgtable.c                 |   11 +++++-
 include/asm-generic/4level-fixup.h       |    8 +++-
 include/asm-generic/pgtable-nopmd.h      |    3 +-
 include/asm-generic/pgtable-nopud.h      |    1 +
 include/linux/mm.h                       |   40 ++++++++++++++++-----
 mm/memory.c                              |   14 ++++---
 mm/vmalloc.c                             |   57 ++++++++++++++++++++----------
 42 files changed, 441 insertions(+), 123 deletions(-)
