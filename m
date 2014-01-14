From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 13 Jan 2014 19:54:42 -0800
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <20140109015158.7168.60274@quantum>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
 <20140109015158.7168.60274@quantum>
Message-ID: <52D4B502.3080409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2014 05:51 PM, Mike Turquette wrote:
> Quoting Stephen Boyd (2013-12-23 17:12:26)
>> Add support to the clock core so that drivers can pass in a
>> regmap. If no regmap is specified try to query the device that's
>> registering the clock for its regmap. This should allow drivers
>> to use the core regmap helpers. This is based on a similar design
>> in the regulator framework.
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>   drivers/clk/clk.c            | 8 ++++++++
>>   include/linux/clk-provider.h | 7 +++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 9ad7b71..5e71f5c 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/device.h>
>>   #include <linux/init.h>
>>   #include <linux/sched.h>
>> +#include <linux/regmap.h>
>>
>>   static DEFINE_SPINLOCK(enable_lock);
>>   static DEFINE_MUTEX(prepare_lock);
>> @@ -1834,6 +1835,13 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
>>          clk->num_parents = hw->init->num_parents;
>>          hw->clk = clk;
>>
>> +       if (hw->init->regmap)
>> +               hw->regmap = hw->init->regmap;
>
> Hi Stephen,
>
> The whole series looks good to me except for the placement of the regmap
> details inside struct clk_hw. That structure exists only to hide struct
> clk from the hardware-specific clock structure and I'd not like to set
> the precedent of shoving per-clock data into it.
>
> As an alternative, how about finding a way to put these per-clock regmap
> details into the hardware-specific clock structure? I understand that
> you want to make these ops available to others, which is why they are in
> the public struct clk_hw. I'm just wondering if that is the right way to
> do it...
>
> Patch #3 illustrates the sort of struct-member-creep that worries me.
> What is to stop someone from putting "unsigned int divider_reg" or
> "unsigned int mux_reg", and then the thing just keeps growing.

I agree with Mike here. This definitely encourages struct field creep if 
more people want to use it.

I talked to Stephen is person and my recommendation is to not have any 
new fields other than struct regmap in clk_hw and remove the above 2 
lines of code.

>> +       else if (dev && dev_get_regmap(dev, NULL))
>> +               hw->regmap = dev_get_regmap(dev, NULL);

Move "struct regmap *regmap" into struct clk_hw (since it's truly 
reusable across clock types and is technically purely HW related) and 
update it from the device's regmap like above.

We can then provide __clk_regmap_enable(regmap, offset, enable_mask) 
helper functions. Then clock specific functions can use the helper. We 
can even a simple macro to generate these wrappers.

#define DEFINE_REGMAP_EN_DIS(clktype) \

int clk_type##_enable(clktype *c, ....) { }
int clk_type##_disable(clktype *c, ....) { }


That to me seems like a reasonable compromise.

Thanks,
Saravana
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
