From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Dec 2013 13:17:27 +0200
Subject: [PATCHv11 06/49] clk: add support for low level register ops
In-Reply-To: <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-7-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com>
Message-ID: <52B42747.8090408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 01:00 PM, Paul Walmsley wrote:
> On Thu, 19 Dec 2013, Tero Kristo wrote:
>
>> Low level register ops are needed for providing SoC or IP block specific
>> access routines to clock registers. Subsequent patches add support for
>> the low level ops for the individual clock drivers.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> ...
>
>> ---
>>   drivers/clk/clk.c            |   28 ++++++++++++++++++++++++++++
>>   include/linux/clk-provider.h |   13 +++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 29281f6..23a742b 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -34,6 +34,34 @@ static HLIST_HEAD(clk_root_list);
>>   static HLIST_HEAD(clk_orphan_list);
>>   static LIST_HEAD(clk_notifier_list);
>>
>> +/**
>> + * clk_readl_default - default clock register read support function
>> + * @reg: register to read
>> + *
>> + * Default implementation for reading a clock register.
>> + */
>> +static u32 clk_readl_default(u32 __iomem *reg)
>
> Why u32 __iomem rather than void *?  Not that this will affect OMAP, but
> will this need to be changed later to support 64-bit addresses?
> __raw_writel() and __raw_readl() are defined with "void __iomem *" as
> their address argument, which will be 64 bits on arm64, correct?

Just copy pasting the current implementation from the clk-provider.h file.

However, pointer is pointer no? This is just used to refer to a 32bit 
value, the pointer itself can be either 32bit or 64bit. If the registers 
are changed to be 64 bit though.... but that will require changing most 
of the clock code as it is littered with 'u32 val;' type declarations.

Anyway, I can change this to be void __iomem.

>
>> +{
>> +	return readl(reg);
>> +}
>> +
>> +/**
>> + * clk_writel_default - default clock register write support function
>> + * @val: value to write
>> + * @reg: register to write to
>> + *
>> + * Default implementation for writing a clock register.
>> + */
>> +static void clk_writel_default(u32 val, u32 __iomem *reg)
>
> Same question as the above.
>
>> +{
>> +	writel(val, reg);
>> +}
>> +
>> +struct clk_ll_ops clk_ll_ops_default = {
>> +	.clk_readl = clk_readl_default,
>> +	.clk_writel = clk_writel_default
>> +};
>> +
>>   /***           locking             ***/
>>   static void clk_prepare_lock(void)
>>   {
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 27a9765..cc5bee0 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -199,6 +199,24 @@ struct clk_hw {
>>   	const struct clk_init_data *init;
>>   };
>>
>> +/**
>> + * struct clk_ll_ops - low-level register access ops for a clock
>> + *
>> + * @clk_readl: pointer to register read function
>
> Please remove the blank line above as mentioned before.

Yea I just copy pasted the comment sections....

>
>> + * @clk_writel: pointer to register write function
>> + *
>> + * Low-level register access ops are generally used by the basic clock types
>> + * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
>> + * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
>> + * used by other hardware-specific clock drivers if needed.
>> + */
>> +struct clk_ll_ops {
>> +	u32	(*clk_readl)(u32 __iomem *reg);
>> +	void	(*clk_writel)(u32 val, u32 __iomem *reg);
>> +};
>> +
>> +extern struct clk_ll_ops clk_ll_ops_default;
>> +
>>   /*
>>    * DOC: Basic clock implementations common to many platforms
>>    *
>> --
>> 1.7.9.5
>>
>
>
> - Paul
>
