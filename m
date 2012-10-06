From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 6 Oct 2012 18:14:29 +0200
Subject: pm: add suspend_mem and suspend_standby support
Message-ID: <20121006161429.GD12462@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)

are available in the git repository at:


  git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem

for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:

  arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)

----------------------------------------------------------------
pm: add suspend_mem and suspend_standby support

Today when we go to suspend we can not knwon at drivers level if we go in
STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
suspend_standby.

If a bus or drivers does not need to care about this distinction we fallback to
suspend. This will allow to do not update the current bus or drivers.

This is needed as example by at91 OHCI, UDC and atmel serial

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (6):
      pm: add suspend_mem and suspend_standby support
      platform: pm: add suspend_mem and suspend_standby support
      tty: atmel_serial: switch pm ops
      usb: ohci-at91: switch pm ops
      usb: at91_ude: switch pm ops
      arm: at91: drop at91_suspend_entering_slow_clock

 arch/arm/mach-at91/include/mach/board.h |    3 ---
 arch/arm/mach-at91/pm.c                 |   24 ------------------------
 drivers/base/platform.c                 |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/main.c               |   12 ++++++++++++
 drivers/tty/serial/atmel_serial.c       |   52 +++++++++++++++++++++++++++-------------------------
 drivers/usb/gadget/at91_udc.c           |   34 +++++++++++++++++++++++-----------
 drivers/usb/host/ohci-at91.c            |   38 ++++++++++++++++++++++++--------------
 include/linux/platform_device.h         |    6 ++++++
 include/linux/pm.h                      |    9 +++++++++
 kernel/power/suspend.c                  |   16 ++++++++++++++--
 10 files changed, 155 insertions(+), 79 deletions(-)

Best Regards,
J.
