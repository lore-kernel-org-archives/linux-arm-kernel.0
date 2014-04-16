From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 16 Apr 2014 15:01:48 -0700
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416.172153.646525167994615191.davem@davemloft.net>
References: <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
 <534EE6F2.3050005@linaro.org>
 <20140416.172153.646525167994615191.davem@davemloft.net>
Message-ID: <CAA3XUr2N5S8o8imk4MmY2R=5Aa_-TdVOjqg1ArOC34J-RmAKqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2014 14:21, David Miller <davem@davemloft.net> wrote:
> From: David Long <dave.long@linaro.org>
> Date: Wed, 16 Apr 2014 16:24:18 -0400
>
>> On 04/16/14 15:37, David Miller wrote:
>>> From: Oleg Nesterov <oleg@redhat.com>
>>> Date: Wed, 16 Apr 2014 21:18:25 +0200
>>>
>>>> The last question... area->page = alloc_page(GFP_HIGHUSER), and I am
>>>> not sure that arch/arm/mm/highmem.c:kmap_atomic() can't break the
>>>> aliasing, __fix_to_virt() in this case will use the same (per-cpu) idx.
>>>>
>>>> Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
>>>> care, but could you please ack/nack my understanding?
>>>
>>> Good point, it might therefore make sense to use a low-mem page.
>>>
>>
>> The following test code seems to have the same problems with stale user
>> icache.  It works if I put the dcache flush back in.  Am I missing
>> something?
>
> Weird, if we store to the kernel side it should be just a matter of
> clearing the I-cache out.  There should be no D-cache aliasing
> whatsoever.

I don't think there is dcache aliasing, but dcache should be flushed anyway
otherwise icache will not see updated values even it is invalidated. I.e
dcache should be flushed up to dcache/icache unification layer.
I.e icache does not read anything from dcache directly. It reads from L2.
As it was noted below flush_cache_user_range will take care of both,
but just __flush_icache_all is not enough.

I will try to add non-aliased mapping logic from Dave's patch on top
of previously posted patch (which goes under "write directly"), has
default/arm split, etc ...

Thanks,
Victor

>  Maybe you could print out area->vaddr and
> page_to_virt(area->page) so we can see if area->vaddr is choosen
> correctly?
>
> Although I notice that flush_cache_user_range() on ARM flushes both D
> and I caches.  And I think that's what userspace ends up triggering
> when it uses the system call that exists to support self-modifying and
> JIT code generators.
>
> An ARM expert will have to chime in...
