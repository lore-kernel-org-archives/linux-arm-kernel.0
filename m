From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 22 Apr 2016 10:47:32 +0800
Subject: [PATCH v2 all 00/14] use of_platform_default_populate() to
 populate default bus
In-Reply-To: <CAL_Jsq+cGbrtz6ZC8fgdD3H1yk7rWpzc9rg8uXOXqL6EJJDsOg@mail.gmail.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
 <CAL_JsqK34MOSkdJb1Sqq3CzYSz5xGeEnuThS_GmfFXMHX-8d9A@mail.gmail.com>
 <5718878A.8040901@huawei.com>
 <CAL_Jsq+cGbrtz6ZC8fgdD3H1yk7rWpzc9rg8uXOXqL6EJJDsOg@mail.gmail.com>
Message-ID: <571990C4.7000901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/21 21:10, Rob Herring wrote:
> On Thu, Apr 21, 2016 at 2:55 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Hi Rob,
>>
>> On 2016/4/20 5:10, Rob Herring wrote:
>>> On Wed, Mar 16, 2016 at 2:35 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>> Use helper of_platform_default_populate() in linux/of_platform
>>>> when possible, instead of calling of_platform_populate() with
>>>> the default match table.
>>>>
>>>> Then it is possible for driver code build as a module, and no
>>>> need to export of_default_bus_match_table anymore.
>>>>
>>>> This patchset is based on Linux 4.5.
>>>>
>>>> Changes since v1:
>>>> - Add ack, test and review
>>>> - Remove v1 patch 14/15, the similar patch has posted and applied,
>>>>   see https://patchwork.kernel.org/patch/8096991/
>>>>
>>>> v1:
>>>> - https://lkml.org/lkml/2016/1/26/1123
>>>
>>> I was going to apply this, but I've thought about this some more and
>>> it is a lot of tree wide churn for little gain. Most of the call sites
>>> here I want to get rid of by making of_platform_populate callable
>>> multiple times. The infrastructure is almost there, but I think we
>>> just need something like this:
>>>
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index 8d103e4..b25e710 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -345,6 +345,9 @@ static int of_platform_bus_create(struct device_node *bus,
>>>                 return 0;
>>>         }
>>>
>>> +       if (of_node_check_flag(bus, OF_POPULATED_BUS))
>>> +               return 0;
>>> +
>>>         auxdata = of_dev_lookup(lookup, bus);
>>>         if (auxdata) {
>>>                 bus_id = auxdata->name;
>>>
>>> Then we can call of_platform_populate from the DT core and remove all
>>> the default calls.
>>
>> OK, it seems that we can drop all the of_of_platform_default_populate in arch code
>> by this changes, will do it.
>>
>> But replace of_platform_populate() with the default match table by of_platform_default_populate
>> is a cleanup, and especially for the driver, we can not need export of_default_bus_match_table
>> after that.
>>
>> There is a v3 patchset[1], it is based 4.6-rc2 with some updated, should this be merge firstly,
>> then drop all the default of_platform_populate in arch code, and I think the of_iommu_init() in
>> arch code could do the same thing.
>>
>> If not, I will repost the patches with new ways, but still exists the part of unexport
>> of_default_bus_match_table by helper of_platform_default_populate().
>>
>> Hope the v3 patchset could be merge in advance, after all, it has been reviewed fully. Thanks a lot.
> 
> We'd be touching the same line twice in a bunch of places if we apply
> this series first, so it makes more sense to remove all these calls
> first and then use of_platform_default_populate where it is still
> needed.

Agree, will repost them.

BRs,
Kefeng

> 
> Rob
> 
> .
> 
