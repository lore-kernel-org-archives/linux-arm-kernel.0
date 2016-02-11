From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 11 Feb 2016 09:13:38 +0000
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
 <56BB7AF4.8040708@nvidia.com>
 <CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
Message-ID: <56BC50C2.7050609@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/02/16 18:25, Ulf Hansson wrote:

[snip]

>>> Perhaps there's a way to allow the generic PM domain to control this
>>> by itself. If we for example used the struct device corresponding to
>>> the powergate driver, genpd could use it to distinguish between
>>> various instances of genpd structs..!? Maybe it would simplify the way
>>> to deal with removing domains?
>>
>> Yes, that would be ideal. However, would have require changing
>> genpd_init()? I am not sure how genpd would be able to access the device
>> struct for the powergate driver because we don't provide this via any
>> API I am aware of? And I am guessing that you don't wish to expose the
>> gpd_list to the world either.
>>
>> If there is an easy way, I am open to it, but looking at it today, I am
>> not sure I see a simple way in which we could add a new API to do this.
>> However, may be I am missing something!
> 
> If we add a new __pm_genpd_init() API, that could require a struct
> device to be provided. That API will thus invoke the existing
> pm_genpd_init() but also deal with the extra things needed here.
> 
> I would also allow such an API to return an error code.
> 
> Correspondingly, pm_genpd_remove() could be required to be provided
> with a struct device.
> 
> Existing users of pm_genpd_init() can then convert to
> __pm_genpd_init() whenever suitable.
> 
> Of course, another option is just to add new member in the genpd
> struct for the struct *device. The caller of pm_genpd_init() could
> check it, but allow it to be NULL. Although, the pm_genpd_remove() API
> would require that pointer to the struct device to be set...
> 
> What do you think?

Yes, sounds good. May be it is simpler just to add a new member and let
the platform genpd driver handle it.

I am wondering if in addition to pm_genpd_remove(), we then just have a
function called pm_genpd_remove_tail(), which allows you to pass the
struct device pointer and will remove the last pm-domain from the
gpd_list and return the genpd pointer if successful. Internally, it will
call pm_genpd_remove(). It seems to me that if there are nested
pm-domains, then we probably want to remove them starting from the tail
as opposed to the head.

How does that sound?

Cheers
Jon
