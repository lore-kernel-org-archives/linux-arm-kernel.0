From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 13 May 2014 17:11:55 +0200
Subject: [PATCH 1/2] clk: of: helper for determining flags properties
In-Reply-To: <20140513122054.GA2419@e106331-lin.cambridge.arm.com>
References: <1399982253-21079-1-git-send-email-gabriel.fernandez@linaro.org>
 <1399982253-21079-2-git-send-email-gabriel.fernandez@linaro.org>
 <20140513122054.GA2419@e106331-lin.cambridge.arm.com>
Message-ID: <5372363B.4080608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 02:20 PM, Mark Rutland wrote:
> On Tue, May 13, 2014 at 12:57:32PM +0100, Gabriel FERNANDEZ wrote:
>> The patch provides a helper to get flags properties of
>> a clock node.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>   drivers/clk/clk.c            | 11 +++++++++++
>>   include/linux/clk-provider.h |  6 ++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 4d56220..cae8985 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2528,6 +2528,17 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
>>   }
>>   EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
>>
>> +unsigned long of_clk_get_flags(struct device_node *np)
>> +{
>> +	unsigned long flags = 0;
>> +
>> +	if (of_property_read_bool(np, "set-rate-parent"))
>> +		flags |= CLK_SET_RATE_PARENT;
>
> NAK.
>
> This is _not_ a hardware property. This flag describes internals of the
> Linux clock framework, and is thus not suitable for DT.

Mark,

while I agree above property is not a hardware property, it is at least
some kind of use-case property. If not by DT, we will have to allow some
way to describe master-slave relationships between clocks in a driver
independent way.

> You've also failed to document the property.
>
> What are you trying to achieve here, and why do you think this is the
> best way of achieving that?

I cannot tell from the commit msgs, but consider clk-si5351 which is a
driver for an external programmable clock with N PLLs and M outputs. Now
connect a video clock consumer and an audio clock consumer to two
different outputs and those to one PLL (as you want audio clock derived
from video clock, typical HDMI scenario).

Now, there should be a way to tell the generic driver which outputs are
allowed to change the PLLs rate and which don't. Otherwise, the clock
chip would be pretty useless as e.g. your audio clock consumer will
overwrite the rate the video clock consumer has chosen.

BTW, clk-si5351 has vendor-specific properties to specify which output
clocks are pll-masters for some kernel cycles already.

Sebastian

>> +
>> +	return flags;
>> +}
>> +EXPORT_SYMBOL_GPL(of_clk_get_flags);
>> +
>>   struct clock_provider {
>>   	of_clk_init_cb_t clk_init_cb;
>>   	struct device_node *np;
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 59e2eb5..650bc10 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -519,6 +519,7 @@ int of_clk_get_parent_count(struct device_node *np);
>>   const char *of_clk_get_parent_name(struct device_node *np, int index);
>>
>>   void of_clk_init(const struct of_device_id *matches);
>> +unsigned long of_clk_get_flags(struct device_node *np);
>>
>>   #else /* !CONFIG_OF */
>>
>> @@ -546,6 +547,11 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
>>   {
>>   	return NULL;
>>   }
>> +static inline unsigned long of_clk_get_flags(struct device_node *np)
>> +{
>> +	return NULL;
>> +}
>> +
>>   #define of_clk_init(matches) \
>>   	{ while (0); }
>>   #endif /* CONFIG_OF */
>> --
>> 1.9.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
