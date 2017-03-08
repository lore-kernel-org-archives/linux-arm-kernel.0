From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 8 Mar 2017 20:48:31 +0100
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
Message-ID: <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 07:06 PM, Masahiro Yamada wrote:
> Hi Robin,
> 
> 
> 2017-03-08 20:15 GMT+09:00 Robin Murphy <robin.murphy@arm.com>:
>> On 08/03/17 10:59, Masahiro Yamada wrote:
>>> Hi experts,
>>>
>>> I have a question about
>>> how to allocate DMA-safe buffer.
>>>
>>>
>>> In my understanding, kmalloc() returns
>>> memory with DMA safe alignment
>>> in order to avoid cache-sharing problem when used for DMA.
>>>
>>> The alignment is decided by ARCH_DMA_MINALIGN.
>>> For example, on modern ARM 32bit boards, this value is typically 64.
>>> So, memory returned by kmalloc() has
>>> at least 64 byte alignment.
>>>
>>>
>>> On the other hand, devm_kmalloc() does not return
>>> enough-aligned memory.
>>
>> How so? If anything returned by kmalloc() is guaranteed to occupy some
>> multiple of ARCH_DMA_MINALIGN bytes in order to avoid two allocations
>> falling into the same cache line, I don't see how stealing the first 16
>> bytes *of a single allocation* could make it start sharing cache lines
>> with another? :/
> 
> I just thought of traverse of the linked list of devres_node
> on a different thread, but it should not happen.

When the DMA memory is mapped for reading from the device the associated
cachelines are invalidated without writeback. There is no guarantee that the
changes made to the devres_node have made it to main memory yet, or is
there? So those updates could be lost and you'd get a data structure corruption.
