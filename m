From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 10 Apr 2013 14:35:05 +0100
Subject: v7_flush_kern_cache_louis flushes up to L2?
In-Reply-To: <CABYn4swK_FB+nPO4vKZM8khp+mjaPwkAv_GF+XDg5SYz0VLf0Q@mail.gmail.com>
References: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
 <51655248.7000401@arm.com>
 <CABYn4swK_FB+nPO4vKZM8khp+mjaPwkAv_GF+XDg5SYz0VLf0Q@mail.gmail.com>
Message-ID: <51656A89.9090600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again Bastian,

On 10/04/13 13:16, Bastian Hecht wrote:
[...]
>>> This flushes the data out up to the L2, right? The ARM docs say that
>>> the Point of Unification would be my L2. I'm a bit confused by the
>>> term "Level of Unification Inner Shareable" (that states that in an
>>> SMP system L1 coherency is guaranteed and all is flushed to the L2?).
>>>
>>
>> As you say, for the A9 (from the TRM) the CLIDR reports LoUIS is the same as
>> LoUU and both specify L2.
>
> Ok, this is the golden info I was looking for. So after cpu_suspend()
> I am good with the following sequence?
> flush L2 (outer_flush_all)
> disable L2 (outer_disable)
> Clear the SCTLR.C bit and issue an "isb"
> flush L1 (v7_flush_dcache_all)

This looks good but I think there's a minor modification to be made to 
the sequence here:

After you turn of the caches with the SCTLR.C bit, you can no longer hit 
in the L1 cache:
SCTLR.C = 0:
"The Cortex-A9 L1 Data Cache is not enabled. All memory accesses to 
Normal Memory Cacheable regions are treated as Normal Memory 
Non-Cacheable, without lookup and without allocation in the L1 Data Cache."

If you had dirty data in the L1 cache you will lose it at that point.

So, you should flush L1 before turning off caches.

Note that on SMP, you would also need to clean/flush again after turning 
off the caches, as read-speculation could have sucked dirty data from 
another cache in to your cache, which would need to be written back 
before sleeping.

> cpu_do_idle
>
> and for resume:
> invalidate L1

How do you plan to do this? I notice that there's an increasing tendency 
to call v7_invalidate_l1 which isn't actually part of the cacheflush API 
(see arch/arm/include/asm/cacheflush.h arch/arm/include/asm/glue-cache.h...)

Does your cache definitely come up in an undefined state? If not, could 
you use v7_flush_dcache_all? (see the comment above v7_invalidate_l1 in 
arch/arm/mm/cache-v7.S)

Hope that helps,

Jonny
