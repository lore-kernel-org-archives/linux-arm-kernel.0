From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 31 Aug 2018 14:34:52 +0100
Subject: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <5B83B11E.7010807@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B83B11E.7010807@huawei.com>
Message-ID: <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zaibo,

On 27/08/18 09:06, Xu Zaibo wrote:
>> +struct vfio_iommu_type1_bind_process {
>> +??? __u32??? flags;
>> +#define VFIO_IOMMU_BIND_PID??????? (1 << 0)
>> +??? __u32??? pasid;
> As I am doing some works on the SVA patch set. I just consider why the
> user space need this pasid.
> Maybe, is it much more reasonable to set the pasid into all devices
> under the vfio container by
> a call back function from 'vfio_devices'? while
> 'VFIO_IOMMU_BIND_PROCESS' CMD is executed
> in kernel land? I am not sure because there exists no suitable call back
> in 'vfio_device' at present.

When using vfio-pci, the kernel doesn't know how to program the PASID
into the device because the only kernel driver for the device is the
generic vfio-pci module. The PCI specification doesn't describe a way of
setting up the PASID, it's vendor-specific. Only the userspace
application owning the device (and calling VFIO_IOMMU_BIND) knows how to
do it, so we return the allocated PASID.

Note that unlike vfio-mdev where applications share slices of a
function, with vfio-pci one application owns the whole function so it's
safe to let userspace set the PASID in hardware. With vfio-mdev it's the
kernel driver that should be in charge of setting the PASID as you
described, and we wouldn't have a reason to return the PASID in the
vfio_iommu_type1_bind_process structure.

Thanks,
Jean
