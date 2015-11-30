From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 30 Nov 2015 20:27:33 +0200
Subject: [PATCH] ARM: OMAP4: execute initcall to reserve SRAM for I688
 only on OMAP4
In-Reply-To: <1448904431.8275.36.camel@pengutronix.de>
References: <1447673117-32719-1-git-send-email-l.stach@pengutronix.de>
 <5649CB16.2030706@ti.com> <1448904431.8275.36.camel@pengutronix.de>
Message-ID: <565C9515.1040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 07:27 PM, Lucas Stach wrote:
> Am Montag, den 16.11.2015, 14:24 +0200 schrieb Grygorii Strashko:
>> On 11/16/2015 01:25 PM, Lucas Stach wrote:
>>> omap_interconnect_sync() is the only user of the SRAM scratch area
>>> allocated in the omap4_sram_init initcall. The interconnect sync is
>>> used exclusively in the OMAP4 specific WFI implementation, so there
>>> is no point in allocating the SRAM scratch on other SoC types.
>>>
>>> Bail out of the initcall if the kernel is not running on OMAP4 to
>>> avoid a confusing warning about being unable to allocate the SRAM
>>> needed for I688 handling.
>>>
>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>> Tested-by: Bastian Stender <bst@pengutronix.de>
>>> ---
>>>    arch/arm/mach-omap2/omap4-common.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>>> index 949696b6f17b..6db393a30a28 100644
>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>> @@ -131,6 +131,9 @@ static int __init omap4_sram_init(void)
>>>    	struct device_node *np;
>>>    	struct gen_pool *sram_pool;
>>>    
>>> +	if (!cpu_is_omap44xx())
>>> +		return 0;
>>
>> This one affects on am43xx also
>>
> So you are saying this erratum is also present on AM43xx? I wasn't able
> to deduce this from the information provided by Richard Woodruff.
> 

"..SOCs using similar chassis components of OMAP4430 time are impacted..."
"..But AM335x should be immune from this particular issue..."

Advisory 11 Asynchronous Bridge Corruption
http://www.ti.com/lit/er/sprz408b/sprz408b.pdf



>>
>>> +
>>>    	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
>>>    	if (!np)
>>>    		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
>>
>> Since all OMAP4+ platforms are now DT based why can't we just return from here silently?
>>
> If we are unable to allocate the SRAM needed to work around I688 this is
> a real error on platforms that expose this erratum, so silently bailing
> out at this point may obscure a real issue.
> 

SRAM is not allocated here - It's just check to understand do we need it or not
in case of multiplatform build where CONFIG_OMAP_INTERCONNECT_BARRIER will be selected most
probably.

And if "ti,omap4-mpu" was not found - it just means that this, particular, platform
is not affected by i688 errata.
If someone misses corresponding node in DT - we can't do nothing :)

-- 
regards,
-grygorii
