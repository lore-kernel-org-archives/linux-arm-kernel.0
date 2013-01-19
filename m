From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 19 Jan 2013 12:21:47 +0800
Subject: [PATCH v2 3/9] ARM: PRIMA2: initialize l2x0 according to mach
 from DT
In-Reply-To: <20130116120318.GD10218@e106331-lin.cambridge.arm.com>
References: <1358315610-25001-1-git-send-email-Barry.Song@csr.com>
 <1358315610-25001-3-git-send-email-Barry.Song@csr.com>
 <20130116120318.GD10218@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4wXRsaX99NQNYPAqAc-9TpzXNpDB0X6y9D18ka4szPMAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2013/1/16 Mark Rutland <mark.rutland@arm.com>:
> On Wed, Jan 16, 2013 at 05:53:29AM +0000, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> prima2 and marco have diffetent l2 cache configuration, so
>> we initialize l2x0 cache based on dtb given to kernel.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>  arch/arm/mach-prima2/l2x0.c |   29 ++++++++++++++++++++++++-----
>>  1 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
>> index c998377..e41ecd2 100644
>> --- a/arch/arm/mach-prima2/l2x0.c
>> +++ b/arch/arm/mach-prima2/l2x0.c
>> @@ -11,19 +11,38 @@
>>  #include <linux/of.h>
>>  #include <asm/hardware/cache-l2x0.h>
>>
>> -static struct of_device_id prima2_l2x0_ids[]  = {
>> -     { .compatible = "sirf,prima2-pl310-cache" },
>> +struct l2x0_aux
>> +{
>> +     u32 val;
>> +     u32 mask;
>> +};
>> +
>> +static struct l2x0_aux prima2_l2x0_aux __initconst = {
>> +     0x40000,
>> +     0,
>> +};
>
> That 0x40000 is a bit opaque. Now would be a good time to make it a bit more
> legible. Am I right in saying that's (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) ?
>
> It'd also be nice if you used designated initializers:
>
> static struct l2x0_aux prima2_l2x0_aux __initconst = {
>         .val    = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT),
>         .mask   = 0,
> };

good. and make prima2 have consistent style with marco.

>
>> +
>> +static struct l2x0_aux marco_l2x0_aux __initconst = {
>> +     (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
>> +             (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
>> +     L2X0_AUX_CTRL_MASK,
>> +};
>
> And here too:
>
> static struct l2x0_aux marco_l2x0_aux __initconst = {
>         .val    = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
>                         (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
>         .mask   = L2X0_AUX_CTRL_MASK,
> };
>
>> +
>> +static struct of_device_id sirf_l2x0_ids[] __initconst = {
>> +     { .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
>> +     { .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
>>       {},
>>  };
>
> I took a look at of_match_node, and it seems that the first match found in an
> of_match_table will be returned first, rather than finding the match earliest
> in a device node's compatible list. This is somewhat counter-intuitive.
>
> Therefore, the marco variant should be listed first, or it will get initialised
> with the prima2 configuration values.

sorry. i don't get it.  do you mean .data(prima2_l2x0_aux) will be
returned for marco?

here l2 node in matco.dts  without "sirf,prima2-pl310-cache"  will
only have "sirf,marco-pl310-cache" and l2 node in prima2.dts without
"sirf,marco-pl310-cache" will only have "sirf,prima2-pl310-cache"

>
>>
>>  static int __init sirfsoc_l2x0_init(void)
>>  {
>>       struct device_node *np;
>> +     const struct l2x0_aux *aux;
>>
>> -     np = of_find_matching_node(NULL, prima2_l2x0_ids);
>> +     np = of_find_matching_node(NULL, sirf_l2x0_ids);
>>       if (np) {
>> -             pr_info("Initializing prima2 L2 cache\n");
>> -             return l2x0_of_init(0x40000, 0);
>> +             aux = of_match_node(sirf_l2x0_ids, np)->data;
>> +             return l2x0_of_init(aux->val, aux->mask);
>>       }
>>
>>       return 0;
>> --
>> 1.7.5.4
>>
>>
>
> With those changes:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.

-barry
