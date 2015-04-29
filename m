From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Wed, 29 Apr 2015 14:49:26 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <3382997.5hgfVKmNXP@wuerfel>
References: <5538DD02.6050401@topic.nl> <2919263.vEuyzce5K7@wuerfel>
 <5540B35C.4050002@topic.nl> <3382997.5hgfVKmNXP@wuerfel>
Message-ID: <5540D356.50708@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 29-04-15 12:41, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 12:33:00 Mike Looijmans wrote:
>> On 29-04-15 12:07, Arnd Bergmann wrote:
>>> On Wednesday 29 April 2015 11:47:37 Mike Looijmans wrote:
>>>> On 29-04-15 11:17, Russell King - ARM Linux wrote:
>>>>> The buffer should also be mapped into userspace with the same memory
>>>>> type and cache attributes as the kernel side mapping.  If using ACP,
>>>>> then you probably want "normal memory, cacheable, writeback, read
>>>>> allocate" or in the case of SMP, the same but "read/write allocate".
>>>
>>> If my suspicion is correct, we should either change arm_coherent_dma_ops()
>>> to refer to a different mmap() callback that does the right thing for
>>> coherent devices, or change arm_dma_mmap() to look at dev->is_coherent.
>>
>> Following the route, arch/arm/mm/dma-mapping.c uses pgprot_dmacoherent() which
>> is defined in arch/arm/include/asm/pgtable.h and that just returns uncached
>> memory.
>>
>> If you can give me some hints as to what the correct flags would be, I can
>> patch my kernel and test it.
>
> Use the flags that Russell listed above.

I would if I had a clue how to do that. For one thing, I don't understand all 
the L_PTE_... flag juggling that happens here.

I also tried just using kmalloc() to allocate the buffer, and then 
dma_map_single that. This is what the DMA documentation told me to do for 
non-coherent mappings. This works fine for the streaming-dma mode using the 
HP, but using dma-coherent this not only fails to work, it tends to completely 
lock the system.

Avoiding the streaming mapping and using only the coherent modes prevents the 
system locking up, it then doesn't do more harm than just corrupting data in 
the buffers.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
