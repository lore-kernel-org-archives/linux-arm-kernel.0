From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 19 Jan 2012 09:25:34 +1100
Subject: [PATCH 4/4] at91 : implement the standby function for pm/cpuidle
In-Reply-To: <20120118221845.GS1068@n2100.arm.linux.org.uk>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
 <1326843620-13148-5-git-send-email-daniel.lezcano@linaro.org>
 <4F1742E8.8090108@gmail.com> <20120118221845.GS1068@n2100.arm.linux.org.uk>
Message-ID: <4F1746DE.4000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/12 09:18, Russell King - ARM Linux wrote:

> On Thu, Jan 19, 2012 at 09:08:40AM +1100, Ryan Mallon wrote:
>> On 18/01/12 10:40, Daniel Lezcano wrote:
>>
>>> This patch groups the self-refresh on/cpu_do_idle/self-refresh off into
>>> a single 'standby' function.
>>>
>>> The standby routine for rm9200 has been turned into an asm routine to have
>>> a better control of the self refresh and to prevent a memory access when
>>> running this code.
>>>
>>> Draining the write buffer is done automatically when switching for the self
>>> refresh on sam9, so the instruction is added to the rm9200 only.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>>
>> I don't think is an improvement. Russell's suggestion was to convert the
>> pm operations into a structure, like:
>>
>> struct at91_pm_ops {
>> 	u32  (*sdram_selfrefresh_enable)(void);
>> 	void (*sdram_selfrefresh_disable)(u32 saved_lpr);
>> };
> 
> Actually no, that was my first suggestion.  I then went on to a second
> suggestion, which is what Daniel has implemented.


Ah, sorry. I seem to have missed the middle of the discussion :-).

> 
> The improvement is we've gone from this:
> 
> 		asm("b 1f; .align 5; 1:");
> 		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
> 		cpu_do_idle();
> 		sdram_selfrefresh_disable(saved_lpr);
> 
> which is really undefined, and may break with a later compiler, to:
> 
> 	u32 lpr = at91_sys_read(AT91_SDRAMC_LPR);
> 
> 	asm volatile(
> 		"b    1f\n\t"
> 		".align    5\n\t"
> 		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
> 		"    str    %0, [%1, %2]\n\t"
> 		"    str    %3, [%1, %4]\n\t"
> 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
> 		"    str    %5, [%1, %2]"
> 
> which gcc guarantees it won't insert instructions randomly into the
> middle of this.
> 
> So this is technically a far superior solution.
> 
> It also means that the implementation of at91_standby() can preserve
> as many registers as are necessary over the standby itself - it seems
> some AT91 SoCs require two registers rather than just one.


Ok, I see.

After this patch we still have the limitation that only one at91
platform can be built into the kernel (this is an existing problem,
which there is an on going effort to resolve) because the at91_standby
function is defined via ifdefs. So the at91_standby define should still
be converted to a function pointer and assigned via the soc right? Of
course, this can be done in a subsequent patch.

Thanks,
~Ryan
