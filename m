From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 18 Jun 2013 23:03:46 +0800
Subject: [RFC PATCH v1 0/6] USB: HCD/EHCI: giveback of URB in tasklet context
Message-ID: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patchset supports to run giveback of URB in tasklet context, so that
DMA unmapping/mapping on transfer buffer and compelte() callback can be
run with interrupt enabled, then time of HCD interrupt handler(IRQs
disabled time) can be saved much. Also this approach may simplify HCD
since HCD lock needn't be released any more before calling
usb_hcd_giveback_urb().

But, some drivers may assume IRQs are disabled in complete(),
and they may use spin_lock() to hold lock, so deadlock might be caused
when the lock is acquired in hard interrupt context. So currently patch
2/6 disables IRQs when calling complete() in tasklet, and at the same time
we can start to clean up drivers by converting spin_lock() in complete()
to spin_lock_irqsave() if the deadlock situation may exist. After the
cleanup is completed, complete() in tasklet will be called with IRQs
enabled.

Patch 5/6 improves interrupt qh unlink on EHCI HCD when the mechanism
is introduced.

The patchset enables the mechanism on EHCI HCD.

In the commit log of patch 6/6, detailed test result on three machines
(ARM A9/A15 dual core, X86) are provided about transfer performance and
ehci irq handling time. From the result, no transfer performance loss
is found and ehci irq handling time drops much with the patchset.


V1:
	- change percput tasklet into tasklet in HCD to avoid out of order
	of URB->complete() for same endpoint

	- disable local IRQs when calling complete() from tasklet to
	avoid deadlock which is caused by holding lock via spin_lock
	and the same lock might be acquired in hard irq context

	- document coming change about calling complete() with irq enabled
	so that we can start to clean up USB drivers which call spin_lock()
	in complete()


 Documentation/usb/URB.txt         |   30 +++---
 drivers/usb/core/hcd.c            |  196 ++++++++++++++++++++++++++++++++-----
 drivers/usb/host/ehci-fsl.c       |    2 +-
 drivers/usb/host/ehci-grlib.c     |    2 +-
 drivers/usb/host/ehci-hcd.c       |   18 +++-
 drivers/usb/host/ehci-hub.c       |    1 +
 drivers/usb/host/ehci-mv.c        |    2 +-
 drivers/usb/host/ehci-octeon.c    |    2 +-
 drivers/usb/host/ehci-pmcmsp.c    |    2 +-
 drivers/usb/host/ehci-ppc-of.c    |    2 +-
 drivers/usb/host/ehci-ps3.c       |    2 +-
 drivers/usb/host/ehci-q.c         |    6 +-
 drivers/usb/host/ehci-sched.c     |   60 +++++++++++-
 drivers/usb/host/ehci-sead3.c     |    2 +-
 drivers/usb/host/ehci-sh.c        |    2 +-
 drivers/usb/host/ehci-tegra.c     |    2 +-
 drivers/usb/host/ehci-tilegx.c    |    2 +-
 drivers/usb/host/ehci-timer.c     |   43 ++++++++
 drivers/usb/host/ehci-w90x900.c   |    2 +-
 drivers/usb/host/ehci-xilinx-of.c |    2 +-
 drivers/usb/host/ehci.h           |    3 +
 include/linux/usb/hcd.h           |   17 ++++
 22 files changed, 341 insertions(+), 59 deletions(-)

Thanks,
--
Ming Lei
