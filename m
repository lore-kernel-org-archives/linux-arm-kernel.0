From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 24 May 2018 12:44:47 +0100
Subject: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <5B0536A3.1000304@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B0536A3.1000304@huawei.com>
Message-ID: <cd13f60d-b282-3804-4ca7-2d34476c597f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/05/18 10:38, Xu Zaibo wrote:
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +???????????????? struct vfio_group *group,
>> +???????????????? struct vfio_mm *vfio_mm)
>> +{
>> +??? int ret;
>> +??? bool enabled_sva = false;
>> +??? struct vfio_iommu_sva_bind_data data = {
>> +??????? .vfio_mm??? = vfio_mm,
>> +??????? .iommu??????? = iommu,
>> +??????? .count??????? = 0,
>> +??? };
>> +
>> +??? if (!group->sva_enabled) {
>> +??????? ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +?????????????????????????? vfio_iommu_sva_init);
> Do we need to do *sva_init here or do anything to avoid repeated
> initiation?
> while another process already did initiation at this device, I think
> that current process will get an EEXIST.

Right, sva_init() must be called once for any device that intends to use
bind(). For the second process though, group->sva_enabled will be true
so we won't call sva_init() again, only bind().

Thanks,
Jean
