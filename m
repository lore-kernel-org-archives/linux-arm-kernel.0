From: xuzaibo@huawei.com (Xu Zaibo)
Date: Wed, 5 Sep 2018 11:15:37 +0800
Subject: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <bc27f902-4d12-21b7-b9e9-18bcae170503@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B83B11E.7010807@huawei.com> <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
 <5B89F818.7060300@huawei.com> <3a961aff-e830-64bb-b6a9-14e08de1abf5@arm.com>
 <5B8DEA15.7020404@huawei.com> <bc27f902-4d12-21b7-b9e9-18bcae170503@arm.com>
Message-ID: <5B8F4A59.20004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2018/9/4 18:57, Jean-Philippe Brucker wrote:
> On 04/09/2018 03:12, Xu Zaibo wrote:
>> On 2018/9/3 18:34, Jean-Philippe Brucker wrote:
>>> On 01/09/18 03:23, Xu Zaibo wrote:
>>>> As one application takes a whole function while using VFIO-PCI, why do
>>>> the application and the
>>>> function need to enable PASID capability? (Since just one I/O page table
>>>> is enough for them.)
>>> At the moment the series doesn't provide support for SVA without PASID
>>> (on the I/O page fault path, 08/40). In addition the BIND ioctl could be
>>> used by the owner application to bind other processes (slaves) and
>>> perform sub-assignment. But that feature is incomplete because we don't
>>> send stop_pasid notification to the owner when a slave dies.
>>>
>> So, Could I understand like this?
>>
>>       1. While the series are finished well, VFIO-PCI device can be held
>> by only one process
>>           through binding IOCTL command without PASID (without PASID
>> being exposed user space).
> It could, but isn't supported at the moment. In addition to adding
> support in the I/O page fault code, we'd also need to update the VFIO
> API. Currently a VFIO_TYPE1 domain always supports the MAP/UNMAP ioctl.
> The case you describe isn't compatible with MAP/UNMAP, since the process
> manages the shared address space with mmap or malloc. We'd probably need
> to introduce a new VFIO IOMMU type, in which case the bind could be
> performed implicitly when the process does VFIO_SET_IOMMU. Then the
> process wouldn't need to send an additional BIND IOCTL.
ok. got it.  This is the legacy mode, so all the VFIO APIs are kept 
unchanged?
>>       2. While using VFIO-PCI device to support multiple processes with
>> SVA series, a primary
>>           process with multiple secondary processes must be deployed just
>> like DPDK(https://www.dpdk.org/).
>>           And, the PASID still has to be exposed to user land.
> Right. A third case, also implemented by this patch (and complete), is
> the primary process simply doing a BIND for itself, and using the
> returned PASID to share its own address space with the device.
>
ok. But I am worried that the sulotion of one primary processes with 
several secondary ones

is a little bit limited. Maybe, users don't want to depend on the 
primary process. :)



Thanks,
Zaibo

.
