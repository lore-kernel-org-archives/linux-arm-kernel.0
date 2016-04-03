From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun,  3 Apr 2016 09:23:52 +0200
Subject: [PATCH 0/2] Embedding Position Independent Executables
Message-ID: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series tries to revive the many series trying to achieve the same thing.

I've tried numerous approaches and while using the kernel module loader is
actually quite convenient from a relocation point of view it is quite overkill
and also it is quite often too late as a lot of the arch specific PM code assume
that it is running at boot time, befor having access to any filesystem.

I've chosen to be less generic than what Russ did and only handle ARM. I reused
the API he defined but I actually went closer to his first implementation by
compiling and embedding a real PIE that doesn't actually need relocations (gcc
seems to be better at it thanks to ASLR).

In this series, I'm also converting the AT91 suspend code to use that
infrastructure as it is quite simple but I also toyed with more complex
functions.

The current limitation is that is doesn't actually tries to handle big endian
and I didn't test thumb (and this will probably require more work to get that
working reliably).

Also, to be more useful prppoer handling of a stack has to be added (this is not
too difficult and is planned) and will be enough to get rk3288 suspend/resume and
DDR timing changes working.

Alexandre Belloni (2):
  ARM: PIE infrastructure
  ARM: at91: pm: switch to the PIE infrastructure

 arch/arm/Kconfig                 |   2 +
 arch/arm/Makefile                |   1 +
 arch/arm/mach-at91/Kconfig       |   1 +
 arch/arm/mach-at91/Makefile      |   2 +-
 arch/arm/mach-at91/pm.c          |  31 ++--
 arch/arm/mach-at91/pm/.gitignore |   2 +
 arch/arm/mach-at91/pm/Makefile   |   3 +
 arch/arm/mach-at91/pm/atmel_pm.c |  97 +++++++++++
 arch/arm/mach-at91/pm_suspend.S  | 338 ---------------------------------------
 arch/arm/pie/Kconfig             |   8 +
 arch/arm/pie/Makefile            |   1 +
 arch/arm/pie/Makefile.pie        |  70 ++++++++
 arch/arm/pie/lib/empty.c         |  15 ++
 arch/arm/pie/pie.c               |  97 +++++++++++
 arch/arm/pie/pie.lds.S           |  40 +++++
 include/linux/pie.h              | 159 ++++++++++++++++++
 16 files changed, 507 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm/.gitignore
 create mode 100644 arch/arm/mach-at91/pm/Makefile
 create mode 100644 arch/arm/mach-at91/pm/atmel_pm.c
 delete mode 100644 arch/arm/mach-at91/pm_suspend.S
 create mode 100644 arch/arm/pie/Kconfig
 create mode 100644 arch/arm/pie/Makefile
 create mode 100644 arch/arm/pie/Makefile.pie
 create mode 100644 arch/arm/pie/lib/empty.c
 create mode 100644 arch/arm/pie/pie.c
 create mode 100644 arch/arm/pie/pie.lds.S
 create mode 100644 include/linux/pie.h

-- 
2.8.0.rc3
