From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Wed, 21 Nov 2018 14:37:24 -0500
Subject: [PATCH 0/9] Use vm_insert_range
In-Reply-To: <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA@mail.gmail.com>
References: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
 <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA@mail.gmail.com>
Message-ID: <0c6f1144-6ee0-29df-5e1f-d35d2264e06e@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/18 1:24 AM, Souptick Joarder wrote:
> On Thu, Nov 15, 2018 at 9:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Previouly drivers have their own way of mapping range of
>> kernel pages/memory into user vma and this was done by
>> invoking vm_insert_page() within a loop.
>>
>> As this pattern is common across different drivers, it can
>> be generalized by creating a new function and use it across
>> the drivers.
>>
>> vm_insert_range is the new API which will be used to map a
>> range of kernel memory/pages to user vma.
>>
>> All the applicable places are converted to use new vm_insert_range
>> in this patch series.
>>
>> Souptick Joarder (9):
>>   mm: Introduce new vm_insert_range API
>>   arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
>>   drivers/firewire/core-iso.c: Convert to use vm_insert_range
>>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
>>   drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
>>   iommu/dma-iommu.c: Convert to use vm_insert_range
>>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
>>   xen/gntdev.c: Convert to use vm_insert_range
>>   xen/privcmd-buf.c: Convert to use vm_insert_range
> Any further comment on driver changes ?

Xen drivers (the last two patches) look fine to me.

-boris


>>  arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
>>  drivers/firewire/core-iso.c                       | 15 ++----------
>>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
>>  drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
>>  drivers/iommu/dma-iommu.c                         | 12 ++--------
>>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
>>  drivers/xen/gntdev.c                              | 11 ++++-----
>>  drivers/xen/privcmd-buf.c                         |  8 ++-----
>>  include/linux/mm_types.h                          |  3 +++
>>  mm/memory.c                                       | 28 +++++++++++++++++++++++
>>  mm/nommu.c                                        |  7 ++++++
>>  11 files changed, 70 insertions(+), 98 deletions(-)
>>
>> --
>> 1.9.1
>>
