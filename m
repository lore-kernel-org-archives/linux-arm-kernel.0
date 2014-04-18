From: robherring2@gmail.com (Rob Herring)
Date: Fri, 18 Apr 2014 17:19:53 -0500
Subject: [PATCH v2 0/7] Generic serial earlycon
Message-ID: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This started out as an attempt to add arm64's earlyprintk support to ARM
in order to get an earlier, runtime setup console on multi-platform
kernels. The first issue was needing the fixmap support which
conveniently Mark Salter was working on and is mostly in place now. Like
many things on ARM and arm64 now, it then became where do I put the now
common, shared code. After digging more into various early console/printk
support, it turns out the 8250_early.c setup code was the best starting
point. 

This is tested on arm64 and ARM with pl011 and 8250. The ARM support
also requires fixmap and fixed mapping support which are not yet in place.
I have some patches in my tree to support fixmap, but they need some more
work. Fortunately, once fixmap is in place, it is just a Kconfig option
to enable earlycon support on ARM. A git tree is available here[1].

I'm also working on a follow on series which adds DT based earlycon
setup, but that is dependent on some FDT improvements to support FDT
based address translation.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git earlycon

Rob Herring (7):
  x86: move FIX_EARLYCON_MEM kconfig into x86
  tty/serial: add generic serial earlycon
  tty/serial: convert 8250 to generic earlycon
  tty/serial: pl011: add generic earlycon support
  tty/serial: add arm/arm64 semihosting earlycon
  arm64: enable FIX_EARLYCON_MEM kconfig
  arm64: remove arch specific earlyprintk

 Documentation/kernel-parameters.txt        |   9 ++
 arch/arm64/Kconfig                         |   3 +
 arch/arm64/Kconfig.debug                   |   9 --
 arch/arm64/kernel/Makefile                 |   1 -
 arch/arm64/kernel/early_printk.c           | 158 -----------------------------
 arch/x86/Kconfig                           |   3 +
 drivers/tty/serial/8250/8250_early.c       | 138 +++----------------------
 drivers/tty/serial/8250/Kconfig            |   6 +-
 drivers/tty/serial/Kconfig                 |  18 ++++
 drivers/tty/serial/Makefile                |   3 +
 drivers/tty/serial/amba-pl011.c            |  30 +++++-
 drivers/tty/serial/earlycon-arm-semihost.c |  61 +++++++++++
 drivers/tty/serial/earlycon.c              | 152 +++++++++++++++++++++++++++
 include/linux/serial_core.h                |  16 +++
 14 files changed, 310 insertions(+), 297 deletions(-)
 delete mode 100644 arch/arm64/kernel/early_printk.c
 create mode 100644 drivers/tty/serial/earlycon-arm-semihost.c
 create mode 100644 drivers/tty/serial/earlycon.c

-- 
1.9.1
