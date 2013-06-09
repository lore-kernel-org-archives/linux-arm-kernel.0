From: ming.lei@canonical.com (Ming Lei)
Date: Sun,  9 Jun 2013 23:18:27 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
Message-ID: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patchset supports to run giveback of URB in tasklet context, so that
DMA unmapping/mapping on transfer buffer and compelte() callback can be
run with interrupt enabled, then time of HCD interrupt handler can be
saved much. Also this approach may simplify HCD since HCD lock needn't
be released any more before calling usb_hcd_giveback_urb().

The patchset enables the mechanism on EHCI HCD.

Patch 3/4 improves interrupt qh unlink on EHCI HCD when the mechanism
is introduced.

In the commit log of patch 4/4, detailed test result on three machines
(ARM A9/A15 dual core, X86) are provided about transfer performance and
ehci irq handling time. From the result, no transfer performance loss
is found and ehci irq handling time can drop much with the patchset.

 drivers/usb/core/hcd.c            |  170 +++++++++++++++++++++++++++++++------
 drivers/usb/host/ehci-fsl.c       |    2 +-
 drivers/usb/host/ehci-grlib.c     |    2 +-
 drivers/usb/host/ehci-hcd.c       |   18 ++--
 drivers/usb/host/ehci-hub.c       |    1 +
 drivers/usb/host/ehci-mv.c        |    2 +-
 drivers/usb/host/ehci-octeon.c    |    2 +-
 drivers/usb/host/ehci-pmcmsp.c    |    2 +-
 drivers/usb/host/ehci-ppc-of.c    |    2 +-
 drivers/usb/host/ehci-ps3.c       |    2 +-
 drivers/usb/host/ehci-q.c         |    6 +-
 drivers/usb/host/ehci-sched.c     |   60 ++++++++++++-
 drivers/usb/host/ehci-sead3.c     |    2 +-
 drivers/usb/host/ehci-sh.c        |    2 +-
 drivers/usb/host/ehci-tegra.c     |    2 +-
 drivers/usb/host/ehci-tilegx.c    |    2 +-
 drivers/usb/host/ehci-timer.c     |   43 ++++++++++
 drivers/usb/host/ehci-w90x900.c   |    2 +-
 drivers/usb/host/ehci-xilinx-of.c |    2 +-
 drivers/usb/host/ehci.h           |    3 +
 include/linux/usb/hcd.h           |   16 ++++
 21 files changed, 295 insertions(+), 48 deletions(-)


Thanks,
--
Ming Lei
