From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 12:49:05 -0300
Subject: [PATCH v3 0/2] Kirkwood standby
Message-ID: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements a very basic suspend/resume support on
Kirkwood SoC's, based on the work of Simon Guinot.

Given the CPU itself is not stopped on suspend, but just sits
waiting for interruption, this is more similar to a standby-mode,
than to a real suspend-to-RAM. Therefore, I've chosen to use the
'standby' power state.

The first patch implements suspend/resume procedures in Feroceon CPU
and it's already applied in Russell's. I'm only adding it here for
series consistency.

The second patch implements the 'standby' state by disabling SoC
memory units and put the CPU in idle state. Additional power savings
must be enhanced on each driver by implementing proper suspend/resume support.

This is based in v3.11-rc6 and tested on Openblocks A6.

By simple instrumentation I found (see the table below) that this 'standby'
state has *no power savings* compared to a CPUIdle-enabled platform.
Therefore, it's not clear to me the real advantage of this support.

However, and hopefully, by implementing proper suspend/resume in relevant
peripherals, the power savings of the standby might get improved.

CONFIG_CPU_IDLE=y
State             Current (mA)
------------------------------
Normal (system idle)   360
Normal (system busy    440
Standby                360

!CONFIG_CPU_IDLE
State             Current (mA)
------------------------------
Normal (system idle)   440
Normal (system busy    440
Standby                360

(The above are sketchy measurements but useful to compare CPUIdle vs. Standby)

Changes from v2:

  * In order to remain multiplatform-ready, I reworked the kirkwood_pm_init
    by having it explicitly called from mach-kirkwood/. Requested by
    Andrew Lunn.

Changes from v1:

  * Removed clock gating. Each peripheral is in charge of implementing
    a proper suspend/resume path, including gateable clock handling.

Ezequiel Garcia (2):
  ARM: feroceon: Add suspend/resume operation
  ARM: kirkwood: Add standby support

 arch/arm/Kconfig                                  |  2 +-
 arch/arm/mach-kirkwood/Makefile                   |  2 +
 arch/arm/mach-kirkwood/board-dt.c                 |  1 +
 arch/arm/mach-kirkwood/common.c                   |  1 +
 arch/arm/mach-kirkwood/common.h                   |  6 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
 arch/arm/mach-kirkwood/pm.c                       | 73 +++++++++++++++++++++++
 arch/arm/mm/proc-feroceon.S                       | 26 ++++++++
 8 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-kirkwood/pm.c

-- 
1.8.1.5
