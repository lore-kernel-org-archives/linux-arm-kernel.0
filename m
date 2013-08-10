From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 11:27:17 -0300
Subject: [PATCH v2 0/2] Kirkwood suspend to RAM
Message-ID: <1376144839-1985-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements a very basic suspend/resume support on
Kirkwood SoC's, based on the work of Simon Guinot.

Given the CPU itself is not stopped on suspend, but just sits
waiting for interruption, this is more similar to a standby-mode,
than to a real suspend-to-RAM.

The first patch implements suspend/resume procedures in Feroceon CPU.
This implementation has been copy-pasted from the one in ARM926, since
I failed to spot any relevant differences between the CPU's.

The only change from the previous RFC/PATCH version is the removal
of clock gating. Each device driver is in charge of such clock handling.

In other words, this patchset only implements the most basic support for
suspend/resume, any additional power savings must be added to each driver
by implementing proper suspend/resume support.

Given the amount of changes queued for Kirkwood, I've based this patchset
on mevbu's for-next (git://git.infradead.org/linux-mvebu.git for-next)

Tested on Openblocks A6.

Changes from v1:

  * Removed clock gating. Each peripheral is in charge of implementing
    a proper suspend/resume path, including gateable clock handling.

Ezequiel Garcia (2):
  ARM: feroceon: Add suspend/resume operation
  ARM: kirkwood: Add basic suspend-to-RAM support

 arch/arm/Kconfig                                  |  2 +-
 arch/arm/mach-kirkwood/Makefile                   |  1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
 arch/arm/mach-kirkwood/pm.c                       | 69 +++++++++++++++++++++++
 arch/arm/mm/proc-feroceon.S                       | 26 +++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-kirkwood/pm.c

-- 
1.8.1.5
