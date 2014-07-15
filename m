From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 15 Jul 2014 18:32:23 +0400
Subject: [RFC/PATCH -next 00/21] Address sanitizer for kernel (kasan) -
 dynamic memory error detector.
In-Reply-To: <alpine.DEB.2.11.1407141012520.25405@gentwo.org>
References: <1404903678-8257-1-git-send-email-a.ryabinin@samsung.com>
 <53C08876.10209@zytor.com>
 <CAPAsAGwb2sLmu0o_o-pFP5pXhMs-1sZSJbA3ji=W+JPOZRepgg@mail.gmail.com>
 <alpine.DEB.2.11.1407141012520.25405@gentwo.org>
Message-ID: <53C53B77.3080000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/14 19:13, Christoph Lameter wrote:
> On Sun, 13 Jul 2014, Andrey Ryabinin wrote:
> 
>>> How does that work when memory is sparsely populated?
>>>
>>
>> Sparsemem configurations currently may not work with kasan.
>> I suppose I will have to move shadow area to vmalloc address space and
>> make it (shadow) sparse too if needed.
> 
> Well it seems to work with sparsemem / vmemmap? So non vmmemmapped configs
> of sparsemem only. vmemmmap can also handle holes in memory.
> 
> 

Not sure. This sparsemem/vmemmap thing is kinda new to me, so I need to dig some more
to understand how it i?teracts with kasan.

As far as I understand the main problem with sparsemem & kasan is shadow allocation:

	unsigned long lowmem_size = (unsigned long)high_memory - PAGE_OFFSET;
	shadow_size = lowmem_size >> KASAN_SHADOW_SCALE_SHIFT;

	shadow_phys_start = memblock_alloc(shadow_size, PAGE_SIZE);

If we don't have one big enough physically contiguous block for shadow it will fail.
