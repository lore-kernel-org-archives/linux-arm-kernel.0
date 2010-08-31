From: mark.brown314@gmail.com (Mark F. Brown)
Date: Tue, 31 Aug 2010 03:24:09 -0400
Subject: [PATCH 1/1] ARM: pxa168: fix corrected reset vector
In-Reply-To: <AANLkTik3cnE4HQ3hq3wfuxcept4BeTh+zZvNDbZ_b3O7@mail.gmail.com>
References: <1282813649-8332-1-git-send-email-mark.brown314@gmail.com>
	<1282813649-8332-2-git-send-email-mark.brown314@gmail.com>
	<AANLkTi=GZ1p3MzibOEzhyD=Mv6d2x2nRh93D4bmtgcYE@mail.gmail.com>
	<AANLkTimwU17YS5Yk7y+13Dj9Ww4oPG0g4v5ZbvOVuQV6@mail.gmail.com>
	<AANLkTikxOQnj=vKD8b0aZqZHNe4m-Y+o+620TBzMJCAW@mail.gmail.com>
	<AANLkTik3cnE4HQ3hq3wfuxcept4BeTh+zZvNDbZ_b3O7@mail.gmail.com>
Message-ID: <AANLkTi=3JowKs2V-qW1sX4CC=ePq+EDWkh4XseSSuxy2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 2:08 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Aug 31, 2010 at 2:04 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Tue, Aug 31, 2010 at 2:02 PM, Mark F. Brown <mark.brown314@gmail.com> wrote:
>>> On Tue, Aug 31, 2010 at 1:48 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>> On Thu, Aug 26, 2010 at 5:07 PM, Mark F. Brown <mark.brown314@gmail.com> wrote:
>>>>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>>>>> ---
>>>>> ?arch/arm/mach-mmp/include/mach/system.h | ? ?2 +-
>>>>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
>>>>> index 4f5b0e0..926e9c0 100644
>>>>> --- a/arch/arm/mach-mmp/include/mach/system.h
>>>>> +++ b/arch/arm/mach-mmp/include/mach/system.h
>>>>> @@ -16,6 +16,6 @@ static inline void arch_idle(void)
>>>>>
>>>>> ?static inline void arch_reset(char mode, const char *cmd)
>>>>> ?{
>>>>> - ? ? ? cpu_reset(0);
>>>>> + ? ? ? cpu_reset(0xffff0000);
>>>>
>>>> Not sure if this correct. But normally reset jump happens after we turn
>>>> off the MMU and so on. Ain't the BootROM starts from 0 ?
>>>>
>>>>> ?}
>>>>> ?#endif /* __ASM_MACH_SYSTEM_H */
>>>>> --
>>>>> 1.7.0.4
>>>>>
>>>>>
>>>>
>>>
>>> Eric, the boot-rom for pxa168 starts at 0xffff_0000. I am pretty sure
>>> about that! If you set the reset vector to 0x0 it will crash during
>>> reboot. I will send you xdb snapshots if you need me to.
>>>
>>
>> OK, you are expert on this :-)
>>
>> Applied to 'fix'.
>>
>
> One moment. Since this is really global to pxa910 and mmp2, so I
> suggest this being fixed for pxa168 only first. How about this:
>
> ? ?ARM: pxa168: fix corrected reset vector
>
> ? ?Reset vector for pxa168 is 0xffff_0000 not 0x0. This fix allows
> ? ?reboot to work
>
> ? ?Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>
> diff --git a/arch/arm/mach-mmp/include/mach/system.h
> b/arch/arm/mach-mmp/include/mach/system.h
> index 4f5b0e0..1a8a25e 100644
> --- a/arch/arm/mach-mmp/include/mach/system.h
> +++ b/arch/arm/mach-mmp/include/mach/system.h
> @@ -9,6 +9,8 @@
> ?#ifndef __ASM_MACH_SYSTEM_H
> ?#define __ASM_MACH_SYSTEM_H
>
> +#include <mach/cputype.h>
> +
> ?static inline void arch_idle(void)
> ?{
> ? ? ? ?cpu_do_idle();
> @@ -16,6 +18,9 @@ static inline void arch_idle(void)
>
> ?static inline void arch_reset(char mode, const char *cmd)
> ?{
> - ? ? ? cpu_reset(0);
> + ? ? ? if (cpu_is_pxa168())
> + ? ? ? ? ? ? ? cpu_reset(0xffff0000);
> + ? ? ? else
> + ? ? ? ? ? ? ? cpu_reset(0);
> ?}
> ?#endif /* __ASM_MACH_SYSTEM_H */
>

That will work!

-- Mark
