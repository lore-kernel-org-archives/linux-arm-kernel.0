From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 9 Sep 2016 10:41:08 +0100
Subject: [PATCH 06/10] PM / Domains: Verify the PM domain is present when
 adding a provider
In-Reply-To: <CAPDyKFoLh6f3at-grfWmeRuvLwW+o=4sLG0kExuF+eZxDF_hHA@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-7-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFoLh6f3at-grfWmeRuvLwW+o=4sLG0kExuF+eZxDF_hHA@mail.gmail.com>
Message-ID: <d52f7901-b65b-3ea9-4c3b-863f7c105320@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/09/16 12:39, Ulf Hansson wrote:
> On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
>> When a PM domain provider is added, there is currently no way to tell if
>> any PM domains associated with the provider are present. Naturally, the
>> PM domain provider should not be registered if the PM domains have not
>> been added. Nonetheless, verify that the PM domain(s) associated with a
>> provider are present when registering the PM domain provider.
>>
>> This change adds a dependency on the function pm_genpd_present() when
>> CONFIG_PM_GENERIC_DOMAINS_OF is enabled and so ensure this function is
>> available when CONFIG_PM_GENERIC_DOMAINS_OF selected.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index d09e45145a3d..50223ae0c9a7 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -586,7 +586,7 @@ static int __init genpd_poweroff_unused(void)
>>  }
>>  late_initcall(genpd_poweroff_unused);
>>
>> -#ifdef CONFIG_PM_SLEEP
>> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
>>
>>  /**
>>   * pm_genpd_present - Check if the given PM domain has been initialized.
>> @@ -606,6 +606,10 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
>>         return false;
>>  }
>>
>> +#endif
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +
>>  static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
>>                                     struct device *dev)
>>  {
>> @@ -1453,7 +1457,23 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>>  int of_genpd_add_provider_simple(struct device_node *np,
>>                                  struct generic_pm_domain *genpd)
>>  {
>> -       return genpd_add_provider(np, genpd_xlate_simple, genpd);
>> +       int ret;
>> +
>> +       if (!np || !genpd)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&gpd_list_lock);
>> +
>> +       if (!pm_genpd_present(genpd)) {
>> +               mutex_unlock(&gpd_list_lock);
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
> 
> You could simplify this, by assigning ret and initial value of
> -EINVAL, then do like this:
> 
> if (pm_genpd_present(genpd))
>     ret = genpd_add_provider(np, genpd_xlate_simple, genpd);

Yes good idea. Will do.

Thanks
Jon

-- 
nvpublic
