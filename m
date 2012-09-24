From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 24 Sep 2012 14:26:50 -0700
Subject: [PATCH v9 0/11] KGDB/KDB FIQ (NMI) debugger
Message-ID: <20120924212648.GA27605@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here comes v9...

Greg, patches 1-7 have gotten all the needed acks from Alan and Jason, so
it would be awesome if you could apply them to your tty-next tree.

ARM patches still need Russell's acks, but these can wait, plus if the
core support hits v3.7, it would be much easier to handle the rest
(including the patches that add "kiosk mode" support for KDB).

Thanks!

In v9:

- KGDB patches got their Acked-by tags from Jason Wessel;
- A small 64 bit fixup for kgdb_nmi driver, thanks to Jason;
- Yet again rebased on the latest and greatest tty-next, just to make sure
  everything applies cleanly.

These patches can be found in the following repo (based on tty-next):

	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master

Old changelogs and rationale for these patches can be found here:

	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
	v6: http://lkml.org/lkml/2012/9/10/2
	v7: http://lkml.org/lkml/2012/9/13/367
	v8: http://lkml.org/lkml/2012/9/19/525

--
 arch/arm/Kconfig                    |  19 ++
 arch/arm/common/vic.c               |  28 ++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 +
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +-----------
 arch/arm/kernel/entry-header.S      | 170 ++++++++++++
 arch/arm/kernel/kgdb_fiq.c          | 124 +++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 +++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 +++
 drivers/tty/serial/Kconfig          |  19 ++
 drivers/tty/serial/Makefile         |   1 +
 drivers/tty/serial/amba-pl011.c     |  73 +++++-
 drivers/tty/serial/kgdb_nmi.c       | 402 +++++++++++++++++++++++++++++
 drivers/tty/serial/kgdboc.c         |   9 +
 drivers/tty/serial/serial_core.c    |  17 ++
 include/linux/kdb.h                 |  29 ++-
 include/linux/kgdb.h                |  13 +
 include/linux/serial_core.h         |   1 +
 kernel/debug/debug_core.c           |  14 +-
 kernel/debug/kdb/kdb_main.c         |  31 +++
 22 files changed, 1054 insertions(+), 193 deletions(-)
