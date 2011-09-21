From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 23:17:44 +0800
Subject: [PATCH v2 0/3] ARCH: CSR: basic PM suspend/resume support
Message-ID: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-v2:
add acked-by Arnd in changelog;
add necessary changelog for every patch;
don't call l2x0_of_init after resuming as Shawn's patch[1] seems
not to be applied;
since people still need some time to figure out the best way for l2
resume, we move the l2 re-init to bootloader for the moment to keep
things go ahead.

-v1:
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
So the "ARM: CSR: PM: add sleep entry for SiRFprimaII" depends on [1]:

[1] Shawn Guo <shawn.guo@linaro.org>'s
[PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from initialization functions
http://www.spinics.net/lists/arm-kernel/msg139198.html

Barry Song (2):
  ARM: CSR: PM: save/restore timer status in suspend cycle
  ARM: CSR: PM: save/restore irq status in suspend cycle

Rongjun Ying (1):
  ARM: CSR: PM: add sleep entry for SiRFprimaII

 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/irq.c    |   40 +++++++++++
 arch/arm/mach-prima2/pm.c     |  149 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h     |   31 +++++++++
 arch/arm/mach-prima2/sleep.S  |   64 ++++++++++++++++++
 arch/arm/mach-prima2/timer.c  |   34 +++++++++
 6 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/sleep.S
