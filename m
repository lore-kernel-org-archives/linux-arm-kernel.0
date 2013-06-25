From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jun 2013 11:51:13 -0400
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
In-Reply-To: <20130625153929.GG2327@linaro.org>
References: <201306212228.29717.arnd@arndb.de>
 <201306212313.16771.arnd@arndb.de> <51C4C3B4.2050508@ti.com>
 <201306212341.08579.arnd@arndb.de> <51C4D9B7.5010109@ti.com>
 <20130625141332.GC2327@linaro.org> <51C9A8BF.9040602@ti.com>
 <20130625143211.GE2327@linaro.org> <51C9ABF9.1010902@ti.com>
 <20130625153929.GG2327@linaro.org>
Message-ID: <51C9BC71.1000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013 11:39 AM, Dave Martin wrote:
> On Tue, Jun 25, 2013 at 10:40:57AM -0400, Santosh Shilimkar wrote:
>> On Tuesday 25 June 2013 10:32 AM, Dave Martin wrote:
>>> On Tue, Jun 25, 2013 at 10:27:11AM -0400, Santosh Shilimkar wrote:
>>>> On Tuesday 25 June 2013 10:13 AM, Dave Martin wrote:
>>>>> On Fri, Jun 21, 2013 at 06:54:47PM -0400, Santosh Shilimkar wrote:
>>>>>> On Friday 21 June 2013 05:41 PM, Arnd Bergmann wrote:
>>>>>>> On Friday 21 June 2013, Santosh Shilimkar wrote:
>>>>>>>>>
>>>>>>>> I was curious how you will fix that for a c file.
>>>>>>>> Just to be clear, I was planning to do that in 3.11-rcx/3.12
>>>>>>>> time. Let me know if it needs to be done earlier than that.
>>>>>>>
>>>>>>> It breaks randconfig builds on arm-soc at the moment, so I'd
>>>>>>> like the fix as early as possible for 3.11.
>>>>>>>
>>>>>> Ok, fix is at end of the email. Let me know if it makes
>>>>>> to pass both the builds now. I have build and boot tested
>>>>>> both ARM and THUMB2 builds on Keystone board.
>>>>>>
>>>>>> Regards,
>>>>>> Santosh
>>>>>>
>>>>>> From 05d6a5b6cad624fb3791e8c1f8eb7c774f0790d9 Mon Sep 17 00:00:00 2001
>>>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> Date: Fri, 21 Jun 2013 18:35:32 -0400
>>>>>> Subject: [PATCH] ARM: keystone: Move CPU bringup code to dedicated asm file
>>>>>>
>>>>>> Because of inline asm usage in platsmp.c, smc instruction
>>>>>> creates build failure for ARM V6+V7 build where as using instruction
>>>>>> encoding for smc breaks the thumb2 build.
>>>>>>
>>>>>> So move the code snippet to separate asm file and mark
>>>>>> it with 'armv7-a$(plus_sec)' to avoid any build issues.
>>>>>>
>>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>>>
>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> ---

[..]

>>>>> Anyway, this looks like it should work, except:
>>>>>
>>>>>> +ENTRY(keystone_cpu_smc)
>>>>>> +	stmfd   sp!, {r4-r12, lr}
>>>>>> +	smc	#0
>>>>>> +	dsb
>>>>>
>>>>> What's this DSB for?  (You didn't have it in the inline asm version)
>>>>>
>>>> Just to drain the write buffer before resuming on non-secure side.
>>>
>>> Why do you need to do that?
>>>
>> To commit any secure side pending writes. I don't remember exactly the
>> issues but I remember facing issues in power management sequencing with
>> SMC calls in between. That time a dsb did the trick. In fact I use to
>> keep 1 before SMC and 1 after. 
> 
> Can we at least have a comment (as recommended in
> Documentation/development-process/4.Coding)?
> 
> We don't want other people reading this and concluding that SMC always
> needs barriers -- in general, this shouldn't be necessary and could
> indicate bugs lurking somewhere.
> 
Agree. Comment should have been there to avoid confusion. Will do.

Regards,
Santosh
