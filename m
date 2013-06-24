From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Jun 2013 17:42:01 +0800
Subject: [PATCH v2 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
Message-ID: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patchset supports to run giveback of URB in tasklet context, so that
DMA unmapping/mapping on transfer buffer and compelte() callback can be
run with interrupt enabled, then time of HCD interrupt handler(IRQs
disabled time) can be saved much. Also this approach may simplify HCD
since HCD lock needn't be released any more before calling
usb_hcd_giveback_urb().

The patchset enables the mechanism on EHCI HCD now.

In the commit log of patch 4/4, detailed test result on three machines
(ARM A9/A15 dual core, X86) are provided about transfer performance and
ehci irq handling time. From the result, no transfer performance loss
is found and ehci irq handling time drops much with the patchset.

V2:
	- 1/4: always run URB complete() of root-hub in tasklet
	- 1/4: store urb status in urb->unlinked
	- 1/4: don't allocate 'struct giveback_urb_bh' dynamically
	- 1/4: other minor changes
	- 2/4: descript changes simply
	- 3/4: don't use QH_STATE_UNLINK_WAIT to implement intr qh
	unlink wait
	- 3/4: cancel unlink wait change 
	- 4/4: merge HCD private lock changes
	- rebase on 3.10-rc7-next20130624

V1:
        - change percput tasklet into tasklet in HCD to avoid out of order
        of URB->complete() for same endpoint

        - disable local IRQs when calling complete() from tasklet to
        avoid deadlock which is caused by holding lock via spin_lock
        and the same lock might be acquired in hard irq context

        - document coming change about calling complete() with irq enabled
        so that we can start to clean up USB drivers which call spin_lock()
        in complete()

 Documentation/usb/URB.txt         |   21 +++--
 drivers/usb/core/hcd.c            |  169 ++++++++++++++++++++++++++++++-------
 drivers/usb/host/ehci-fsl.c       |    2 +-
 drivers/usb/host/ehci-grlib.c     |    2 +-
 drivers/usb/host/ehci-hcd.c       |    3 +-
 drivers/usb/host/ehci-hub.c       |    1 +
 drivers/usb/host/ehci-mem.c       |    1 +
 drivers/usb/host/ehci-mv.c        |    2 +-
 drivers/usb/host/ehci-octeon.c    |    2 +-
 drivers/usb/host/ehci-pmcmsp.c    |    2 +-
 drivers/usb/host/ehci-ppc-of.c    |    2 +-
 drivers/usb/host/ehci-ps3.c       |    2 +-
 drivers/usb/host/ehci-q.c         |    5 --
 drivers/usb/host/ehci-sched.c     |   62 +++++++++++++-
 drivers/usb/host/ehci-sead3.c     |    2 +-
 drivers/usb/host/ehci-sh.c        |    2 +-
 drivers/usb/host/ehci-tilegx.c    |    2 +-
 drivers/usb/host/ehci-timer.c     |   45 +++++++++-
 drivers/usb/host/ehci-w90x900.c   |    2 +-
 drivers/usb/host/ehci-xilinx-of.c |    2 +-
 drivers/usb/host/ehci.h           |    3 +
 include/linux/usb/hcd.h           |   17 ++++
 22 files changed, 287 insertions(+), 64 deletions(-)



Thanks,
--
Ming Lei
