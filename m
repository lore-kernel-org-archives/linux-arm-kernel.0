From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 08 Apr 2013 01:49:24 +0200
Subject: [v5] clk: add si5351 i2c common clock driver
In-Reply-To: <20130407225046.GA16326@roeck-us.net>
References: <1365139415-17815-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130407225046.GA16326@roeck-us.net>
Message-ID: <51620604.4070204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 12:50 AM, Guenter Roeck wrote:
> On Fri, Apr 05, 2013 at 05:23:35AM -0000, Sebastian Hesselbarth wrote:
>> This patch adds a common clock driver for Silicon Labs Si5351a/b/c
>> i2c programmable clock generators. Currently, the driver supports
>> DT kernels only and VXCO feature of si5351b is not implemented. DT
>> bindings selectively allow to overwrite stored Si5351 configuration
>> which is very helpful for clock generators with empty eeprom
>> configuration. Corresponding device tree binding documentation is
>> also added.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>> Tested-by: Daniel Mack<zonque@gmail.com>
>>
> [ ... ]
>
>> +static inline void _si5351_msynth_set_pll_master(
>> +	struct si5351_driver_data *drvdata, unsigned char num, int is_master)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (num>  8 ||
>> +	    (drvdata->variant == SI5351_VARIANT_A3&&  num>  3))
>> +		return;
>> +
>> +	flags = __clk_get_flags(drvdata->msynth[num].hw.clk);
>> +	if (is_master)
>> +		flags |= CLK_SET_RATE_PARENT;
>> +	else
>> +		flags&= ~CLK_SET_RATE_PARENT;
>> +	__clk_set_flags(drvdata->msynth[num].hw.clk, flags);
>> +}
>> +
> Unless I am missing something, neither __clk_get_flags() nor the new
> __clk_set_flags is exported.
>
> Did you try to build and load the driver as module ?

Well, good catch. I didn't try to build v5 as a module, but I guess it
will fail. But I consider this as something that has to be addressed in
clk framework itself, not in this patch. There will be other
clk-providers built as module in the future for sure.

Sebastian
