From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Sep 2011 17:32:52 +0200
Subject: [RFC PATCH 2/3] OMAP: omap_device: Add a DT parser for multiple
	strings
In-Reply-To: <87d3fkds69.fsf@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-3-git-send-email-b-cousson@ti.com>
	<87d3fkds69.fsf@ti.com>
Message-ID: <4E60F724.8060702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2011 8:38 PM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Add two helpers function to parse a property that contains multiple
>> strings.
>>
>> These functions might be exported and moved to a common place if they
>> can to be useful elsewhere.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> These should just be folded into 3/3 where they are used (with a comment
> changelog of course.)

I did that because I was hoping to generalize them or to remove them if 
something better become available in DT core. And it seems that Stephen 
Warren from nvidia introduced a generic iterator for properties:
http://www.spinics.net/lists/arm-kernel/msg138013.html

But since it is not in mainline or even in devicetree/test, I still have 
to add mine for the moment.

Regards,
Benoit


>
> Kevin
>
>> ---
>>   arch/arm/plat-omap/omap_device.c |   39 ++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> index 752d72a..70361f8 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -315,6 +315,45 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
>>   		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
>>   }
>>
>> +/*
>> + * XXX: DT helper functions that should probably move elsewhere if
>> + * they become usefull for other needs.
>> + */
>> +static int _dt_count_property_string(const char *prop, int len)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlen(prop) + 1;
>> +		if (*prop != 0)
>> +			i++;
>> +	}
>> +	return i;
>> +}
>> +
>> +static int _dt_get_property(const char *prop, int len, int index, char *output,
>> +			    int size)
>> +{
>> +	int i = 0;
>> +	size_t l = 0, total = 0;
>> +
>> +	if (!prop || !len)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; len>= total; total += l, prop += l) {
>> +		l = strlcpy(output, prop, size) + 1;
>> +		if (*prop != 0) {
>> +			if (i++ == index)
>> +				return 0;
>> +		}
>> +	}
>> +	return -ENODEV;
>> +}
>> +
>>
>>   /* Public functions for use by core code */
