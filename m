From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 10 Jul 2014 11:13:54 +0200
Subject: [RFC v2 3/5] clk: use struct clk only for external API
In-Reply-To: <53BD97A0.2090909@gmail.com>
References: <1404398323-18934-1-git-send-email-tomeu.vizoso@collabora.com>
 <1404398323-18934-4-git-send-email-tomeu.vizoso@collabora.com>
 <53BD97A0.2090909@gmail.com>
Message-ID: <53BE5952.7040608@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 09:27 PM, Tomasz Figa wrote:
> Hi Tomeu, Rabin,
>
> Please see my comments inline.
>
> On 03.07.2014 16:38, Tomeu Vizoso wrote:
>> From: Rabin Vincent <rabin.vincent@stericsson.com>
>>
>> In order to provide per-user accounting, this separates the struct clk
>> used in the common clock framework into two structures 'struct clk_core'
>> and 'struct clk'.  struct clk_core will be used for internal
>> manipulation and struct clk will be used in the clock API
>> implementation.
>>
>> In this patch, struct clk is simply renamed to struct clk_core and a new
>> struct clk is implemented which simply wraps it.  In the next patch, the
>> new struct clk will be used to implement per-user clock enable
>> accounting.
>>
>
> Hmm, shouldn't have Rabin signed off this patch as well?

Probably, but I have changed his patches substantially and I'm not 
really working with him on this (though I appreciate his involvement in 
the discussion). I'm going to put myself as Author: in the next version, 
and just mention that I based it off his previous work.

>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>   drivers/clk/clk-devres.c     |  13 +-
>>   drivers/clk/clk.c            | 539 ++++++++++++++++++++++++-------------------
>>   drivers/clk/clk.h            |   4 +
>>   drivers/clk/clkdev.c         |  90 +++++---
>>   include/linux/clk-private.h  |  38 +--
>>   include/linux/clk-provider.h | 127 +++++-----
>>   include/linux/clk.h          |  21 +-
>>   include/linux/clkdev.h       |  24 +-
>>   8 files changed, 494 insertions(+), 362 deletions(-)
>>
>> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
>> index 8f57154..5f2aba9 100644
>> --- a/drivers/clk/clk-devres.c
>> +++ b/drivers/clk/clk-devres.c
>> @@ -5,6 +5,7 @@
>>    */
>>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/device.h>
>>   #include <linux/export.h>
>>   #include <linux/gfp.h>
>> @@ -14,15 +15,15 @@ static void devm_clk_release(struct device *dev, void *res)
>>   	clk_put(*(struct clk **)res);
>>   }
>>
>> -struct clk *devm_clk_get(struct device *dev, const char *id)
>> +struct clk_core *devm_clk_provider_get(struct device *dev, const char *id)
>
> nit: I'm not sure if name of the internal struct has been discussed
> already, but clk_core sounds a bit off to me. Maybe it's just me but it
> looks like a big common structure of the whole clock core not some small
> per-clock structure.
>
> As for suggestions of alternative names that come to my mind:
> clk_object, clk_data, clk_entity.

Yeah, I'm not completely happy myself with clk_core or with either of 
those. But I like that the new API is prefixed with clk_provider_ as it 
clearly indicates that it's to be used by providers and not by 
consumers. Unfortunately, struct clk_provider would be misleading, so 
I'm not really sure of what would be a good name for struct clk_core.

Probably the least bad suggestion I have heard of is to have struct 
clk_internal and clk_internal_get_rate, instead of struct clk_core and 
clk_provider_get_rate.

Wonder if there are more opinions on this.

Thanks,

Tomeu

>>   {
>> -	struct clk **ptr, *clk;
>> +	struct clk_core **ptr, *clk;
>>
>>   	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
>>   	if (!ptr)
>>   		return ERR_PTR(-ENOMEM);
>
> [snip]
>
>>
>> +/*
>> + * To avoid a mass-rename of all non-common clock implementations (spread out
>> + * in arch-specific code), we let them use struct clk for both the internal and
>> + * external view.
>> + */
>> +#ifdef CONFIG_COMMON_CLK
>> +#define clk_core_t struct clk_core
>> +#else
>> +#define clk_core_t struct clk
>> +#endif
>
> Hmm. I have bad feelings about this making some typedef lovers overuse
> this macro to save few characters by not typing "struct" in code that
> doesn't have to use this macro. But clearly I can't think of any better
> solution right now, so don't consider this a showstopper.
>
> Otherwise looks good to me.
>
> Best regards,
> Tomasz
>
