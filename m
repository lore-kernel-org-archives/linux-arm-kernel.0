From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 2 May 2010 23:36:00 +0400
Subject: [PATCH v4 0/3] Support for Cavium Networks CNS3xxx machines
Message-ID: <20100502193600.GA19119@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, May 01, 2010 at 10:20:48AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 29, 2010 at 09:58:42PM +0400, Anton Vorontsov wrote:
[...]
> > Not exactly related to these network issues, but I actually
> > postponed the question until you back: will there be another
> > mach-types update (in the devel branch) before .34 release?
> 
> Yes.

Great, thanks!

I see the update in the master branch, so I'm resending the CNS3xxx
patchset, v4 this time (full change log is at the very bottom).

These patches also available in the CNS3xxx GIT tree, on top of your
current 'master' branch. Please pull if the patches look OK to you.

(Note, if you try to pull it into your 'devel' branch, you'll see a
trivial conflict in arch/arm/Kconfig, but it isn't caused by any of
my commits in there, the same conflict will pop up if you merge
your master branch into devel.)

The formal pull request:

The following changes since commit ea5ce655b90f5debb7b9768284eaafcca218ddef:
  Andrew Morton (1):
        arch/arm/include/asm/elf.h: forward-declare the task-struct

are available in the git repository at:

  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (3):
      ARM: cns3xxx: Add basic support for Cavium Networks CNS3xxx processors
      ARM: cns3xxx: Add CNS3420 Validation Board support
      ARM: cns3xxx: Add defconfig for CNS3420 validation board

 MAINTAINERS                                      |    6 +
 arch/arm/Kconfig                                 |   11 +
 arch/arm/Makefile                                |    1 +
 arch/arm/configs/cns3420vb_defconfig             |  831 ++++++++++++++++++++++
 arch/arm/mach-cns3xxx/Kconfig                    |   12 +
 arch/arm/mach-cns3xxx/Makefile                   |    2 +
 arch/arm/mach-cns3xxx/Makefile.boot              |    3 +
 arch/arm/mach-cns3xxx/cns3420vb.c                |  148 ++++
 arch/arm/mach-cns3xxx/core.c                     |  249 +++++++
 arch/arm/mach-cns3xxx/core.h                     |   23 +
 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h     |  635 +++++++++++++++++
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S |   21 +
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S |   82 +++
 arch/arm/mach-cns3xxx/include/mach/hardware.h    |   22 +
 arch/arm/mach-cns3xxx/include/mach/io.h          |   17 +
 arch/arm/mach-cns3xxx/include/mach/irqs.h        |   24 +
 arch/arm/mach-cns3xxx/include/mach/memory.h      |   26 +
 arch/arm/mach-cns3xxx/include/mach/system.h      |   29 +
 arch/arm/mach-cns3xxx/include/mach/timex.h       |   12 +
 arch/arm/mach-cns3xxx/include/mach/uncompress.h  |   55 ++
 arch/arm/mach-cns3xxx/include/mach/vmalloc.h     |   11 +
 arch/arm/mach-cns3xxx/pm.c                       |   86 +++
 22 files changed, 2306 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/cns3420vb_defconfig
 create mode 100644 arch/arm/mach-cns3xxx/Kconfig
 create mode 100644 arch/arm/mach-cns3xxx/Makefile
 create mode 100644 arch/arm/mach-cns3xxx/Makefile.boot
 create mode 100644 arch/arm/mach-cns3xxx/cns3420vb.c
 create mode 100644 arch/arm/mach-cns3xxx/core.c
 create mode 100644 arch/arm/mach-cns3xxx/core.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/cns3xxx.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/io.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/memory.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/system.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-cns3xxx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-cns3xxx/pm.c

- - - -

Changes since v3:

- Removed static inline __io function from mach/io.h, this was a
  leftover. Noticed by Russell King.

Changes since v2:

- We noticed that timer2 (which was used as a clock source) causes
  nanosleep system call to misbehave. Until debugged, the timer2
  support is removed.

  It's fine since timer1 is still used as a clockevent, and provides
  all needed timekeeping functionality. With these patches we want
  a minimal (but rock solid) CNS3xxx support, all non-essential
  features can wait.

  I.e. support for the second timer can be added as a separate
  patch.

- Updated some PCIe register definitions to make PCIe integration
  more smooth.

- Updated defconfig.

Changes since v1:

- Addressed Russell's comments;
- CNS3420VB board support split into its own patch per Sergei's
  comment;
- This series no longer include AHCI and SDHCI patches. Because of
  dependencies on other trees they aren't yet suitable for inclusion,
  so no need to repost them again.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
