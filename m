From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 1 Mar 2016 09:55:12 -0700
Subject: [RFC v2 01/12] PM / Domains: Abstract genpd locking
In-Reply-To: <20160226180844.GT28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-2-git-send-email-lina.iyer@linaro.org>
 <20160226180844.GT28849@codeaurora.org>
Message-ID: <20160301165512.GI1440@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26 2016 at 11:08 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 3ddd05d..8204615 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -40,6 +40,46 @@
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> +struct genpd_lock_fns {
>> +	void (*lock)(struct generic_pm_domain *genpd);
>> +	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
>> +	int (*lock_interruptible)(struct generic_pm_domain *genpd);
>> +	void (*unlock)(struct generic_pm_domain *genpd);
>> +};
>> +
>> +static void genpd_lock_irq(struct generic_pm_domain *genpd)
>> +{
>> +	mutex_lock(&genpd->mlock);
>> +}
>> +
>> +static void genpd_lock_irq_nested(struct generic_pm_domain *genpd,
>> +					int depth)
>> +{
>> +	mutex_lock_nested(&genpd->mlock, depth);
>> +}
>> +
>> +static int genpd_lock_interruptible_irq(struct generic_pm_domain *genpd)
>> +{
>> +	return mutex_lock_interruptible(&genpd->mlock);
>> +}
>> +
>> +static void genpd_unlock_irq(struct generic_pm_domain *genpd)
>> +{
>> +	return mutex_unlock(&genpd->mlock);
>> +}
>> +
>> +static struct genpd_lock_fns irq_lock = {
>
>Can this be const? Also, why is this called irq_lock when the
>lock functions are mutex based?
>
hmm.. well IRQs are allowed, but I guess, I should come up with a better
name.

>> +	.lock = genpd_lock_irq,
>> +	.lock_nested = genpd_lock_irq_nested,
>> +	.lock_interruptible = genpd_lock_interruptible_irq,
>> +	.unlock = genpd_unlock_irq,
>> +};
>> +
>> @@ -74,6 +75,8 @@ struct generic_pm_domain {
>>  	struct genpd_power_state *states;
>>  	unsigned int state_count; /* number of states */
>>  	unsigned int state_idx; /* state that genpd will go to when off */
>> +	struct genpd_lock_fns *lock_fns;
>
>const?
>
Sure will fix both.

Thanks,
Lina
