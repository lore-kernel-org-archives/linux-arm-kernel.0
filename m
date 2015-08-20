From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 19 Aug 2015 17:40:18 -0700
Subject: [Xen-devel] [PATCH v3 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55D521F2.5080504@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ping? I'm missing some reviews on block and netfront code.

We'd like to see this series going in Linux 4.3. Some distributions 
plans to use this version for aarch64 support. If we miss it, we won't 
have any Xen guests support, even it's minimal, for Linux using 64KB 
page granularity.

Regards,

On 07/08/2015 09:46, Julien Grall wrote:
> Hi all,
>
> ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
> hypercall interface and PV protocol are always based on 4KB page granularity.
>
> Any attempt to boot a Linux guest with 64KB pages enabled will result to a
> guest crash.
>
> This series is a first attempt to allow those Linux running with the current
> hypercall interface and PV protocol.
>
> This solution has been chosen because we want to run Linux 64KB in released
> Xen ARM version or/and platform using an old version of Linux DOM0.
>
> There is room for improvement, such as support of 64KB grant, modification
> of PV protocol to support different page size... They will be explored in a
> separate patch series later.
>
> TODO list:
>      - Convert swiotlb to 64KB
>      - Convert xenfb to 64KB
>      - Check if backend in QEMU works with DOM0 64KB
>      - It may be possible to move some common define between
>      netback/netfront and blkfront/blkback in an header
>
> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
> to run it on x86 as I don't have a box with Xen x86 running. I would be
> happy if someone give a try and see possible regression for x86.
>
> A branch based on the latest linux/master can be found here:
>
> git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v3
>
> Comments, suggestions are welcomed.
>
> Sincerely yours,
>
> Cc: david.vrabel at citrix.com
> Cc: konrad.wilk at oracle.com
> Cc: boris.ostrovsky at oracle.com
> Cc: wei.liu2 at citrix.com
> Cc: roger.pau at citrix.com
>
> Julien Grall (20):
>    net/xen-netback: xenvif_gop_frag_copy: move GSO check out of the loop
>    arm/xen: Drop pte_mfn and mfn_pte
>    xen: Add Xen specific page definition
>    xen/grant: Introduce helpers to split a page into grant
>    xen/grant: Add helper gnttab_page_grant_foreign_access_ref_one
>    block/xen-blkfront: Split blkif_queue_request in 2
>    block/xen-blkfront: Store a page rather a pfn in the grant structure
>    block/xen-blkfront: split get_grant in 2
>    xen/biomerge: Don't allow biovec to be merge when Linux is not using
>      4KB page
>    xen/xenbus: Use Xen page definition
>    tty/hvc: xen: Use xen page definition
>    xen/balloon: Don't rely on the page granularity is the same for Xen
>      and Linux
>    xen/events: fifo: Make it running on 64KB granularity
>    xen/grant-table: Make it running on 64KB granularity
>    block/xen-blkfront: Make it running on 64KB page granularity
>    block/xen-blkback: Make it running on 64KB page granularity
>    net/xen-netfront: Make it running on 64KB page granularity
>    net/xen-netback: Make it running on 64KB page granularity
>    xen/privcmd: Add support for Linux 64KB page granularity
>    arm/xen: Add support for 64KB page granularity
>
>   arch/arm/include/asm/xen/page.h     |  18 +-
>   arch/arm/xen/enlighten.c            |   6 +-
>   arch/arm/xen/p2m.c                  |   6 +-
>   arch/x86/include/asm/xen/page.h     |   2 +-
>   drivers/block/xen-blkback/blkback.c |   5 +-
>   drivers/block/xen-blkback/common.h  |  17 +-
>   drivers/block/xen-blkback/xenbus.c  |   9 +-
>   drivers/block/xen-blkfront.c        | 552 +++++++++++++++++++++++-------------
>   drivers/net/xen-netback/common.h    |  15 +-
>   drivers/net/xen-netback/netback.c   | 163 +++++++----
>   drivers/net/xen-netfront.c          | 122 +++++---
>   drivers/tty/hvc/hvc_xen.c           |   4 +-
>   drivers/xen/balloon.c               |  47 ++-
>   drivers/xen/biomerge.c              |   8 +
>   drivers/xen/events/events_base.c    |   2 +-
>   drivers/xen/events/events_fifo.c    |   2 +-
>   drivers/xen/grant-table.c           |  32 ++-
>   drivers/xen/privcmd.c               |   8 +-
>   drivers/xen/xenbus/xenbus_client.c  |   6 +-
>   drivers/xen/xenbus/xenbus_probe.c   |   3 +-
>   drivers/xen/xlate_mmu.c             | 124 +++++---
>   include/xen/grant_table.h           |  51 ++++
>   include/xen/page.h                  |  27 +-
>   23 files changed, 844 insertions(+), 385 deletions(-)
>

-- 
Julien Grall
