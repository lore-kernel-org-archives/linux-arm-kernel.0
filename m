From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 17:21:53 -0400 (EDT)
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <534EE6F2.3050005@linaro.org>
References: <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
 <534EE6F2.3050005@linaro.org>
Message-ID: <20140416.172153.646525167994615191.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Long <dave.long@linaro.org>
Date: Wed, 16 Apr 2014 16:24:18 -0400

> On 04/16/14 15:37, David Miller wrote:
>> From: Oleg Nesterov <oleg@redhat.com>
>> Date: Wed, 16 Apr 2014 21:18:25 +0200
>> 
>>> The last question... area->page = alloc_page(GFP_HIGHUSER), and I am
>>> not sure that arch/arm/mm/highmem.c:kmap_atomic() can't break the
>>> aliasing, __fix_to_virt() in this case will use the same (per-cpu) idx.
>>>
>>> Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
>>> care, but could you please ack/nack my understanding?
>> 
>> Good point, it might therefore make sense to use a low-mem page.
>> 
> 
> The following test code seems to have the same problems with stale user
> icache.  It works if I put the dcache flush back in.  Am I missing
> something?

Weird, if we store to the kernel side it should be just a matter of
clearing the I-cache out.  There should be no D-cache aliasing
whatsoever.  Maybe you could print out area->vaddr and
page_to_virt(area->page) so we can see if area->vaddr is choosen
correctly?

Although I notice that flush_cache_user_range() on ARM flushes both D
and I caches.  And I think that's what userspace ends up triggering
when it uses the system call that exists to support self-modifying and
JIT code generators.

An ARM expert will have to chime in...
