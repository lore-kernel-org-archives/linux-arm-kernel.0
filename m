From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 Sep 2015 12:32:14 +0100
Subject: [PATCH v5 00/22] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <20150930113214.GA10997@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 11:45:15AM +0100, Julien Grall wrote:
> Hi all,

Hi,

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

Just to check, would this be expected to work with a 16K DomU (e.g.
[2])?

>From a quick scan it looks like the relaxations provided by this series
should work so long as PAGE_SIZE % XEN_PAGE_SIZE == 0, assuming I
haven't missed something.

> There is room for improvement, such as support of 64KB grant, modification
> of PV protocol to support different page size... They will be explored in a
> separate patch series later.
> 
> TODO list:
>     - Convert xenfb to 64KB
>     - Support for multiple page ring support
>     - Support for 64KB in gnttdev
>     - Support of non-indirect grant with 64KB frontend (patch sent [1])
>     - It may be possible to move some common define between
>     netback/netfront and blkfront/blkback in an header

Would any of these require more work to also handle 16K?

Thanks,
Mark.

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/370117.html

> I've got most of the patches for the TODO items. I'm planning to send them as
> a follow-up as it's not a requirement for a basic guests.
> 
> All patches has been built tested for ARM32, ARM64, x86. But I haven't tested
> to run it on x86 as I don't have a box with Xen x86 running. Although, 99%
> of the changes has been made in the PV drivers there should be no specific
> issue. Although, I would be happy if someone give a try and see possible
> regression for x86.
> 
> I know that Konrad as a test-suite for x86. Konrand, would it be possible to
> give a run to for this series?
> 
> A branch based on the latest xentip/for-linus-4.4 can be found here:
> 
> git://xenbits.xen.org/people/julieng/linux-arm.git branch xen-64k-v5
> 
> There is no major changes in this series, only a couple of conflict during
> rebase in netback and balloon drivers. For those pathces, I've keept the
> reviewed-by/acked-by from Wei and Stefano. Let me know if it's not fine.
> 
> I also fold the swiotlb patch series into this series because it has been
> reviewed by Stefano and I don't think there is much controversy (see patch #21
> and #22).
> 
> Comments, suggestions are welcomed.
> 
> Sincerely yours,
> 
> [1] https://lkml.org/lkml/2015/9/11/567
> 
> Cc: david.vrabel at citrix.com
> Cc: konrad.wilk at oracle.com
> Cc: boris.ostrovsky at oracle.com
> Cc: wei.liu2 at citrix.com
> Cc: roger.pau at citrix.com
> 
> Status of each patch:
> 
> A: Reviewed-by - Acked-by
> M: Patch modified in this series
> m: Minor changes in this series due to conflict during rebase
> L: Missing Acked-by from a Linux maintainers (Boris, David or Konrad)
> 
> Julien Grall (22):
> A       net/xen-netback: xenvif_gop_frag_copy: move GSO check out of the loop
> A       arm/xen: Drop pte_mfn and mfn_pte
> A   L   xen: Add Xen specific page definition
> A       xen/grant: Introduce helpers to split a page into grant
> A       xen/grant: Add helper gnttab_page_grant_foreign_access_ref_one
> A       block/xen-blkfront: Split blkif_queue_request in 2
> A       block/xen-blkfront: Store a page rather a pfn in the grant structure
> A       block/xen-blkfront: split get_grant in 2
> A   L   xen/biomerge: Don't allow biovec's to be merged when Linux is not
>           using 4KB pages
> A       xen/xenbus: Use Xen page definition
> A   L   tty/hvc: xen: Use xen page definition
> A m L   xen/balloon: Don't rely on the page granularity is the same for Xen
>           and Linux
> A       xen/events: fifo: Make it running on 64KB granularity
> A       xen/grant-table: Make it running on 64KB granularity
> A       block/xen-blkfront: Make it running on 64KB page granularity
> A       block/xen-blkback: Make it running on 64KB page granularity
> A       net/xen-netfront: Make it running on 64KB page granularity
> A m     net/xen-netback: Make it running on 64KB page granularity
> A       xen/privcmd: Add support for Linux 64KB page granularity
> A       arm/xen: Add support for 64KB page granularity
> A m L   xen/swiotlb: Pass addresses rather than frame numbers to
>           xen_arch_need_swiotlb
> A   L   xen/swiotlb: Add support for 64KB page granularity
> 
>  arch/arm/include/asm/xen/page-coherent.h |  26 +-
>  arch/arm/include/asm/xen/page.h          |  22 +-
>  arch/arm/xen/enlighten.c                 |   6 +-
>  arch/arm/xen/mm.c                        |  39 ++-
>  arch/arm/xen/p2m.c                       |   6 +-
>  arch/x86/include/asm/xen/page.h          |   6 +-
>  drivers/block/xen-blkback/blkback.c      |   5 +-
>  drivers/block/xen-blkback/common.h       |  17 +-
>  drivers/block/xen-blkback/xenbus.c       |   9 +-
>  drivers/block/xen-blkfront.c             | 552 ++++++++++++++++++++-----------
>  drivers/net/xen-netback/common.h         |  16 +-
>  drivers/net/xen-netback/netback.c        | 167 ++++++----
>  drivers/net/xen-netfront.c               | 122 +++++--
>  drivers/tty/hvc/hvc_xen.c                |   4 +-
>  drivers/xen/balloon.c                    |  69 +++-
>  drivers/xen/biomerge.c                   |   8 +
>  drivers/xen/events/events_base.c         |   2 +-
>  drivers/xen/events/events_fifo.c         |   2 +-
>  drivers/xen/grant-table.c                |  32 +-
>  drivers/xen/privcmd.c                    |   8 +-
>  drivers/xen/swiotlb-xen.c                |  43 ++-
>  drivers/xen/xenbus/xenbus_client.c       |   6 +-
>  drivers/xen/xenbus/xenbus_probe.c        |   3 +-
>  drivers/xen/xlate_mmu.c                  | 124 ++++---
>  include/xen/grant_table.h                |  51 +++
>  include/xen/page.h                       |  27 +-
>  26 files changed, 937 insertions(+), 435 deletions(-)
> 
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
