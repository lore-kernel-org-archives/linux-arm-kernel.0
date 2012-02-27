From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Feb 2012 14:07:00 +0100
Subject: [PATCH 3/4] at91 : remove wait_for_interrupt definition
In-Reply-To: <20120227125034.GU22562@n2100.arm.linux.org.uk>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
 <1327449368-29917-3-git-send-email-daniel.lezcano@linaro.org>
 <20120125001858.GD12326@n2100.arm.linux.org.uk> <4F201435.7030402@linaro.org>
 <20120227125034.GU22562@n2100.arm.linux.org.uk>
Message-ID: <4F4B7FF4.80402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2012 01:50 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 25, 2012 at 03:39:49PM +0100, Daniel Lezcano wrote:
>> On 01/25/2012 01:18 AM, Russell King - ARM Linux wrote:
>>> On Wed, Jan 25, 2012 at 12:56:07AM +0100, Daniel Lezcano wrote:
>>>> All the "wait_for_interrupt" definition are aliases to cpu_do_idle.
>>>> Only the rm9200 has an asm routine to switch to wfi. But the cpu_do_idle
>>>> for this platform has exactly the same asm routine.
>>>>
>>>> arch/arm/mm/proc-arm920.S
>>>> ...
>>>> ENTRY(cpu_arm920_do_idle)
>>>>           mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
>>>> ...
>>>>
>>>> Then it is safe to invoke cpu_do_idle for this platform.
>>>
>>> No it is not.
>>>
>>> Please read Nicolas' post:
>>>
>>> http://lists.arm.linux.org.uk/lurker/message/20120112.144129.827ae490.en.html
>>>
>>> and think about what "DWB is needed before putting SDRAM into self-refresh
>>> because any subsequent access to SDRAM will force it to resume from
>>> self-refresh state" means.
>>>
>>> Consider that if you _branch_ somewhere else, you _could_ cause a cache
>>> line fetch, which will have to come from SDRAM.
>>
>> Oh, right. I am not familiar with this part, thanks for the clarification.
>>
>>>    From Nicolas' post, it's pretty clear to me that the AT91RM9200 requires
>>> carefully crafted assembly which can't be separated in this way to work,
>>> which I mostly supplied in this mail:
>>>
>>> http://lists.arm.linux.org.uk/lurker/message/20120109.144443.3626e5a6.en.html
>>
>> Ok, this is what does the patch 4/4, it changes the self-refresh and wfi
>> into an asm routine where cpu_do_idle call is removed. Can I consider by
>> folding 3/4 and 4/4 ? So the buggy cpu_do_idle change won't appear...
>
> So I see your patch is in arm-soc now, inspite of my note that it's
> probably broken.
>
> If it's been tested, then all the asm() stuff in arch/arm/mach-at91/pm.c
> along with the sdram crap can be removed.

Yes, this is what the patch 4/4 does right after, also removing the 
cpu_do_idle. There no more asm routine in pm.c now.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
