From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 09:46:06 -0500
Subject: [PATCHv4 21/33] CLK: OMAP: DPLL: add omap3 dpll support
In-Reply-To: <51F92758.20405@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-22-git-send-email-t-kristo@ti.com>
 <51F81D3A.7080007@ti.com> <51F92758.20405@ti.com>
Message-ID: <51FA74AE.8050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 10:03 AM, Tero Kristo wrote:
> On 07/30/2013 11:08 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
[...]

>>
>>>           pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
>>>               clk_name);
>>>           goto cleanup;
>>> @@ -225,14 +259,31 @@ static void __init of_omap_dpll_setup(struct
>>> device_node *node,
>>>       dd->enable_mask = enable_mask;
>>>       dd->autoidle_mask = autoidle_mask;
>>>
>>> -    dd->modes = 0xa0;
>>> +    if (!of_property_read_u32(node, "ti,recal-en-bit", &val))
>>> +        dd->recal_en_bit = val;
>>> +
>>> +    if (!of_property_read_u32(node, "ti,recal-st-bit", &val))
>>> +        dd->recal_st_bit = val;
>>> +
>>> +    if (!of_property_read_u32(node, "ti,auto-recal-bit", &val))
>>> +        dd->auto_recal_bit = val;
>>
>> now I understand what it means.
>
> I am not quite sure you do, as I don't quite get your comment here. :)
> You referring to that dd->modes part?

yep.

>
>>
>>> +
>>> +    of_property_read_u32(node, "ti,modes", &modes);
>> i see we pass in modes, and read ti,modes to &modes. it is a bit sketchy
>> without bindings documentation.
>
> ti,modes can be used to override the default modes.

I get it, but prefer seeing it in Documentation/devicetree/bindings/... 
So that you would not have to repeat it anymore :D

>
>>
>>> +
>>> +    dd->modes = modes;
>>
>> Should have belonged to original patch.
>
> If I squash this then we are fine.

yes, thanks.

>>>
>>> -    of_omap_dpll_setup(node, ops);
>>> +    of_omap_dpll_setup(node, ops, 0, 0xa0, 0, SUBTYPE_OMAP4_DPLL);
>> what is 0xa0?
>
> Magic modes for DPLL. I'll copy over the macro def as mentioned in one
> of the previous patches.

yes, please..

>
>>
>>>   }
>>>   EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>>>   CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock",
>>> of_omap4_dpll_setup);
>>>
>>
>> I think this should be squashed and a single dpll.c introduction to be
>> done.
>
> Ok.

thanks.

-- 
Regards,
Nishanth Menon
