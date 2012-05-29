From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 May 2012 11:13:47 -0600
Subject: arm: Remaining issue with alignment of __log_buf in printk.c
In-Reply-To: <CAPXgP10gLk1UPp8iGkDSapwMzqd2kHuOer3BOq73f5i7if4aoA@mail.gmail.com>
References: <4FC22098.3070803@kernel.org> <4FC25048.109@wwwdotorg.org>
 <4FC4F5D8.8090701@wwwdotorg.org>
 <CAPXgP10gLk1UPp8iGkDSapwMzqd2kHuOer3BOq73f5i7if4aoA@mail.gmail.com>
Message-ID: <4FC503CB.3070405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2012 10:32 AM, Kay Sievers wrote:
> On Tue, May 29, 2012 at 6:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/27/2012 10:03 AM, Stephen Warren wrote:
>>> On 05/27/2012 06:39 AM, Jonathan Cameron wrote:
>>>> Hi All,
>>>>
>>>> My stargate 2 board refused to start and after bisection I ended
>>>> up at the same patch that Stephen found an alignment issue in.
>>>> Unfortunately Stephen's patch doesn't seem to have fixed the
>>>> issue for me.
>>>> https://lkml.org/lkml/2012/5/10/510 is the thread.  Patch from
>>>> Stephen is : f8450fca6ecdea38b5a882fdf6cd097e3ec8651c
>>>>
>>>> Increasing the alignement for 32 bit systems to 8 seems to do the
>>>> job but I can't immediately think why...
>>>>
>>>> System is a pxa27x strong arm.
>> ...
>>> #if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>> #define LOG_ALIGN 4
>>> #else
>>> #define LOG_ALIGN 8
>>> #endif
>>
>> Actually, why not replace that with:
>>
>> #define LOG_ALIGN (__alignof__(struct log_buf))
>>
>> That way, the compiler will calculate the arch-/ABI-appropriate
>> alignment value automatically and correctly in all cases, so we won't
>> have to fix that ifdef above.
> 
> __alignof__(u64) will be 8 on x86_64, while the current logic results
> in 4. Not sure if x86_64 would somehow benefit from that, or if it's
> just a waste of bytes.
> 
> Are you sure it results in 4 on some architectures?

I have no idea to be honest, but I'd tend towards making this reliable
first, and optimizing a few bytes later.

Perhaps something like the following would work though:

> #if (__alignof__(struct log_buf) == 4) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> #define LOG_ALIGN 4
> #else
> #define LOG_ALIGN 8
> #endif
