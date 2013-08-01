From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 09:11:40 -0500
Subject: [PATCHv4 06/33] CLK: omap: add autoidle support
In-Reply-To: <51F8E365.8080604@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-7-git-send-email-t-kristo@ti.com> <51F80C77.9020109@ti.com>
 <51F8E365.8080604@ti.com>
Message-ID: <51FA6C9C.7030800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 05:13 AM, Tero Kristo wrote:
> On 07/30/2013 09:56 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>>> OMAP clk driver now routes some of the basic clocks through own
>>> registration routine to allow autoidle support. This routine just
>>> checks a couple of device node properties and adds autoidle support
>>> if required, and just passes the registration forward to basic clocks.
>>
>> why not extend standard framework to support autoidle capable clocks OR
>> introduce our own clk node which depends on basic clocks?
>
> Was kind of easier this way.

We never liked taking the easy road :) if we can extend standard 
drivers, that will be the first preference - else we will need to 
explain precisely why it cant be extended.

>>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>>> index 0c38ca9..669d4c4 100644
>>> --- a/arch/arm/mach-omap2/clock.c
>>> +++ b/arch/arm/mach-omap2/clock.c
>> Not sure why, at this point in time we are going to calling drivers/clk
>> code.
>>
>>> @@ -520,6 +520,9 @@ int omap2_clk_enable_autoidle_all(void)
>>>       list_for_each_entry(c, &clk_hw_omap_clocks, node)
>>>           if (c->ops && c->ops->allow_idle)
>>>               c->ops->allow_idle(c);
>>> +
>>> +    of_omap_clk_allow_autoidle_all();
>>> +
>>>       return 0;
>>>   }
>>>
>>> @@ -539,6 +542,9 @@ int omap2_clk_disable_autoidle_all(void)
>>>       list_for_each_entry(c, &clk_hw_omap_clocks, node)
>>>           if (c->ops && c->ops->deny_idle)
>>>               c->ops->deny_idle(c);
>>> +
>>> +    of_omap_clk_deny_autoidle_all();
>>> +
>>
>> these are defined for CONFIG_OF.. anyways, without dt nodes (OMAP3 is
>> supposed to support non-DT boot even now), this would not work, would it?
>
> The lists are empty so the funcs do nothing. However, dropping CONFIG_OF
> would break these of course. Will figure out a fix for this.
>
> The calls are needed for the transition phase until we can move more clk
> stuff from mach-omap2 to drivers.

yes please. for ones like these, we can try to maintain a rule of 
mach-omap2 calling drivers/clk rather than drivers/clk -> mach-omap2. 
This will allow us to move out of mach-omap2 eventually by just deleting 
call points in mach-omap2.

[...]
>>>
>>>   #endif
>>>
>>
>> I personally dont prefer the fact that divider-clock and
>> fixed-rate-clock now has double meaning - building a multi-arch kernel
>> for example, this can wreak havoc. standard definitions should not be
>> monkeyed around with thus if avoidable, and in this case, very much
>> avoidable.
>>
>> just my 2 cents.
>
> Yea, as described before, I'll change the code not to make a global
> override, instead, just make omap specific override which parses the
> extra params. That sound better or still see some issues with that?

I think described above - if we can introduce these into standard 
drivers, it is the best, else introduce it with ti, prefix to indicate a 
TI variant. keeps everyone happy.


-- 
Regards,
Nishanth Menon
