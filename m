From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:40 +0100
Subject: [RFC 00/23] arm64: Add support for 64KB page granularity in Xen guest
Message-ID: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
hypercall interface and PV protocol are always based on 4KB page granularity.

Any attempt to boot a Linux guest with 64KB pages enabled will result to a
guest crash.

This series is a first attempt to allow those Linux running with the current
hypercall interface and PV protocol.

This solution has been chosen because we want to run Linux 64KB in released
Xen ARM version or/and platform using an old version of Linux DOM0.

There is room for improvement, such as support of 64KB grant, modification
of PV protocol to support different page size... They will be explored in a
separate patch series later.

TODO list:
    - Network not working well in the guest when using DOM0 64KB
    - swiotlb not yet converted to 64KB pages

Note that the first 9 patches of the series is a cleanup of the code.

A branch based on 4.1-rc3 can be found here:

git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v0

Comments, suggestions are welcomed.

Sincerely yours,

Cc: david.vrabel at citrix.com
Cc: konrad.wilk at oracle.com
Cc: boris.ostrovsky at oracle.com
Cc: wei.liu2 at citrix.com
Cc: roger.pau at citrix.com

Julien Grall (23):
  xen: Include xen/page.h rather than asm/xen/page.h
  xen/xenbus: client: Fix call of virt_to_mfn in xenbus_grant_ring
  xen/grant-table: Remove unused macro SPP
  block/xen-blkfront: Remove unused macro MAXIMUM_OUTSTANDING_BLOCK_REQS
  block/xen-blkfront: Remove invalid comment
  block/xen-blkback: s/nr_pages/nr_segs/
  net/xen-netfront: Correct printf format in xennet_get_responses
  net/xen-netback: Remove unused code in xenvif_rx_action
  arm/xen: Drop duplicate define mfn_to_virt
  xen/biomerge: WORKAROUND always says the biovec are not mergeable
  xen: Add Xen specific page definition
  xen: Extend page_to_mfn to take an offset in the page
  xen/xenbus: Use Xen page definition
  tty/hvc: xen: Use xen page definition
  xen/balloon: Don't rely on the page granularity is the same for Xen
    and Linux
  xen/events: fifo: Make it running on 64KB granularity
  xen/grant-table: Make it running on 64KB granularity
  block/xen-blkfront: Make it running on 64KB page granularity
  block/xen-blkback: Make it running on 64KB page granularity
  net/xen-netfront: Make it running on 64KB page granularity
  net/xen-netback: Make it running on 64KB page granularity
  xen/privcmd: Add support for Linux 64KB page granularity
  arm/xen: Add support for 64KB page granularity

 arch/arm/include/asm/xen/page.h     |  13 +-
 arch/arm/xen/enlighten.c            |   6 +-
 arch/arm/xen/mm.c                   |   2 +-
 arch/arm/xen/p2m.c                  |   8 +-
 drivers/block/xen-blkback/blkback.c |  15 +-
 drivers/block/xen-blkback/common.h  |  18 ++-
 drivers/block/xen-blkback/xenbus.c  |   6 +-
 drivers/block/xen-blkfront.c        | 267 +++++++++++++++++++++---------------
 drivers/net/xen-netback/common.h    |   7 +-
 drivers/net/xen-netback/netback.c   |  34 ++---
 drivers/net/xen-netfront.c          |  46 ++++---
 drivers/tty/hvc/hvc_xen.c           |   6 +-
 drivers/xen/balloon.c               |  93 ++++++++-----
 drivers/xen/biomerge.c              |   3 +
 drivers/xen/events/events_base.c    |   2 +-
 drivers/xen/events/events_fifo.c    |   4 +-
 drivers/xen/gntdev.c                |   2 +-
 drivers/xen/grant-table.c           |   7 +-
 drivers/xen/manage.c                |   2 +-
 drivers/xen/privcmd.c               |   8 +-
 drivers/xen/tmem.c                  |   2 +-
 drivers/xen/xenbus/xenbus_client.c  |   8 +-
 drivers/xen/xenbus/xenbus_probe.c   |   4 +-
 drivers/xen/xlate_mmu.c             |  31 +++--
 include/xen/page.h                  |  21 ++-
 25 files changed, 366 insertions(+), 249 deletions(-)

-- 
2.1.4
