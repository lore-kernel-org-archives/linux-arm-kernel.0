From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 3 Oct 2014 12:36:43 +0200
Subject: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore()
 API
In-Reply-To: <542D7525.8000804@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
 <542C2D9F.8060005@samsung.com>
 <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
 <542D3E45.5020908@samsung.com>
 <CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
 <542D7525.8000804@samsung.com>
Message-ID: <CAPDyKFqi=eKYBXSuRPzTZ0vybRfV6oMNt-_vCqT-6+otGiMucQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2014 17:54, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> On 02/10/14 15:30, Ulf Hansson wrote:
> [...]
>> Correct me if I am wrong, but I think in principle these exynos
>> drivers don't use pm_runtime_set_active() during ->probe() and are
>> instead relying on CONFIG_PM_RUNTIME to be enabled.
>
> Yes, pm_runtime_set_active() is not used in probe(), I believe this
> is not required. In case of those IP blocks there is no use of activating
> them during probe(). Instead we check if PM_RUNTIME is enabled through
> pm_runtime_enabled() helper and enable the device clock(s) if not.
> I agree it all doesn't quite work in current mainline for !PM_RUNTIME,
> since there is nothing ensuring that the power domains are enabled
> in such kernel configuration.
>
>> That's not a good behaviour. If these drivers are build without
>> CONFIG_PM_RUNTIME - they won't work.
>
> They wouldn't similarly work with pm_runtime_set_active() call in probe()
> with CONFIG_PM_RUNTIME disabled, would they ?

Yes they would, although they require some minor additional adaptations.

Those resources that are enabled from the driver's runtime PM resume
callback, should also be enabled during ->probe(). The
pm_runtime_set_active() will then update the state to reflect this.

Then, if CONFIG_PM_RUNTIME is enabled - the device will be scheduled
to go inactive from driver core (pm_request_idle()), after ->probe()
has completed. Thus saving power if it's unused.
If CONFIG_PM_RUNTIME isn't enabled - the driver will still be
functional, since all resources are enabled during ->probe().

Kind regards
Uffe
