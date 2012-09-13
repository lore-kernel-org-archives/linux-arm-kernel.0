From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 13 Sep 2012 08:01:33 -0700
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
Message-ID: <20120913150133.GA16238@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here comes the lucky v7:

- Per Alan Cox's suggestion added hangup method and removed a small
  leftover;
- Per Colin Cross' suggestion moved IRQ quiescing logic into
  poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
  result, clear_irq() callback dropped.

These patches can be found in the following repo (based on tty-next):

	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master

Old changelogs and rationale for these patches can be found here:

	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
	v6: http://lkml.org/lkml/2012/9/10/2

Thanks,

--
 arch/arm/Kconfig                    |  19 ++
 arch/arm/common/vic.c               |  28 ++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 +
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +-----------
 arch/arm/kernel/entry-header.S      | 170 +++++++++++++
 arch/arm/kernel/kgdb_fiq.c          |  99 ++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 +++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 +++
 drivers/tty/serial/Kconfig          |  19 ++
 drivers/tty/serial/Makefile         |   1 +
 drivers/tty/serial/amba-pl011.c     |  73 +++++-
 drivers/tty/serial/kgdb_nmi.c       | 396 +++++++++++++++++++++++++++++
 drivers/tty/serial/kgdboc.c         |   6 +
 drivers/tty/serial/serial_core.c    |  17 ++
 include/linux/kdb.h                 |  29 ++-
 include/linux/kgdb.h                |  33 +++
 include/linux/serial_core.h         |   1 +
 kernel/debug/debug_core.c           |  36 ++-
 kernel/debug/kdb/kdb_main.c         |  29 +++
 22 files changed, 1060 insertions(+), 193 deletions(-)
