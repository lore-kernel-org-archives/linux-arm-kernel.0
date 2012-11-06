From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 6 Nov 2012 14:59:45 +0530
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC00B9B@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC00B9B@DBDE01.ent.ti.com>
Message-ID: <5098D889.60909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/5/2012 2:40 PM, Bedia, Vaibhav wrote:
> On Sun, Nov 04, 2012 at 20:54:17, Bedia, Vaibhav wrote:
>> On Sat, Nov 03, 2012 at 21:48:48, Shilimkar, Santosh wrote:
>>> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
>>>> The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
>>>> instead of ADDR_TYPE_RT to ensure the omap hwmod code
>>>> maps the memory space at init and writes to the SYSCONFIG
>>>> registers.
>>>>
>>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>> ---
>>> Sorry again similar question.
>>>
>>> Why CPGMAC0 should be mapped and sysconfig updated early ?
>>>
>>
>> Hmm I need to revisit this one. CPGMAC0 was not going to standby
>> without this. Maybe something else is wrong in the hwmod data and
>> needs fixing.
>>
> 
> Ok I checked this one. The change I made was indirectly fixing another
> issue with the AM33xx hwmod data. am33xx_cpgmac0_addr_space[] has two
> entries and the SYSC register is part of the second entry. The function
> _find_mpu_rt_addr_space in omap_hwmod.c looks for the first entry with
> the flag ADDR_TYPE_RT flag. The change I made indirectly made the second
> entry in am33xx_cpgmac0_addr_space[] become the first memory space with
> the ADDR_TYPE_RT flag. Due to this the hwmod code wrote to the correct
> SYSC address of CPGMAC0 and the IP went to standby during bootup. 
> After changing the order of the entries in am33xx_cpgmac0_addr_space[]
> things work fine.
> 

Good catch.

Just a side note on this, driver expects the addresses in this order
only, first SS and then WR.

Thanks,
Vaibhav
> I'll make the changes in the next version.
> 
> Regards,
> Vaibhav
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
