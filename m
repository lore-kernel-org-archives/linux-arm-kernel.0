From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 11 Apr 2015 09:35:15 +0200
Subject: [PATCH v2] crypto/arm: accelerated SHA-512 using ARM generic ASM
 and NEON
In-Reply-To: <F695F357-2A5C-4DFC-9F0E-188CDBBE7C01@linaro.org>
References: <1428676148-28210-1-git-send-email-ard.biesheuvel@linaro.org>
 <5553652.sur4tr0YJi@wuerfel>
 <F695F357-2A5C-4DFC-9F0E-188CDBBE7C01@linaro.org>
Message-ID: <CAKv+Gu-6mZwrVSCvS+ZWWwwM-294nWAqX4_J3r5Z8NM7KKC0=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2015 at 22:23, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 10 apr. 2015, at 22:08, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> On Friday 10 April 2015 16:29:08 Ard Biesheuvel wrote:
>>> +#if __ARM_MAX_ARCH__>=7
>>> +.arch  armv7-a
>>> +.fpu   neon
>>> +
>>
>> This will cause a build failure on an ARMv7-M build, which is incompatible
>> with .arch  armv7-a and .fpu   neon.
>>
>
> The neon part depends on CONFIG_KERNEL_MODE_NEON, which would never be set for that platform, I suppose

On second thought, that is not entirely true, but I still don't think
there is problem here:
the .arch/.fpu declarations are understood perfectly fine by GAS when
targeting ARMv7-M. Only, it will emit code that is incompatible with
it. However, this code is invoked at runtime only if a NEON unit has
been detected, so it will just be ignored on ARMv7-M

-- 
Ard.
