From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 14 Dec 2015 10:49:07 +0100
Subject: [PATCH v2 1/5] power: domain: add pm_genpd_exit
In-Reply-To: <20151209104752.GB1036@omega>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-2-git-send-email-eric@anholt.net>
 <5665599A.4060509@nvidia.com> <7h8u54lqbv.fsf@deeprootsystems.com>
 <20151209104752.GB1036@omega>
Message-ID: <CAPDyKFpSu=vik3kDn9zrv7dkg5n+Dqe+xs4FZnB8nhTA=ahaAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Russell

[...]

>> >> +void pm_genpd_exit(struct generic_pm_domain *genpd)
>> >> +{
>> >> +  if (IS_ERR_OR_NULL(genpd))
>> >> +          return;
>> >> +
>> >> +  /* check if domain is still in registered inside the pm subsystem */
>> >> +  WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
>> >> +               !list_empty(&genpd->slave_links) ||
>> >> +               !list_empty(&genpd->dev_list));
>> >> +
>> >
>> > Why not return an error here? Seems bad to remove it, if it could still
>> > be referenced by other domains.
>>
>> I had pointed this out as well in an earlier review.
>>
>
> I talked with Ulf Hansson about such handling and there exists currently
> no handling to remove the pm_genpd on error handling (what our use case
> is for RPi domains).
>
> The real solution would be a "pm_genpd_exit_recursive" functionality to
> remove subdomains, etc -> simple everything. Anway I am not a expert into
> power domain functionality and this simple approach was enough to him to
> add "something" which we have actually a lack of support.
>
>

[...]

Just to be clear on my view. I think Russell made a good summary of
how we should implement this API [1].
We should return an error, instead of WARN_ON_ONCE and continue.

Perhaps you can do both a WARN *and* return an error.

Regarding the similar patch from Jon Hunter, I would suggest we focus
on Alexander's $subject patch and try to it queued for 4.5. Please
send a new version.

Also, as other SoC genpd driver isn't using a "pm_genpd_exit()" API,
it shouldn't prevent neither Alexander/Eric or Jon from proceeding
with the RPI/Tegra genpd drivers. Once the new API is in place you can
update these drivers to properly deal with error handling and undo
things from pm_genpd_init().

Kind regards
Uffe

[1]
https://lkml.org/lkml/2015/12/9/308
