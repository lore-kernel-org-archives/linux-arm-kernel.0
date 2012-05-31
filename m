From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 31 May 2012 14:50:00 +0200
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <4FC768F8.4050406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 5/31/2012 11:05 AM, Peter De Schrijver wrote:
>>
>> What if a module needs two clocks and you drive the reset on both of the
>> clocks ? What would happen ?
>>
>
> Only 'leave clocks' have this reset method and a module can only have 1 of
> them.
>
>>> but then we would have the keep a list of IDs (1 per module) which the drivers
>>> can use to call some tegra reset function which would in the end use registers
>>> in the same memory area to cause a reset. (the registers controlling
>>> modulereset are interleaved with those controlling the enable/disable of the
>>> main moduleclock and bitpositions are identical)
>>
>> Well, under a generic device-level API, you could just call an internal
>> clk_reset() function because you know which clocks feed into which
>> devices anyway. It could look something like:
>>
>> on Tegra:
>>
>> device_reset(dev)
>> 	->  dev_pm_domain->reset()
>> 		->  tegra_periph_reset()
>>
>
> These methods are also needed internally by the powergating code.
>
>> on OMAP:
>>
>> device_reset(dev)
>> 	->  dev_pm_domain->reset()
>> 		->  omap_hwmod_reset()
>>
>>
>> btw:
>>
>> tegra_periph_reset(....)
>> {
>> 	tegra_periph_reset_assert(...);
>> 	udelay(2);
>> 	tegra_periph_reset_deassert(...);
>> }
>
> which uses the clockframework currently.

Hehe, that a little bit why we had to introduce hwmod for OMAP.
A HW IP cannot just be represented by a clock node like it used to be in 
the good old time.

Now the question is should we extend the Linux device structure to 
handle such HW IP, or should we extend the clock definition to handle 
this kind of extended clock node.

It looks to me that this kind of function does belong to the device more 
than to the clock node.

FWIW, we do have as well issue managing properly the reset for OMAP IPs. 
It is done using custom OMAP hooks today and hwmod whereas it looks like 
it is really a common problem for SoC in general.

Regards,
Benoit
