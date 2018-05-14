From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 May 2018 14:22:48 +0200
Subject: [FAIL bisect] Sound card probe error
In-Reply-To: <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
Message-ID: <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:

> Bisected to:
> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Thu Apr 26 10:53:06 2018 +0200
> 
>     driver core: Respect all error codes from dev_pm_domain_attach()
> 
>     The limitation of being able to check only for -EPROBE_DEFER from
>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>     codes and bail out accordingly.
> 
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The DRM driver creates the HDMI codec but its registration fails, due
to some missing clocks. The clock are missing because the exynos5-subcmu
driver probing fails.

[    0.678578] exynos5-subcmu: probe of GSC failed with error -17
[    0.679250] exynos5-subcmu: probe of MFC failed with error -17
[    0.679992] exynos5-subcmu: probe of DISP failed with error -17

The exynos5-subcmu driver before registering platform device makes 
of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
call will fail, as dev->pm_domain is already set. Previously the error
was masked by code removed in the above commit and platform_drv_probe()
was could complete successfully.

-- 
Regards,
Sylwester
