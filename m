From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 5 Jun 2010 15:58:32 +0800
Subject: [PATCH 1/3] MTD/pxa: patch for error return value method of
	pxa2xx-flash.c
In-Reply-To: <AANLkTikJiPjl3LKVqgqtlK2YEePXDf7K6EdOlUE4uzBb@mail.gmail.com>
References: <4C09F15E.9020408@gmail.com>
	<AANLkTinLfGD-x-861sFK9r2zW5aEZvyXIB4PFKJl8NDZ@mail.gmail.com>
	<AANLkTikJiPjl3LKVqgqtlK2YEePXDf7K6EdOlUE4uzBb@mail.gmail.com>
Message-ID: <AANLkTilQQcjCCF1bG7qfJ27sOD8JcGzCYhCf3kVmzXw7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 5, 2010 at 3:38 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> Hi Eric,
>
> Thanks for your review.
>
> 2010/6/5 Eric Miao <eric.y.miao@gmail.com>:
>> 2010/6/5 Wan ZongShun <mcuos.com@gmail.com>:
>>> This patch is to re-implement the 'pxa2xx-flash.c' error return value method
>>> of probe() and remove() function,the old return way can arouse the 'info' memory
>>> leak risk.
>>>
>>> Signed-off-by :Wan ZongShun <mcuos.com@gmail.com>
>>>
>>> ---
>>> ?drivers/mtd/maps/pxa2xx-flash.c | ? 47 ++++++++++++++++++++++++++++----------
>>> ?1 files changed, 34 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
>>> index dd90880..1d2583f 100644
>>> --- a/drivers/mtd/maps/pxa2xx-flash.c
>>> +++ b/drivers/mtd/maps/pxa2xx-flash.c
>>> @@ -60,12 +60,21 @@ static int __init pxa2xx_flash_probe(struct platform_device *pdev)
>>> ? ? ? ?int ret = 0;
>>>
>>> ? ? ? ?res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> - ? ? ? if (!res)
>>> - ? ? ? ? ? ? ? return -ENODEV;
>>> + ? ? ? if (!res) {
>>> + ? ? ? ? ? ? ? ret = -ENODEV;
>>> + ? ? ? ? ? ? ? goto fail0;
>>> + ? ? ? }
>>
>> Can just return -ENODEV, why bother goto here?
>>
>>> +
>>> + ? ? ? if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
>>> + ? ? ? ? ? ? ? ret = -EBUSY;
>>> + ? ? ? ? ? ? ? goto fail0;
>>> + ? ? ? }
>>>
>>
>> Same here, nothing to release, can just return -EBUSY here. Provided I
>> always doubt the necessity of request_mem_region() here since the resource
>> should have been claimed when the platform device is registered, this is
>> possibly going to claim a sub-region of that resource. But that's another
>> story.
>
> I agree with you.
> So, keep it be there or remove it?
>

I'd recommend not to add it in this patch. You can have another patch
to add it if it's necessary.

> Could Keeping it make a more compatibility code?
>
>
>>
>>> ? ? ? ?info = kzalloc(sizeof(struct pxa2xx_flash_info), GFP_KERNEL);
>>> - ? ? ? if (!info)
>>> - ? ? ? ? ? ? ? return -ENOMEM;
>>> + ? ? ? if (!info) {
>>> + ? ? ? ? ? ? ? ret = -ENOMEM;
>>> + ? ? ? ? ? ? ? goto fail1;
>>> + ? ? ? }
>>>
>>> ? ? ? ?info->map.name = (char *) flash->name;
>>> ? ? ? ?info->map.bankwidth = flash->width;
>>> @@ -78,13 +87,17 @@ static int __init pxa2xx_flash_probe(struct platform_device *pdev)
>>> ? ? ? ?if (!info->map.virt) {
>>> ? ? ? ? ? ? ? ?printk(KERN_WARNING "Failed to ioremap %s\n",
>>> ? ? ? ? ? ? ? ? ? ? ? info->map.name);
>>> - ? ? ? ? ? ? ? return -ENOMEM;
>>> + ? ? ? ? ? ? ? ret = -ENOMEM;
>>> + ? ? ? ? ? ? ? goto fail2;
>>> ? ? ? ?}
>>> ? ? ? ?info->map.cached =
>>> ? ? ? ? ? ? ? ?ioremap_cached(info->map.phys, info->map.size);
>>> - ? ? ? if (!info->map.cached)
>>> + ? ? ? if (!info->map.cached) {
>>> ? ? ? ? ? ? ? ?printk(KERN_WARNING "Failed to ioremap cached %s\n",
>>> ? ? ? ? ? ? ? ? ? ? ? info->map.name);
>>
>>
>> This might not be an error at all, it's a warning. The cached mapping is
>> for performance reason on some platforms, it should be working all right
>> without it.
>
> Thanks, I just have a doubt regarding this condition judement, so
> thanks for your comments.
>
>>
>>> + ? ? ? ? ? ? ? ret = -ENOMEM;
>>> + ? ? ? ? ? ? ? goto fail3;
>>> + ? ? ? }
>>> ? ? ? ?info->map.inval_cache = pxa2xx_map_inval_cache;
>>> ? ? ? ?simple_map_init(&info->map);
>>>
>>> @@ -97,10 +110,8 @@ static int __init pxa2xx_flash_probe(struct platform_device *pdev)
>>> ? ? ? ?info->mtd = do_map_probe(flash->map_name, &info->map);
>>>
>>> ? ? ? ?if (!info->mtd) {
>>> - ? ? ? ? ? ? ? iounmap((void *)info->map.virt);
>>> - ? ? ? ? ? ? ? if (info->map.cached)
>>> - ? ? ? ? ? ? ? ? ? ? ? iounmap(info->map.cached);
>>> - ? ? ? ? ? ? ? return -EIO;
>>> + ? ? ? ? ? ? ? ret = -EIO;
>>
>> See above.
>>
>>> + ? ? ? ? ? ? ? goto fail4;
>>> ? ? ? ?}
>>> ? ? ? ?info->mtd->owner = THIS_MODULE;
>>>
>>> @@ -124,13 +135,21 @@ static int __init pxa2xx_flash_probe(struct platform_device *pdev)
>>>
>>> ? ? ? ?platform_set_drvdata(pdev, info);
>>> ? ? ? ?return 0;
>>> +
>>> +fail4: iounmap(info->map.cached);
>>> +fail3: iounmap(info->map.virt);
>>> +fail2: kfree(info);
>>> +fail1: release_mem_region(res->start, resource_size(res));
>>> +fail0:
>>> + ? ? ? return ret;
>>> ?}
>>>
>>> ?static int __devexit pxa2xx_flash_remove(struct platform_device *dev)
>>> ?{
>>> ? ? ? ?struct pxa2xx_flash_info *info = platform_get_drvdata(dev);
>>> + ? ? ? struct resource *res;
>>>
>>> - ? ? ? platform_set_drvdata(dev, NULL);
>>
>> What's wrong with the above statement? And normally there is some benefit
>> of setting drive data to be NULL, as the driver data could be used concurrently
>> during removal (i.e. an interrupt handler if the IRQ is not already disabled).
>> Though relying on this behavior to safely remove a device is _not_ by anyway
>> recommended.
>
> I got it,so, setting the drive data to be NULL should be as early as possible.
>

Normally yes. But I don't think that's a guarantee of a safe removal though.
