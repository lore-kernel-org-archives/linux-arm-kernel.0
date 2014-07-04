From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 04 Jul 2014 10:47:44 +0200
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
In-Reply-To: <53B5CA26.7050405@free-electrons.com>
References: <20140703135146.GA6898@luxor.wired.org>
 <53B5C61D.2060308@free-electrons.com> <53B5CA26.7050405@free-electrons.com>
Message-ID: <1936558.QaAG1bYMuD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

(CC'ing the IOMMU mailing list)

On Thursday 03 July 2014 23:24:54 Gregory CLEMENT wrote:
> On 03/07/2014 23:07, Gregory CLEMENT wrote:
> > On 03/07/2014 23:01, Thomas Petazzoni wrote:
> >> Hello,
> >> 
> >> If you have touched the OMAP IOMMU driver recently, please read on.
> >> 
> >> On Thu, 03 Jul 2014 22:57:38 +0200, Gregory CLEMENT wrote:
> >>>> So it calls bus_set_iommu() unconditionally, without caring at all
> >>>> whether it is running on a platform that actually cares about OMAP
> >>>> IOMMU. And then later on, a bus notifier of the IOMMU subsystem gets
> >>>> called, and some NULL pointer gets dereferenced. I'm pretty sure that
> >>>> if you comment out this subsys_initcall(), you won't see the problem
> >>>> anymore.

The OMAP IOMMU driver isn't the only one registering itself with the platform 
bus at probe time, regardless of the system the kernel runs on. Some IOMMU 
drivers push the bus_set_iommu() call to the probe function, but that's not a 
good solution either, as we could have several instances of the same IOMMU, 
and all of them should be probed before the bus_set_iommu() call.

We need a quick fix for v3.16, but we also need to fix bus_set_iommu(). That's 
on my to-do list for <insert some fuzzy future date here>, but if you want to 
give it a go, please feel free to do so. In all cases, this is a good occasion 
to start discussing the problem. Any opinion on what the perfect API would 
look like ?

> >>> Indeed I comment it, and I didn't see the problem anymore.
> >>> 
> >>>> However, this code has been around since a while, so I don't know if
> >>>> it's actually the change that makes it visible. Maybe some other IOMMU
> >>>> core internal change makes it actually visible. But this
> >>>> subsys_initcall() that does random stuff without caring about the
> >>>> platform it runs on anyway looks incorrect.
> >>> 
> >>> I think that nobody until now have run this configuration.
> >> 
> >> Hum, indeed, I was assuming multi_v7_defconfig would have that enabled,
> >> but it only has the Tegra IOMMU enabled, and not the OMAP IOMMU one.
> >> 
> >> So, the bug clearly belongs to the developers of the OMAP IOMMU driver,
> >> so I've added a bunch of people who touched this driver recently in Cc.
> > 
> > To add more information: I thought the problem was here from a long time
> > so I tested a 3.14 kernel, and in this case the kernel booted without any
> > problem. So the bug is pretty recent. I will do a last test with 3.15 and
> > I will keep you inform.
> 
> So it also boot well in 3.15 and then failed in 3.16-rc3. I hope it will
> help the developers of the OMAP IOMMU driver to fix it.

Thank you. I've had a look at the OMAP IOMMU driver changes between v3.15 and 
v3.16-rc3, and didn't find at first sight any change that could explain the 
crash.

286f600 iommu/omap: Fix map protection value handling
67b779d iommu/omap: Remove comment about supporting single page mappings only
f7129a0 iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
5acc97d iommu/omap: Move to_iommu definition from omap-iopgtable.h
2ac6133 iommu/omap: Remove omap_iommu_domain_has_cap() function
d760e3e iommu/omap: Correct init value of iotlb_entry valid field

Could you try reverting those changes and retest ? If the problem doesn't 
disappear, we'll need to look somewhere else.

-- 
Regards,

Laurent Pinchart
