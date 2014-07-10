From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 10 Jul 2014 11:16:34 +0200
Subject: [RFC v2 3/5] clk: use struct clk only for external API
In-Reply-To: <53BDA21D.3070504@gmail.com>
References: <1404398323-18934-1-git-send-email-tomeu.vizoso@collabora.com>
 <1404398323-18934-4-git-send-email-tomeu.vizoso@collabora.com>
 <53BDA21D.3070504@gmail.com>
Message-ID: <53BE59F2.1090102@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 10:12 PM, Tomasz Figa wrote:
> Actually few more comments, see inline.
>
> On 03.07.2014 16:38, Tomeu Vizoso wrote:
>> From: Rabin Vincent <rabin.vincent@stericsson.com>
>>
>> In order to provide per-user accounting, this separates the struct clk
>> used in the common clock framework into two structures 'struct clk_core'
>> and 'struct clk'.  struct clk_core will be used for internal
>> manipulation and struct clk will be used in the clock API
>> implementation.
>
> [snip]
>
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
>
> This function still expects to get a (struct clk *) here, but...
>
>>   }
>>
>> -struct clk *devm_clk_get(struct device *dev, const char *id)
>> +struct clk_core *devm_clk_provider_get(struct device *dev, const char *id)
>>   {
>> -	struct clk **ptr, *clk;
>> +	struct clk_core **ptr, *clk;
>>
>>   	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
>>   	if (!ptr)
>>   		return ERR_PTR(-ENOMEM);
>>
>> -	clk = clk_get(dev, id);
>> +	clk = clk_provider_get(dev, id);
>>   	if (!IS_ERR(clk)) {
>>   		*ptr = clk;
>
> ...here a (struct clk_core *) is stored.

Thanks, well spotted.

>>   		devres_add(dev, ptr);
>
> [snip]
>
>> diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
>> index d278572..c69f4fe 100644
>> --- a/drivers/clk/clk.h
>> +++ b/drivers/clk/clk.h
>> @@ -15,3 +15,7 @@ struct clk_core *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
>>   void of_clk_lock(void);
>>   void of_clk_unlock(void);
>>   #endif
>> +
>> +#if defined(CONFIG_COMMON_CLK)
>> +#define clk_to_clk_core(clk)	(clk->core)
>
> Making this a static inline will benefit you with type checking at
> compilation time.

Good point.

>> +#endif
>
> [snip]
>
>> +
>> +#define clk_core_to_clk(core)	((struct clk *)(core))
>
> Hmm, I'm not following. clk_to_clk_core() returns clk->core, while
> clk_core_to_clk() simply casts whatever the former returns into a
> pointer to struct clk?

Yeah, this is totally wrong, v3 will be fixing this, I have tested it on 
an Odroid U2, so the most embarrassing issues have been fixed.

Thanks,

Tomeu

> Also this should be a static inline to benefit from compiler type checking.
>
> Best regards,
> Tomasz
>
