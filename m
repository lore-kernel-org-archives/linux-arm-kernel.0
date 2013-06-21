From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 17:20:52 -0400
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
In-Reply-To: <201306212313.16771.arnd@arndb.de>
References: <201306212228.29717.arnd@arndb.de>
 <201306212235.43125.arnd@arndb.de> <51C4BC5A.70105@ti.com>
 <201306212313.16771.arnd@arndb.de>
Message-ID: <51C4C3B4.2050508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013 05:13 PM, Arnd Bergmann wrote:
> On Friday 21 June 2013, Santosh Shilimkar wrote:
>> On Friday 21 June 2013 04:35 PM, Arnd Bergmann wrote:
>>> On Friday 21 June 2013, Arnd Bergmann wrote:
>>>> This lets us build keystone with CONFIG_THUMB2_KERNEL enabled,
>>>> without the patch we get this error:
>>>>
>>>> Error: cannot determine Thumb instruction size. Use .inst.n/.inst.w instead
>>>>
>>>> This follows the same change for all other platforms done
>>>> earlier.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
>>>> index 630ab3bd..1800c33 100644
>>>> --- a/arch/arm/mach-keystone/platsmp.c
>>>> +++ b/arch/arm/mach-keystone/platsmp.c
>>>> @@ -34,7 +34,7 @@ static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
>>>>              "mov    r0, #0\n"       /* power on cmd */
>>>>              "mov    r1, %1\n"       /* cpu          */
>>>>              "mov    r2, %2\n"       /* start        */
>>>> -            ".inst  0xe1600070\n"   /* smc #0       */
>>>> +            "smc    #0\n"           /* smc #0       */
>>>>              "mov    %0, r0\n"
>>>>              : "=r" (error)
>>>>              : "r"(cpu), "r"(start)
>>>
>>> Ah, damm, now I get this error for building an ARMv6+ARMv7 combined kernel:
>>>
>>> /tmp/ccSWHCik.s:55: Error: selected processor does not support ARM mode `smc #0'
>>>
>>> I'll add a -march=armv7-a gcc flag as well.
>>>
>> I was just typing about the error. I started with smc first but then
>> hit the below one which lead me to write an opcode. I couldn't compile c file
>> for v7 only build and hence letf it in encoded format.
>>
>> I will be moving this code to separate asm file along with other smc
>> API support.
>>
> 
> Ok, I'll wait for a patch from you then. My second attempt to fix it
> up also didn't work.
> 
I was curious how you will fix that for a c file.
Just to be clear, I was planning to do that in 3.11-rcx/3.12
time. Let me know if it needs to be done earlier than that.

Regards,
Santosh
