From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 23 Jul 2013 10:53:04 -0700
Subject: updates for be8 patch series
In-Reply-To: <51EEC002.9070808@codethink.co.uk>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
Message-ID: <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2013 10:40, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 23/07/13 18:24, Victor Kamensky wrote:
>>
>> Hi Ben,
>>
>> Wrt BE8 little endian instructions you will need to fix couple more
>> places:
>>      ftrace arch/arm/kernel/ftrace.c
>>      kprobes arch/arm/kernel/kprobes.c
>> Also in big endian mode atomic64_xxx function will need fixes, otherwise
>> perf
>> counters will be truncated on max of 32bit values
>>      atomic64 arch/arm/include/asm/atomic.h
>
>
> Hmm, thought ftrace already did the right endian-ness conversions,
> although it is possible it could have missed one.
>
> The atomic instructions should work fine for BE8, they're using
> STRD which should be correct.

atomic64_read and atomic64_set are fine, but atomic64_add,
atomic64_add_return, atomic64_sub, atomic64_sub_return, etc are not OK.
The issue is in arithmetic operations not load/store.

Thanks,
Victor

>
>> I've attached board independent (core) patch from my work that made
>> Pandaboard ES
>> kernel run in BE mode. You can check my version of fixes for above
>> issues in the
>> patch. Look for corresponding files changes. Please rework them
>> according to style
>> and rules of your patch series. Note the patch itself contains fixes for
>> few other
>> issues that already fixed in your series. I'll cross check and compare
>> individual
>> areas latter. I think you may find attached patch interesting as well,
>> it was developed
>> independent from yours but matches its very well.
>
>
>>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
