From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 21 Jun 2017 11:41:17 +0530
Subject: [PATCH 3/5] clk: qcom: gdsc: Add support to control associated
 clks
In-Reply-To: <95d69901-fad5-9a2d-138e-ed5eb9dbc4e2@linaro.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
 <1490076923-20194-4-git-send-email-rnayak@codeaurora.org>
 <95d69901-fad5-9a2d-138e-ed5eb9dbc4e2@linaro.org>
Message-ID: <cd47a256-ce8d-92be-b5f6-e57c0613f222@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Stan,

On 06/14/2017 05:10 PM, Stanimir Varbanov wrote:
> Hi Rajendra,
> 
> Thanks for the patches!

thanks for the review, do you plan to use this series to get rid of the mmagic
clock handling for vidc, or something else?
Is this a dependency to get your Video driver patches to work?
These patches have been on the list for a while and I had asked Stephen to leave
these out for now till we find someone using them.

I will fixup based on your review and repost in case its useful for something
else on the way upstream.

regards,
Rajendra

> 
> On 03/21/2017 08:15 AM, Rajendra Nayak wrote:
>> The devices within a gdsc power domain, quite often have additional
>> clocks to be turned on/off along with the power domain itself.
>> Add support for this by specifying a list of clk_hw pointers
>> per gdsc which would be the clocks turned on/off along with the
>> powerdomain on/off callbacks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  drivers/clk/qcom/gdsc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  drivers/clk/qcom/gdsc.h |  8 ++++++++
>>  2 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index a4f3580..e9e7442 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -12,15 +12,19 @@
>>   */
>>  
>>  #include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/kernel.h>
>>  #include <linux/ktime.h>
>> +#include <linux/pm_clock.h>
> 
> this is not needed
> 
>>  #include <linux/pm_domain.h>
>>  #include <linux/regmap.h>
>>  #include <linux/reset-controller.h>
>>  #include <linux/slab.h>
>> +#include "common.h"
>>  #include "gdsc.h"
>>  
>>  #define PWR_ON_MASK		BIT(31)
>> @@ -166,6 +170,27 @@ static inline void gdsc_assert_clamp_io(struct gdsc *sc)
>>  			   GMEM_CLAMP_IO_MASK, 1);
>>  }
>>  
>> +static int gdsc_clk_enable(struct gdsc *sc)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0; i < sc->clk_count; i++) {
>> +		ret = clk_prepare_enable(sc->clks[i]);
>> +		if (ret)
>> +			pr_err("Failed to enable clock: %s\n",
>> +			       __clk_get_name(sc->clks[i]));
> 		
> I think the error message can be removed. And the already enabled clocks
> should be disabled on error.
> 
>> +	}
>> +	return ret;
>> +}
>> +
>> +static void gdsc_clk_disable(struct gdsc *sc)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < sc->clk_count; i++)
>> +		clk_disable_unprepare(sc->clks[i]);
>> +}
>> +
>>  static int gdsc_enable(struct generic_pm_domain *domain)
>>  {
>>  	struct gdsc *sc = domain_to_gdsc(domain);
>> @@ -193,6 +218,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>>  	 */
>>  	udelay(1);
>>  
>> +	if (sc->clk_count)
>> +		gdsc_clk_enable(sc);
> 
> could you add error handling.
> 
>> +
>>  	/* Turn on HW trigger mode if supported */
>>  	if (sc->flags & HW_CTRL) {
>>  		ret = gdsc_hwctrl(sc, true);
>> @@ -241,6 +269,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>  			return ret;
>>  	}
>>  
>> +	if (sc->clk_count)
>> +		gdsc_clk_disable(sc);
> 
> IMO sc->clk_count check could be moved in gdsc_clk_disable. This is also
> valid for all clk_count checks.
> 
>> +
>>  	if (sc->pwrsts & PWRSTS_OFF)
>>  		gdsc_clear_mem_on(sc);
>>  
>> @@ -254,7 +285,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>  	return 0;
>>  }
>>  
>> -static int gdsc_init(struct gdsc *sc)
>> +static int gdsc_init(struct device *dev, struct gdsc *sc)
>>  {
>>  	u32 mask, val;
>>  	int on, ret;
>> @@ -284,6 +315,19 @@ static int gdsc_init(struct gdsc *sc)
>>  	if (on < 0)
>>  		return on;
>>  
>> +	if (sc->clk_count) {
>> +		int i;
>> +
>> +		sc->clks = devm_kcalloc(dev, sc->clk_count, sizeof(*sc->clks),
>> +					GFP_KERNEL);
>> +		if (!sc->clks)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; i < sc->clk_count; i++)
>> +			sc->clks[i] = devm_clk_hw_get_clk(dev, sc->clk_hws[i],
>> +							  NULL);
> 
> error handling?
> 
> Also I think it will be more readable if you above chunk in separate
> function like gdsc_clk_get and call it unconditionally?
> 
>> +	}
>> +
> 
> <snip>
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
