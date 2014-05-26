From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Mon, 26 May 2014 18:44:53 +0300
Subject: [PATCH] ARM: msm: Update the references to DEBUG_MSM_UARTx
In-Reply-To: <1401116287.6068.15.camel@x220>
References: <1401108595.6068.5.camel@x220>	
 <1401112733-23649-1-git-send-email-gdjakov@mm-sol.com>
 <1401116287.6068.15.camel@x220>
Message-ID: <53836175.3020303@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2014 05:58 PM, Paul Bolle wrote:
> Hi Georgi,

Hi Paul,

>
> On Mon, 2014-05-26 at 16:58 +0300, Georgi Djakov wrote:
>> The Kconfig options DEBUG_MSM_UART1, DEBUG_MSM_UART2 and DEBUG_MSM_UART3
>> are removed, but they are still referenced in arch/arm/mach-msm/io.c
>> Fix this by updating the reference to the new Kconfig option.
>>
>> Reported-by: Paul Bolle <pebolle@tiscali.nl>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>>   arch/arm/mach-msm/io.c |    6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
>> index 34e0947..b042dca 100644
>> --- a/arch/arm/mach-msm/io.c
>> +++ b/arch/arm/mach-msm/io.c
>> @@ -57,8 +57,7 @@ static struct map_desc msm_io_desc[] __initdata = {
>>   		.length =   MSM_SHARED_RAM_SIZE,
>>   		.type =     MT_DEVICE,
>>   	},
>> -#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
>> -		defined(CONFIG_DEBUG_MSM_UART3)
>> +#if defined(CONFIG_DEBUG_MSM_UART)
>>   	{
>>   		/* Must be last: virtual and pfn filled in by debug_ll_addr() */
>>   		.length = SZ_4K,
>> @@ -76,8 +75,7 @@ void __init msm_map_common_io(void)
>>   	 * pages are peripheral interface or not.
>>   	 */
>>   	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
>> -#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
>> -		defined(CONFIG_DEBUG_MSM_UART3)
>> +#if defined(CONFIG_DEBUG_MSM_UART)
>>   #ifdef CONFIG_MMU
>>   	debug_ll_addr(&msm_io_desc[size - 1].pfn,
>>   		      &msm_io_desc[size - 1].virtual);
>
> Should I now redo https://lkml.org/lkml/2014/5/15/249 by making the
> (outdated) checks in arch/arm/mach-msm/board-trout.c and
> arch/arm/mach-msm/board-trout-gpio.c also use CONFIG_DEBUG_MSM_UART?
>

Hm, not exactly. It seems that this board has multiple UARTs that can be 
used for debug, so we should also check for the UART PHYS address. I 
will prepare a patch to fix this too.

Thanks,
Georgi
