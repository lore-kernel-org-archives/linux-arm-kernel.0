From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 13 Sep 2011 03:06:30 -0700
Subject: [PATCH 0/3] ARCH: CSR: basic PM suspend/resume support
Message-ID: <1315908393-362-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it was in thread "ARM: CSR: add rtciobrg and PM support" before. See:
http://www.spinics.net/lists/arm-kernel/msg137375.html

Arnd has pulled rtciobrg into arm-soc next branch. PM should be another
series.

This series has been tested on prima2 Linux 3.1-rc6 with log:

# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
C0PM: suspend of devices complete after 2.083 msecs
PM: late suspend of devices complete after 0.697 msecs
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x00040000, Cache size: 262144 B
PM: early resume of devices complete after 0.628 msecs
PM: resume of devices complete after 1.804 msecs
Restarting tasks ... done.

Due to L2 cache will lose power and data in suspend cycle, prima2 actually requires
the whole l2 cache flushed while suspending and re-initilized after resuming just
like code boot.
So the "ARM: CSR: PM: add sleep entry for SiRFprimaII" depends on:
Shawn Guo <shawn.guo@linaro.org>'s
[PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from initialization functions
http://www.spinics.net/lists/arm-kernel/msg139198.html

Barry Song (2):
  ARM: CSR: PM: save/restore timer status in suspend cycles
  ARM: CSR: PM: save/restore irq status in suspend cycles

Rongjun Ying (1):
  ARM: CSR: PM: add sleep entry for SiRFprimaII

 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/irq.c    |   40 +++++++++++
 arch/arm/mach-prima2/pm.c     |  150 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h     |   31 +++++++++
 arch/arm/mach-prima2/sleep.S  |   64 +++++++++++++++++
 arch/arm/mach-prima2/timer.c  |   34 +++++++++
 6 files changed, 320 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/sleep.S



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
