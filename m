From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 May 2012 10:14:16 -0600
Subject: arm: Remaining issue with alignment of __log_buf in printk.c
In-Reply-To: <4FC25048.109@wwwdotorg.org>
References: <4FC22098.3070803@kernel.org> <4FC25048.109@wwwdotorg.org>
Message-ID: <4FC4F5D8.8090701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2012 10:03 AM, Stephen Warren wrote:
> On 05/27/2012 06:39 AM, Jonathan Cameron wrote:
>> Hi All,
>>
>> My stargate 2 board refused to start and after bisection I ended
>> up at the same patch that Stephen found an alignment issue in.
>> Unfortunately Stephen's patch doesn't seem to have fixed the
>> issue for me.
>> https://lkml.org/lkml/2012/5/10/510 is the thread.  Patch from
>> Stephen is : f8450fca6ecdea38b5a882fdf6cd097e3ec8651c
>>
>> Increasing the alignement for 32 bit systems to 8 seems to do the
>> job but I can't immediately think why...
>>
>> System is a pxa27x strong arm.
...
> #if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> #define LOG_ALIGN 4
> #else
> #define LOG_ALIGN 8
> #endif

Actually, why not replace that with:

#define LOG_ALIGN (__alignof__(struct log_buf))

That way, the compiler will calculate the arch-/ABI-appropriate
alignment value automatically and correctly in all cases, so we won't
have to fix that ifdef above.
