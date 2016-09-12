From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 12 Sep 2016 09:21:39 +0200
Subject: [PATCH 08/10] PM / Domains: Add support for removing PM domains
In-Reply-To: <63871fe6-cda6-2a95-9c09-e4b3ebfa3419@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrVO9wb3ffmxA7HUUDt1_aYxe=aqa1v+xNpdrYiLt_m0A@mail.gmail.com>
 <c8498eca-6934-1cab-31d9-3d8ce4c74897@nvidia.com>
 <63871fe6-cda6-2a95-9c09-e4b3ebfa3419@nvidia.com>
Message-ID: <CAPDyKFp+eDBLge40uv6aDuYOkaKAksgqZekqomLZijPrhDzj6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 September 2016 at 17:17, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 09/09/16 14:54, Jon Hunter wrote:
>> On 08/09/16 12:49, Ulf Hansson wrote:
>>> On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>>>> function, however, there is no corresponding function to remove a PM
>>>> domain. For most devices this may be fine as the PM domains are never
>>>> removed, however, for devices that wish to populate the PM domains from
>>>> within a driver, having the ability to remove a PM domain if the probing
>>>> of the device fails or the driver is unloaded is necessary.
>>>>
>>>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>>>> it's generic_pm_domain structure.
>>>>
>>>> PM domains can only be removed if they are not a parent domain to
>>>> another PM domain and have no devices associated with them.
>>>
>>> I think we should also check if the there's is a provider registered
>>> for the genpd, as it should also prevent the genpd from being removed.
>>> Right?
>>
>> Yes I would agree. I had thought that after patch #4 of this series that
>> only the provider itself would be able to call this. However, we should
>> probably still verify that the provider has correctly remove itself.
>
> So now I have the following. I am still not 100% happy. I cannot clear
> the ->provider when calling of_genpd_del_provider() and so I cannot use
> this to verify if the provider is present and so I need to check the
> list of providers and it gets a bit messy. I have been wracking my
> brains to find a better alternative (including a single function to
> remove the provider and domains at once but there are issues with that
> as well).

Instead of using the ->provider pointer to know whether the genpd has
a valid provider, why not just add an additional ->has_provider bool
flag in the genpd struct?

Simply set the flag when adding the provider and reset it when
removing it. Wouldn't that work?

>
> I think that long term it may make sense to reference the providers
> exclusively by the fwnode_handle and make the list of provider non-DT
> specific. I could do it now, but it would increase the series.

Perhaps a good idea. Although I agree, let's not make that change as a
part of this series.

[...]

Kind regards
Uffe
