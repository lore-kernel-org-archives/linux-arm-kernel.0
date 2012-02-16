From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Feb 2012 17:15:20 +0000
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
Message-ID: <20120216171520.GA9151@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 04:41:02PM +0000, viresh kumar wrote:
> Sorry for starting the long old thread again, but i have to start it as i
> was a bit confused. :(
> 
> We know that we can't have multiple mappings with different attributes
> to the same physical memory on ARMv6+ machines due to speculative
> prefetch.
> 
> So, we have following kind of mappings in kernel now (please correct me
> if i am wrong):
> - Low Mem: Mapped at boot time to - Normal Cacheable - Bufferable
> - ioremap() - blocked on Low Mem, so that we don't create Device type mapping
> to same mem
> - dma_alloc_coherent() and others:
>          - Without DMA_MEM_BUFFERABLE selected - gives strongly ordered mem
>           (i.e. Non cacheable - Non Bufferable)
>          - With DMA_MEM_BUFFERABLE selected - gives Normal - Non cacheable -
>            Bufferable mapping
>          - Maybe some other too...
> 
> I have a doubt with the last mapping mentioned above. We have two
> mappings possibly to the same physical memory, with different
> attributes: One is Cacheable and other one is not.
> 
> Is this allowed by ARM? Because the patch in which Russell blocked
> ioremap on Low Mem, he clearly mentioned that these attributes are
> also important and they should be same.

Section A3.5.7 in the latest ARM ARM (revC) clarifies the mismatched
memory attributes (more precise compared to the original "unpredictable"
statement, though the description there is not an easy read). While
changes to the ARM ARM do not apply to already implemented processors,
to my knowledge all existing cores comply with the new ARM ARM
description.

To summarise, if you mix Normal with Device or SO memory, you only get
the guarantees of the Normal memory (e.g. early write acknowledgement,
write buffer gathering, speculative accesses), so it's not recommended.
If you mix Normal Cacheable with Normal Non-cacheable, you need to make
sure that the cacheable mapping does not have any dirty cache lines that
could be evicted. Additionally, if you read the buffer through the
cacheable mapping later, you need to invalidate it first in case cache
lines have been speculatively fetched. The ARM ARM definition however
guarantees that accesses through the Non-cacheable mapping does not hit
any cache lines (brought in via the Cacheable mapping).

So regarding your ioremap() lowmem, even if Linux allowed you to do that
you wouldn't get the guarantees of the Device memory.

-- 
Catalin
