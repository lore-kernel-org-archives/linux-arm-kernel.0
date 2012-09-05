From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 05 Sep 2012 16:12:32 +0300
Subject: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
In-Reply-To: <20120831235212.GS1303@atomide.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005230.28732.1131.stgit@muffinssi.local>
 <20120831235212.GS1303@atomide.com>
Message-ID: <50474FC0.6010805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/01/2012 02:52 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120830 17:53]:
>> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
>> the hardcoded gpio_base with twl_gpiochip.base after it's been
>> allocated.
> ...
> 
>> --- a/include/linux/mfd/twl6040.h
>> +++ b/include/linux/mfd/twl6040.h
>> @@ -194,7 +194,6 @@ struct twl6040_vibra_data {
>>  
>>  struct twl6040_platform_data {
>>  	int audpwron_gpio;	/* audio power-on gpio */
>> -	unsigned int irq_base;
>>  
>>  	struct twl6040_codec_data *codec;
>>  	struct twl6040_vibra_data *vibra;
> 
> The platform_data irq_base is not being used it seems..

Yes, this is not in use.

> 
>> @@ -222,7 +221,6 @@ struct twl6040 {
>>  	unsigned int mclk;
>>  
>>  	unsigned int irq;
>> -	unsigned int irq_base;
>>  	u8 irq_masks_cur;
>>  	u8 irq_masks_cache;
>>  };
> 
> ..but irq_base here is still in use as that's where the value from
> irq_alloc_descs() is being stored to. So I'll drop the changes to
> struct twl6040 from this patch as otherwise twl6040 code won't compile.
> 
> Turns out I did not have twl6040 selected in any of the testconfigs
> that I ran.

I store the irq_base in a private data for the MFD driver so child drivers can
request the correct IRQ.

You can safely remove the irq_base from twl6040_platform_data struct

-- 
P?ter
