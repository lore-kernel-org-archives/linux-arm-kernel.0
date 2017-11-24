From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 24 Nov 2017 10:58:32 +0000
Subject: [RFCv2 PATCH 10/36] vfio: Add support for Shared Virtual Memory
In-Reply-To: <419afe22-816d-263f-9c85-1a9e28c723b7@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-11-jean-philippe.brucker@arm.com>
 <419afe22-816d-263f-9c85-1a9e28c723b7@huawei.com>
Message-ID: <f297c4a8-559f-bf23-d5c2-219763bba289@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/17 08:23, Bob Liu wrote:
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> Add two new ioctl for VFIO containers. VFIO_DEVICE_BIND_PROCESS creates a
>> bond between a container and a process address space, identified by a
>> device-specific ID named PASID. This allows the device to target DMA
>> transactions at the process virtual addresses without a need for mapping
>> and unmapping buffers explicitly in the IOMMU. The process page tables are
>> shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
>> handle faults. VFIO_DEVICE_UNBIND_PROCESS removed a bond identified by a
>> PASID.
>> 
> 
> How about hide bind/unbind into ioctl(VFIO_SET_IOMMU)?
> e.g always bind to current process in SET_IOMMU.
> 
> Not sure about the real use case.

I guess you could introduce a new VFIO IOMMU type for this. I think this
would be useful for SVA without PASID: if the device supports I/O page
faults, use SET_IOMMU with a VFIO_SVA_IOMMU type (for example) and the
process is bound automatically to the default translation context of the
device. This requires a new IOMMU type because the MAP/UNMAP ioctl won't
work anymore.

I'm not keen on introducing loads of new features in the APIs at the
moment, because I only have the IOMMU point of view, not many endpoint users.

Thanks,
Jean
