From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 14 Mar 2017 09:21:35 +0100
Subject: [PATCH] ARM: at91: pm: cpu_idle: switch DDR to power-down mode
In-Reply-To: <20170313210742.r7jdbuyp72ma76vl@piout.net>
References: <20170313171450.18681-1-nicolas.ferre@microchip.com>
 <20170313210742.r7jdbuyp72ma76vl@piout.net>
Message-ID: <c4762297-e2ef-e6cd-536d-536dc27ab4e6@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/03/2017 ? 22:07, Alexandre Belloni a ?crit :
> On 13/03/2017 at 18:14:50 +0100, Nicolas Ferre wrote:
>> On some DDR controllers, compatible with the sama5d3 one,
>> the sequence to enter/exit/re-enter the self-refresh mode adds
>> more constrains than what is currently written in the at91_idle
>> driver. An actual access to the DDR chip is needed between exit
>> and re-enter of this mode which is somehow difficult to implement.
>> This sequence can completely hang the SoC. It is particularly
>> experienced on parts which embed a L2 cache if the code run
>> between IDLE calls fits in it...
>>
>> Moreover, as the intention is to enter and exit pretty rapidly
>> from IDLE, the power-down mode is a good candidate.
>>
>> So now we use power-down instead of self-refresh. As we can
>> simplify the funciton for sama5d3 compatible DDR controllers,
>               typo ^
> 
>> we instanciate a new sama5d3_ddr_standby() function.

And here ^ also: I rewrite a v2 now.


>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>>  arch/arm/mach-at91/pm.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index 3d89b7905bd9..63e7df8ec815 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -289,6 +289,23 @@ static void at91_ddr_standby(void)
>>  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
>>  }
>>  
>> +static void sama5d3_ddr_standby(void)
>> +{
>> +	u32 lpr0;
>> +	u32 saved_lpr0;
>> +
>> +	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
>> +	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
>> +	lpr0 |= AT91_DDRSDRC_LPCB_POWER_DOWN;
>> +
>> +	/* self-refresh mode now */
> 
> So this is not self refresh anymore

True, and useless comment in this case: so I simply remove it!
Sorry for the noise.

Regards,
-- 
Nicolas Ferre
