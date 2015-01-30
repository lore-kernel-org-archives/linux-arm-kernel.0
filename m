From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Jan 2015 14:20:48 +0300
Subject: [PATCH v5 05/13] pm: at91: move the copying the sram function
 to the sram initializationi phase
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFD3A07F@penmbx01>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
 <1422513535-23885-1-git-send-email-wenyou.yang@atmel.com>
 <54CA0739.2030101@cogentembedded.com>
 <B256D81BAE5131468A838E5D7A243641BFD3A07F@penmbx01>
Message-ID: <54CB6910.4040907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/30/2015 9:54 AM, Yang, Wenyou wrote:

> Thank you for your review and suggestion.

    Not at all.

>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
>> Sent: Thursday, January 29, 2015 6:11 PM
>> To: Yang, Wenyou; Ferre, Nicolas; linux at arm.linux.org.uk
>> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> alexandre.belloni at free-electrons.com; sylvain.rochet at finsecur.com;
>> peda at axentia.se; linux at maxim.org.za
>> Subject: Re: [PATCH v5 05/13] pm: at91: move the copying the sram function to
>> the sram initializationi phase

>> Hello.

>> On 1/29/2015 9:38 AM, Wenyou Yang wrote:

>>> To decrease the suspend time, move the copying the sram function to
>>> the sram initialization phase, instead of every time go to suspend.

>>> In the meanwhile, if there is no sram allocated for PM, the PM is not supported.

>>> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>>    arch/arm/mach-at91/pm.c |   12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)

>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
>>> daa998d..6df0152 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -163,10 +163,6 @@ static int at91_pm_enter(suspend_state_t state)
>>>    			 * turning off the main oscillator; reverse on wakeup.
>>>    			 */
>>>    			if (slow_clock) {
>>> -#ifdef CONFIG_AT91_SLOW_CLOCK
>>> -				/* copy slow_clock handler to SRAM, and call it */
>>> -				memcpy(slow_clock, at91_slow_clock,
>>> at91_slow_clock_sz);
>>> -#endif
>>>    				slow_clock(at91_pmc_base, at91_ramc_base[0],
>>>    					   at91_ramc_base[1],
>>>    					   at91_pm_data.memctrl);
>>> @@ -311,6 +307,9 @@ static void __init at91_pm_sram_init(void)
>>>    	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
>>>    	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz,
>>> false);
>>>
>>> +	/* Copy the slow_clock handler to SRAM */
>>> +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);

>>      AFAIU (looking at the code above and below), __arm_ioremap_exec() can return
>> NULL and in this case memcpy() will cause kernel oops.

> Will add a condition before copying
> 	if (sram_pbase)

    I rather meant *if* (slow_clock).

[...]

> Best Regards,
> Wenyou Yang

WBR, Sergei
