From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 14 May 2018 14:43:09 +0200
Subject: [FAIL bisect] Sound card probe error
In-Reply-To: <CAPDyKFoQFxHqupyqH3JsriUDdJHpUDecD37OqOSKn-sT26gEiA@mail.gmail.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
 <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
 <CAPDyKFoQFxHqupyqH3JsriUDdJHpUDecD37OqOSKn-sT26gEiA@mail.gmail.com>
Message-ID: <CAJKOXPcTQX82UdcBROBc18C-M0_3bOnStLqJzUzRDqHC33m-1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 2:30 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 May 2018 at 14:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> Hi,
>>
>> On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:
>>
>>> Bisected to:
>>> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
>>> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
>>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>>> Date:   Thu Apr 26 10:53:06 2018 +0200
>>>
>>>     driver core: Respect all error codes from dev_pm_domain_attach()
>>>
>>>     The limitation of being able to check only for -EPROBE_DEFER from
>>>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>>>     codes and bail out accordingly.
>>>
>>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The DRM driver creates the HDMI codec but its registration fails, due
>> to some missing clocks. The clock are missing because the exynos5-subcmu
>> driver probing fails.
>>
>> [    0.678578] exynos5-subcmu: probe of GSC failed with error -17
>> [    0.679250] exynos5-subcmu: probe of MFC failed with error -17
>> [    0.679992] exynos5-subcmu: probe of DISP failed with error -17
>>
>> The exynos5-subcmu driver before registering platform device makes
>> of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
>> call will fail, as dev->pm_domain is already set. Previously the error
>> was masked by code removed in the above commit and platform_drv_probe()
>> was could complete successfully.
>
> Thanks for providing this information!
>
> I was about to tell that I overlooked the fact that there is more than
> one way to assign PM domain pointers to devices. To fix the problem,
> dev_pm_domain_attach() should return 0, not -EEXIST when it finds and
> existing PM domain pointer.
>
> Does the below patch fix the problem?
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Mon, 14 May 2018 14:26:16 +0200
> Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM domain
>  exists
>
> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
> to devices, clearly we must allow a device to have the pointer already
> being assigned. For this reason, return 0 instead of -EEXIST.
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Yes, this fixes the issue.
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
