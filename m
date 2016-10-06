From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 6 Oct 2016 09:56:47 -0600
Subject: [PATCH 6/8] PM / Domains: Abstract genpd locking
In-Reply-To: <CAPDyKFrzPbr_njosTxO9y0V3KKG0stfhA3XejmQk_3RJMr3=Tg@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-7-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrzPbr_njosTxO9y0V3KKG0stfhA3XejmQk_3RJMr3=Tg@mail.gmail.com>
Message-ID: <20161006155647.GH28930@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06 2016 at 04:56 -0600, Ulf Hansson wrote:
>On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Abstract genpd lock/unlock calls, in preparation for domain specific
>> locks added in the following patches.
>>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 121 +++++++++++++++++++++++++++++---------------
>>  include/linux/pm_domain.h   |   5 +-
>>  2 files changed, 85 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 52fcdb2..82e6a33 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -39,6 +39,46 @@
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> +struct genpd_lock_fns {
>
>May I suggest you to rename the struct to "genpd_lock_ops"?
>
>I think "*_ops" is in general what we use in the kernel for callbacks
>and functions pointers like these.
>
OK.

Thanks,
Lina

>> +       void (*lock)(struct generic_pm_domain *genpd);
>> +       void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
>> +       int (*lock_interruptible)(struct generic_pm_domain *genpd);
>> +       void (*unlock)(struct generic_pm_domain *genpd);
>> +};
>> +
>
>[...]
>
>Otherwise this looks good to me!
>
>Kind regards
>Uffe
