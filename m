From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 9 Mar 2017 03:06:34 +0900
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
Message-ID: <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,


2017-03-08 20:15 GMT+09:00 Robin Murphy <robin.murphy@arm.com>:
> On 08/03/17 10:59, Masahiro Yamada wrote:
>> Hi experts,
>>
>> I have a question about
>> how to allocate DMA-safe buffer.
>>
>>
>> In my understanding, kmalloc() returns
>> memory with DMA safe alignment
>> in order to avoid cache-sharing problem when used for DMA.
>>
>> The alignment is decided by ARCH_DMA_MINALIGN.
>> For example, on modern ARM 32bit boards, this value is typically 64.
>> So, memory returned by kmalloc() has
>> at least 64 byte alignment.
>>
>>
>> On the other hand, devm_kmalloc() does not return
>> enough-aligned memory.
>
> How so? If anything returned by kmalloc() is guaranteed to occupy some
> multiple of ARCH_DMA_MINALIGN bytes in order to avoid two allocations
> falling into the same cache line, I don't see how stealing the first 16
> bytes *of a single allocation* could make it start sharing cache lines
> with another? :/

I just thought of traverse of the linked list of devres_node
on a different thread, but it should not happen.

Please forget my stupid question.


> If a particular device has a problem with:
>
> p = kmalloc(...);
> d = dma_map_single(p + 0x10, ...);
> do_something_with(d);
>
> that's a separate issue altogether.

Right.
Each device has own requirement for DMA alignment.

Thanks!


-- 
Best Regards
Masahiro Yamada
