From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 1 Jul 2015 10:09:29 +0200
Subject: [PATCH] arm: Update memblock limit after mapping lowmem
In-Reply-To: <558B463F.5050200@redhat.com>
References: <1433445349-12497-1-git-send-email-labbott@fedoraproject.org>
 <20150611130700.GA8153@leverpostej> <558B463F.5050200@redhat.com>
Message-ID: <CABxcv=kqkyYgS=vbUGwO5w7UOjBHF+OpZw-YnVhGFiMoZUo_xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laura,

On Thu, Jun 25, 2015 at 2:07 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 06/11/2015 06:07 AM, Mark Rutland wrote:
>>
>> On Thu, Jun 04, 2015 at 08:15:49PM +0100, Laura Abbott wrote:
>>>
>>>
>>> The memblock limit is currently used in find_limits
>>> to find the bounds for ZONE_NORMAL. The memblock
>>> limit may need to be rounded down a PMD size to ensure
>>> allocations are fully mapped though. This has the side
>>> effect of reducing the amount of memory in ZONE_NORMAL.
>>> Once all lowmem is mapped, it's safe to change the memblock
>>> limit back to include the unaligned section. Adjust the
>>> memblock limit after lowmem mapping is complete.
>>>
>>> Before:
>>>   # cat /proc/zoneinfo | grep managed
>>>          managed  62907
>>>          managed  424
>>>
>>> After:
>>>   # cat /proc/zoneinfo | grep managed
>>>          managed  63331
>>>
>>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>>> ---
>>> This is a replacement for
>>> 'arm: Don't use memblock limit for the lowmem bound' which
>>> doesn't actually work on NOMMU systems.
>>
>>
>> Works for me on TC2, atop v4.1-rc7. Before this patch, with a few byes
>> carved out of the memory node I would see:
>>
>> Memory: 1030380K/1046528K available (4832K kernel code, 154K rwdata, 1376K
>> rodata, 260K init, 147K bss, 16148K reserved, 0K cma-reserved)
>>
>> $ cat /proc/zoneinfo | grep managed
>>          managed  257660
>>
>> With the patch I see:
>>
>> Memory: 1032424K/1048572K available (4832K kernel code, 154K rwdata, 1376K
>> rodata, 260K init, 147K bss, 16148K reserved, 0K cma-reserved)
>>
>> $ cat /proc/zoneinfo | grep managed
>>          managed  258171
>>
>> The patch itself looks good to me.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks,
>> Mark.
>>
>
> FYI, I put this in the patch tracker. I was on vacation when the
> Reviewed-by/Tested-by
> came in so I'm only getting to it now.
>

Maybe is a little late but just for reference, this patch fixes a boot
hang that was reported [0] for the Exynos Chromebooks that was in
v4.1.

So on an Exynos5420 Peach Pit Chromebook:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

The patch also looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

> Thanks,
> Laura
>

Best regards,
Javier

[0]: http://archive.arm.linux.org.uk/lurker/message/20150630.100102.22c9c1d9.en.html
