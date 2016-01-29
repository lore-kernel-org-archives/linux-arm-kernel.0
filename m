From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 29 Jan 2016 17:51:49 +0200
Subject: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <CAHp75VdZMtm0_USuX2tiFO+O2QK8Wa+A9FDKZ=JqqGwr0SWi0g@mail.gmail.com>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
 <1452181575-9206-3-git-send-email-tomeu.vizoso@collabora.com>
 <CAHp75VdZMtm0_USuX2tiFO+O2QK8Wa+A9FDKZ=JqqGwr0SWi0g@mail.gmail.com>
Message-ID: <CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 5:38 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 7, 2016 at 5:46 PM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Adds a function that sets the pointer to dev_pm_domain in struct device
>> and that warns if the device has already finished probing. The reason
>> why we want to enforce that is because in the general case that can
>> cause problems and also that we can simplify code quite a bit if we can
>> always assume that.
>>
>> This patch also changes all current code that directly sets the
>> dev.pm_domain pointer.
>
>
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>
>> @@ -875,13 +876,14 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>>
>>         switch (action) {
>>         case BUS_NOTIFY_BIND_DRIVER:
>> -               pdev->dev.pm_domain = &acpi_lpss_pm_domain;
>> +               dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
>>                 break;
>>         case BUS_NOTIFY_DRIVER_NOT_BOUND:
>>         case BUS_NOTIFY_UNBOUND_DRIVER:
>>                 pdev->dev.pm_domain = NULL;
>
> Missed?
>
>>                 break;
>>         case BUS_NOTIFY_ADD_DEVICE:
>> +               dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
>>                 if (pdata->dev_desc->flags & LPSS_LTR)
>>                         return sysfs_create_group(&pdev->dev.kobj,
>>                                                   &lpss_attr_group);
>> @@ -889,6 +891,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>>         case BUS_NOTIFY_DEL_DEVICE:
>>                 if (pdata->dev_desc->flags & LPSS_LTR)
>>                         sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
>> +               dev_pm_domain_set(&pdev->dev, NULL);
>>                 break;
>>         default:
>>                 break;
>
> This looks wrong. I didn't test yet, but I have concerns here. Why did
> you add those calls?


Okay, for first glance it seems working on Intel Braswell. But can
yoyu point me out what was going on before this patch?

-- 
With Best Regards,
Andy Shevchenko
