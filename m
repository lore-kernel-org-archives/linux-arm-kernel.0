From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 5 Jul 2014 12:03:08 -0300
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
In-Reply-To: <1936558.QaAG1bYMuD@avalon>
References: <20140703135146.GA6898@luxor.wired.org>
 <53B5C61D.2060308@free-electrons.com>
 <53B5CA26.7050405@free-electrons.com> <1936558.QaAG1bYMuD@avalon>
Message-ID: <20140705150308.GA28791@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After following Gregory's stacktrace (also reproduced here):

[<c02451f8>] (iommu_bus_notifier) from [<c00512e8>] (notifier_call_chain+0x64/0x9c)
[<c00512e8>] (notifier_call_chain) from [<c00514cc>] (__blocking_notifier_call_chain+0x40/0x58)
[<c00514cc>] (__blocking_notifier_call_chain) from [<c00514f8>] (blocking_notifier_call_chain+0x14/0x1c)
[<c00514f8>] (blocking_notifier_call_chain) from [<c01d225c>] (device_add+0x424/0x524)
[<c01d225c>] (device_add) from [<c0186d90>] (pci_device_add+0xec/0x110)
[<c0186d90>] (pci_device_add) from [<c0186e54>] (pci_scan_single_device+0xa0/0xac)

I added a few printks and found that the problem is that the iommu_bus_notifier is
called for the 'pci' bus type, which has a null iommu_ops.

On 04 Jul 10:47 AM, Laurent Pinchart wrote:
[..]
> 
> We need a quick fix for v3.16, ...

Therefore, a quick fix would be to simply check for that:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fc..b712cb2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -536,6 +536,9 @@ static int iommu_bus_notifier(struct notifier_block *nb,
        struct iommu_group *group;
        unsigned long group_action = 0;
 
+       if (!ops)
+               return 0;
+
        /*
         * ADD/DEL call into iommu driver ops if provided, which may
         * result in ADD/DEL notifiers to group->notifier

This (nasty workaround?) patch makes the problem go away.

[..]
> > So it also boot well in 3.15 and then failed in 3.16-rc3. I hope it will
> > help the developers of the OMAP IOMMU driver to fix it.
> 
> Thank you. I've had a look at the OMAP IOMMU driver changes between v3.15 and 
> v3.16-rc3, and didn't find at first sight any change that could explain the 
> crash.
> 
> 286f600 iommu/omap: Fix map protection value handling
> 67b779d iommu/omap: Remove comment about supporting single page mappings only
> f7129a0 iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
> 5acc97d iommu/omap: Move to_iommu definition from omap-iopgtable.h
> 2ac6133 iommu/omap: Remove omap_iommu_domain_has_cap() function
> d760e3e iommu/omap: Correct init value of iotlb_entry valid field
> 
> Could you try reverting those changes and retest ? If the problem doesn't 
> disappear, we'll need to look somewhere else.
> 

I reverted the above commits but nothing changed. I'm far from being an expert,
but it sounds odd to have this bus notifier (that got registered for the
platform bus type) called by a pci bus type.

This doesn't look like a mvebu-specific problem, other platforms should be
affected as well. I'm Ccing GregKH, in case he has an idea what's going on.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
