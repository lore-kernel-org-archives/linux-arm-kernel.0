From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 04 Dec 2014 17:42:33 +0000
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
 drivers
In-Reply-To: <20141204144925.GB31464@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
 <CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
 <2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
 <CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
 <54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
Message-ID: <54809D09.2050406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 04/12/14 14:49, Thierry Reding wrote:
> On Thu, Dec 04, 2014 at 01:43:32PM +0000, Robin Murphy wrote:
>> Hi Grant, thanks for the advice - silly micro-optimisations removed, and
>> I'll make a note to do so from my in-development code, too ;)
>>
>> I didn't much like the casting either, so rather than push it elsewhere or
>> out to the caller I've just changed the prototype to obviate it completely.
>> Since we're also expecting to churn this again to use something more
>> suitable than iommu_ops as the private data, I think keeping things simple
>> wins over const-correctness for now.
>>
>> Thanks,
>> Robin
>>
>> --->8---
>>  From b2e8c91ac49bef4008661e4628cd6b7249d84af5 Mon Sep 17 00:00:00 2001
>> Message-Id: <b2e8c91ac49bef4008661e4628cd6b7249d84af5.1417698001.git.robin.murphy@arm.com>
>> From: Robin Murphy <robin.murphy@arm.com>
>> Date: Thu, 4 Dec 2014 11:53:13 +0000
>> Subject: [PATCH v2] iommu: store DT-probed IOMMU data privately
>>
>> Since the data pointer in the DT node is public and may be overwritten
>> by conflicting code, move the DT-probed IOMMU ops to a private list
>> where they will be safe.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/of_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of_iommu.h | 12 ++----------
>>   2 files changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 73236d3..c7078f6 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -94,6 +94,46 @@ int of_get_dma_window(struct device_node *dn, const char
>> *prefix, int index,
>>   }
>>   EXPORT_SYMBOL_GPL(of_get_dma_window);
>>
>> +struct of_iommu_node {
>> +	struct list_head list;
>> +	struct device_node *np;
>> +	struct iommu_ops *ops;
>
> Why can't this be const? Why would anyone ever need to modify it? Also
> drivers do define their iommu_ops structures const these days, so you'll
> either still have to cast away at some point or the compiler will
> complain once you start calling this from drivers.
>

...whereas if we make everything const then the drivers that _do_ want 
to use the private data introduced by this series and thus pass mutable 
per-instance iommu_ops will be the ones having to cast. We have no users 
either way until this series is merged, and the need to stash the 
per-instance data somewhere other than np->data is in the way of getting 
it merged - this is just a quick hack to address that. I think we've 
already agreed that mutable per-instance iommu_ops holding private data 
aren't particularly pleasant and will (hopefully) go away in the next 
iteration[1], at which point this all changes anyway.

Regards,
Robin.

[1]:http://article.gmane.org/gmane.linux.kernel.iommu/7554
