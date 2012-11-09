From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Nov 2012 14:07:26 -0700
Subject: [PATCH 04/11] ARM: set arch_gettimeoffset directly
In-Reply-To: <509C3AE7.7030703@gmail.com>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-6-git-send-email-swarren@wwwdotorg.org>
 <509C3AE7.7030703@gmail.com>
Message-ID: <509D708E.6080703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2012 04:06 PM, Ryan Mallon wrote:
> On 09/11/12 08:01, Stephen Warren wrote:
>> remove ARM's struct sys_timer .offset function pointer, and instead
>> directly set the arch_gettimeoffset function pointer when the timer
>> driver is initialized. This requires multiplying all function results
>> by 1000, since the removed arm_gettimeoffset() did this. Also,
>> s/unsigned long/u32/ just to make the function prototypes exactly
>> match that of arch_gettimeoffset.

>> +static u32 ep93xx_gettimeoffset(void)
>> +{
>> +	int offset;
>> +
>> +	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
>> +
>> +	/* Calculate (1000000 / 983040) * offset.  */
> 
> This comment is now incorrect, it should say:
> 
> 	/* Calculate (1000000000 / 983040) * offset */
> 
> or perhaps to better explain what is being done:
> 
> 	/*
> 	 * Timer 4 is based on a 983.04 kHz reference clock,
> 	 * so dividing by 983040 gives a milli-second value.
> 	 * Refactor the calculation to avoid overflow.
> 	 */
> 
>> +	return (offset + (53 * offset / 3072)) * 1000;

Thanks. I expanded on that slightly and went for:

	/*
	 * Timer 4 is based on a 983.04 kHz reference clock,
	 * so dividing by 983040 gives the fraction of a second,
	 * so dividing by 0.983040 converts to uS.
	 * Refactor the calculation to avoid overflow.
	 * Finally, multiply by 1000 to give nS.
	 */
