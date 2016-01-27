From: qiuxishi@huawei.com (Xishi Qiu)
Date: Wed, 27 Jan 2016 09:18:57 +0800
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <20160113112813.GE23370@leverpostej>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5695DA67.5080201@huawei.com> <20160113112813.GE23370@leverpostej>
Message-ID: <56A81B01.7010104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/13 19:28, Mark Rutland wrote:

> On Wed, Jan 13, 2016 at 01:02:31PM +0800, Xishi Qiu wrote:
>> Hi Mark,
>>
>> If I do like this, does it have the problem too?
>>
>> kmalloc a size
>> no access
>> flush tlb
>> call set_memory_ro to change the page table flag
>> flush tlb
>> start access
> 
> This is broken.
> 
> The kmalloc will give you memory form the linear mapping. Even if you
> allocate a page, that page could have been mapped with a section at the
> PMD/PUD/PGD level.
> 
> Other data could fall within that section (e.g. a kernel stack,
> perhaps).

Hi Mark,

If nobody use that whole section before(however it is almost impossible),
flush tlb is safe, right?

Thanks,
Xishi Qiu

> 
> Additional TLB flushees do not help. There's still a race against the
> asynchronous TLB logic. The TLB can allocate or destroy entries at any
> tim. If there were no page table changes prior to the invalidate, the
> TLB could re-allocate all existing entries immediately after the TLB
> invalidate, leaving you in the same state as before.
> 
> Thanks,
> Mark.
> 
> .
> 
