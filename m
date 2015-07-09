From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:12 +0100
Subject: [PATCH v2 00/20] xen/arm64: Add support for 64KB page
Message-ID: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
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

For this new version, new helpers have been added in order to split the Linux
page in multiple grant. This is requiring to produce some callback.

So far I've only done a quick network performance test using iperf. The
server is living in DOM0 and the client in the guest.

Average betwen 10 iperf :

DOM0	    Guest       Result

4KB-mod	    64KB        3.176 Gbits/sec
4KB-mod     4KB-mod     3.245 Gbits/sec
4KB-mod     4KB         3.258 Gbits/sec
4KB         4KB         3.292 Gbits/sec
4KB         4KB-mod     3.265 Gbits/sec
4KB         64KB        3.189 Gbits/sec

4KB-mod: Linux with the 64KB patch series
4KB: linux/master

The network performance is slightly worst with this series (-0.15%). I suspect,
this is because of using an indirection to setup the grant. This is necessary
in order to ensure that the grant will be correctly sized no matter of the
Linux page granularity. This could be used later in order to support bigger
grant.

TODO list:
    - swiotlb not yet converted to 64KB pages
    - it may be possible to move some common define between netback/netfront
    and blkfront/blkback in an header.

Note that the patches has only been build tested on x86. It may also be
possible that they are not compiling one by one. I will give a look for
the next version.

A branch based on the latest linux/master can be found here:

git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v2

Comments, suggestions are welcomed.

Sincerely yours,

Cc: david.vrabel at citrix.com
Cc: konrad.wilk at oracle.com
Cc: boris.ostrovsky at oracle.com
Cc: wei.liu2 at citrix.com
Cc: roger.pau at citrix.com

Julien Grall (20):
  xen: Add Xen specific page definition
  xen: Introduce a function to split a Linux page into Xen page
  xen/grant: Introduce helpers to split a page into grant
  xen/grant: Add helper gnttab_page_grant_foreign_access_ref
  block/xen-blkfront: Split blkif_queue_request in 2
  block/xen-blkfront: Store a page rather a pfn in the grant structure
  block/xen-blkfront: split get_grant in 2
  net/xen-netback: xenvif_gop_frag_copy: move GSO check out of the loop
  xen/biomerge: Don't allow biovec to be merge when Linux is not using
    4KB page
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

 arch/arm/include/asm/xen/page.h     |  12 +-
 arch/arm/xen/enlighten.c            |   6 +-
 arch/arm/xen/p2m.c                  |   6 +-
 arch/x86/include/asm/xen/page.h     |   2 +-
 drivers/block/xen-blkback/blkback.c |   5 +-
 drivers/block/xen-blkback/common.h  |  16 +-
 drivers/block/xen-blkback/xenbus.c  |   9 +-
 drivers/block/xen-blkfront.c        | 536 +++++++++++++++++++++++-------------
 drivers/net/xen-netback/common.h    |  15 +-
 drivers/net/xen-netback/netback.c   | 148 ++++++----
 drivers/net/xen-netfront.c          | 121 +++++---
 drivers/tty/hvc/hvc_xen.c           |   6 +-
 drivers/xen/balloon.c               | 147 +++++++---
 drivers/xen/biomerge.c              |   7 +
 drivers/xen/events/events_base.c    |   2 +-
 drivers/xen/events/events_fifo.c    |   2 +-
 drivers/xen/grant-table.c           |  32 ++-
 drivers/xen/privcmd.c               |   8 +-
 drivers/xen/xenbus/xenbus_client.c  |   6 +-
 drivers/xen/xenbus/xenbus_probe.c   |   4 +-
 drivers/xen/xlate_mmu.c             | 127 ++++++---
 include/xen/grant_table.h           |  50 ++++
 include/xen/page.h                  |  41 ++-
 23 files changed, 896 insertions(+), 412 deletions(-)

-- 
2.1.4
