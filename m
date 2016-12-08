From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 8 Dec 2016 10:01:32 -0700
Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <cd16fc5c-8649-0bfa-d67d-8f257aa38bd6@arm.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <c5d4efa7-699d-4aa3-44cc-4ce03d0ce185@redhat.com>
 <cd16fc5c-8649-0bfa-d67d-8f257aa38bd6@arm.com>
Message-ID: <20161208100132.4e9cc3c5@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Dec 2016 13:14:04 +0000
Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/12/16 09:36, Auger Eric wrote:
> > 3) RMRR reporting in the iommu group sysfs? Joerg: yes; Don: no
> >    My current series does not expose them in iommu group sysfs.
> >    I understand we can expose the RMRR regions in the iomm group sysfs
> >    without necessarily supporting RMRR requiring device assignment.
> >    We can also add this support later.  
> 
> As you say, reporting them doesn't necessitate allowing device
> assignment, and it's information which can already be easily grovelled
> out of dmesg (for intel-iommu at least) - there doesn't seem to be any
> need to hide them, but the x86 folks can have the final word on that.

Eric and I talked about this and I don't see the value in identifying
an RMRR as anything other than a reserved range for a device.  It's not
userspace's job to maintain an identify mapped range for the device,
and it can't be trusted to do so anyway.  It does throw a kink in the
machinery though as an RMRR is a reserved memory range unique to a
device.  It doesn't really fit into a monolithic /sys/class/iommu view
of global reserved regions as an RMRR is only relevant to the device
paths affected.

Another kink is that sometimes we know what the RMRR is for, know that
it's irrelevant for our use case, and ignore it.  This is true for USB
and Intel graphics use cases of RMRRs.

Also, aside from the above mentioned cases, devices with RMRRs are
currently excluded from participating in the IOMMU API by the
intel-iommu driver and I expect this to continue in the general case
regardless of whether the ranges are more easily exposed to userspace.
ARM may have to deal with mangling a guest memory map due to lack of
any standard layout, de facto or otherwise, but for x86 I don't think
it's worth the migration and hotplug implications.  Thanks,

Alex
