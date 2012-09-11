From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Tue, 11 Sep 2012 02:30:43 -0700
Subject: [PATCH v6 0/12] KGDB/KDB FIQ (NMI) debugger
Message-ID: <20120911093042.GA12471@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is a new revision, mostly tty reworks. The new tty_port stuff is a
bliss: no more per-driver mutex, no more counting for open(),
well-separated initialization callbacks (I hope I got them right :-).

But since I now use a lot of new tty_port stuff, I had to rebase the
patch set on top of tty-next, so there's no point in cherry-picking
anymore.

So, in v6:

- Converted the NMI tty driver to use tty_port helpers, per Alan Cox's
  suggestions;

- In uart's poll_init callback fixed a race, spotted by Alan;

- Use test_bit instead of touching port->flags directly;

These patches can be found in the following repo (based on tty-next):

	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master

Old changelogs and rationale for these patches can be found here:

	v1-v5: http://lkml.org/lkml/2012/9/10/2

Thanks,

--
 arch/arm/Kconfig                    |  19 ++
 arch/arm/common/vic.c               |  28 +++
 arch/arm/include/asm/hardware/vic.h |   2 +
 arch/arm/include/asm/kgdb.h         |   8 +
 arch/arm/kernel/Makefile            |   1 +
 arch/arm/kernel/entry-armv.S        | 167 +------------
 arch/arm/kernel/entry-header.S      | 170 +++++++++++++
 arch/arm/kernel/kgdb_fiq.c          |  99 ++++++++
 arch/arm/kernel/kgdb_fiq_entry.S    |  87 +++++++
 arch/arm/mach-versatile/Makefile    |   1 +
 arch/arm/mach-versatile/kgdb_fiq.c  |  31 +++
 drivers/tty/serial/Kconfig          |  19 ++
 drivers/tty/serial/Makefile         |   1 +
 drivers/tty/serial/amba-pl011.c     |  66 ++++-
 drivers/tty/serial/kgdb_nmi.c       | 391 ++++++++++++++++++++++++++++++
 drivers/tty/serial/kgdboc.c         |  16 ++
 drivers/tty/serial/serial_core.c    |  32 +++
 include/linux/kdb.h                 |  29 ++-
 include/linux/kgdb.h                |  34 +++
 include/linux/serial_core.h         |   2 +
 include/linux/tty_driver.h          |   1 +
 kernel/debug/debug_core.c           |  36 ++-
 kernel/debug/kdb/kdb_main.c         |  29 +++
 23 files changed, 1076 insertions(+), 193 deletions(-)
