From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 16 Sep 2014 23:37:31 +0100
Subject: [PATCH v8 6/9] arm: netx: Migrate DEBUG_LL macros to shared
 directory
In-Reply-To: <54175E87.2070509@linaro.org>
References: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>	
 <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>	
 <1408459715-10151-7-git-send-email-daniel.thompson@linaro.org>
 <1410798874.31130.57.camel@x220> <54175E87.2070509@linaro.org>
Message-ID: <5418BBAB.6040508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/14 22:47, Daniel Thompson wrote:
> On 15/09/14 17:34, Paul Bolle wrote:
>> On Tue, 2014-08-19 at 15:48 +0100, Daniel Thompson wrote:
>>> As part of the migration we introduce DEBUG_UART_PHYS/DEBUG_UART_VIRT
>>> which default to UART1 but allow a user to configure UART2 or UART3.
>>> We also introduce symbolic names for the registers and flags.
>>>
>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Acked-by: Arnd Bergmann <arnd.bergmann@linaro.org>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>
>> This patch landed in today's linux-next, as 880fa9b6fd73 ("ARM: 8144/1:
>> netx: Migrate DEBUG_LL macros to shared directory").
>>
>>> [...]
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -447,6 +447,14 @@ choice
>>>  		  Say Y here if you want kernel low-level debugging support
>>>  		  on Vybrid based platforms.
>>>  
>>> +	config DEBUG_NETX_UART
>>> +		bool "Kernel low-level debugging messages via NetX UART"
>>> +		depends on ARCH_NETX
>>> +		select DEBUG_UART_NETX
>>
>> There's no Kconfig symbol DEBUG_UART_NETX in next-20140915. So in
>> linux-next this is currently a nop. Is this symbol queued somewhere?
> 
> No. The symbol isn't queued anywhere.
> 
> DEBUG_UART_NETX is a config value that existed transiently when I wrote
> the patch and I didn't clean it up properly. I suspect its visual
> similarity to DEBUG_NETX_UART means it didn't jump out when I self reviewed.
> 
> Thanks for raising this. I will share a patch to remove this.

I was just finalizing this and, since it was on my screen anyway, took
another look at my assembler changes.

They are broken! Rather than initializing \rp and \rv as they are
supposed to they set \rp to two different values leaving \rv uninitialized.

This I will also fix.


Daniel.
