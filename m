From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 05 Mar 2014 13:44:34 +0100
Subject: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <53170EC2.6090908@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>	<1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
 <CAPDyKFqK1JqxeJ_L_bzduixRLGA5m_FFPq_of2r6y0aCpS7z9A@mail.gmail.com>
 <53170EC2.6090908@gmail.com>
Message-ID: <53171C32.20107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.03.2014 12:47, Tomasz Figa wrote:
> Hi Ulf,
>
> On 05.03.2014 08:19, Ulf Hansson wrote:
>>> @@ -2177,3 +2181,297 @@ void pm_genpd_init(struct generic_pm_domain
>>> *genpd,
>>>          list_add(&genpd->gpd_list_node, &gpd_list);
>>>          mutex_unlock(&gpd_list_lock);
>>>   }
>>> +
>>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>>
>> Do we need a new config for this? Can't we just use CONFIG_OF?
>>
>
> I guess we could, but initially it would have to be CONFIG_OF &&
> !CONFIG_ARCH_EXYNOS until patch 03/11 converts Exynos to use the common
> code.
>
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "failed to add to power domain %s: %d",
>>> +                       pd->name, ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       pm_genpd_dev_need_restore(dev, true);
>>
>> So this will reflect the device as being inactive, which I think is
>> the wrong approach.
>>
>> Usually we should expect drivers that's being probed successfully to
>> leave their devices in active state, right?
>
> It depends on domain power state, but actually it seems to be already
> handled in __pm_genpd_add_device(), so this line might be not needed
> indeed.
>
> Strangely enough, it seemed to be needed on Exynos for correct
> operation, but maybe in the meantime some fixes in genpd code showed up.
> This will need some extra testing.

Hmm, after removing this line, power domains no longer work correctly on 
Exynos (thanks Marek for testing). Unfortunately I'm on a sick leave 
right now and I won't be able to debug this issue on Exynos for some 
time, but I'll see if I can reproduce it on s3c64xx board I have here at 
home.

Best regards,
Tomasz
