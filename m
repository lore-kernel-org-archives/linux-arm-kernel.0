From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 17 Feb 2011 09:39:47 +0000
Subject: [klibc] fwd: fix up ARM assembly to use 'bx lr' in place of 'mov
	pc, lr'.
In-Reply-To: <20110216235019.GA17674@shutemov.name>
References: <20110216230648.GA7649@stro.at>
	<20110216235019.GA17674@shutemov.name>
Message-ID: <AANLkTim7T_qQB+UsEzW_63EByM+4eJfQ+tiYua8B+8TU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 11:50 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Thu, Feb 17, 2011 at 12:06:48AM +0100, maximilian attems wrote:
>> hello vorlon,
>>
>> got notified of your patch,
>> will apply next days upstream unless some critiques are voiced on ml.
>> thanks.
>>
>> --
>> maks
>>
>>
>> ----- Forwarded message from Steve Langasek <steve.langasek@canonical.com> -----
>>
>> Date: Wed, 16 Feb 2011 22:05:42 -0000
>> From: Steve Langasek <steve.langasek@canonical.com>
>> Subject: [Bug 527720] Re: thumb2 porting issues identified: klibc uses mov.*pc
>>
>>
>> I've also touched it up to be mergeable with Debian (support v4t builds
>> with #ifdef).
>>
>> Confirmed that installing the resulting klibc packages on my beagleboard
>> gives me a successfully-booting initramfs with klibc; and the
>> vfork/setjmptest test cases all pass in the klibc package tree.
>>
>> Fixes: https://bugs.launchpad.net/ubuntu/+source/klibc/+bug/527720
>>
>> --- klibc-1.5.20.orig/usr/klibc/arch/arm/vfork.S
>> +++ klibc-1.5.20/usr/klibc/arch/arm/vfork.S
>> @@ -25,7 +25,11 @@ vfork:
>> ? ? ? ? ?ldrcs ? ? ? ?r3, 1f
>> ? ? ? ? ?mvncs ? ? ? ?r0, #0
>> ? ? ? ? ?strcs ? ? ? ?r2, [r3]
>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>
> NAK. ARMv4T supports bx intruction. ARMv4 doesn't.
>

You're strictly correct.  My original rationale was to ensure there is
no disruption for people building for v4/v4T -- since the more
restricted functionality of Thumb-1 means people tend not to use it to
build the whole distro anyway.

If people using <v5 are prepared to accept the change, I've got no
problem with changing the #ifs to #ifdef __ARM_ARCH_4__

We can't get rid of the #ifdef though, unless we can persuade everyone
targeting v4 to build with gcc/as -march=armv4t + ld --fix-v4bx
(unlikely).

Cheers
---Dave
