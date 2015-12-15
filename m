From: jcm@redhat.com (Jon Masters)
Date: Tue, 15 Dec 2015 10:43:03 -0500
Subject: memcpy alignment
In-Reply-To: <20151215153202.GC8644@n2100.arm.linux.org.uk>
References: <566F92D6.8060103@redhat.com>
 <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
 <5670309D.1040309@redhat.com> <20151215153202.GC8644@n2100.arm.linux.org.uk>
Message-ID: <56703507.2020004@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2015 10:32 AM, Russell King - ARM Linux wrote:
> On Tue, Dec 15, 2015 at 10:24:13AM -0500, Jon Masters wrote:
>> On 12/15/2015 04:34 AM, Catalin Marinas wrote:
>>> On Mon, Dec 14, 2015 at 11:11:02PM -0500, Jon Masters wrote:
>>>> What's supposed to happen if the natural alignment of the pointers dst
>>>> and src is not the same? We don't seem to handle that case today, and
>>>> instead will base our access data type on the source alignment only.
>>>
>>> The hardware takes care of the other one. The memcpy behaviour in the
>>> kernel is the same as the glibc one (the Cortex Strings library).
>>
>> Not if you're dealing with Device memory. I accept that one could always
>> ensure that there's a non-Device mapping (I got the other replies) but I
>> don't think it's unreasonable to expect a memcpy to work in the presence
>> of misaligned addresses either.
> 
> Using memcpy() on memory returned from functions which setup IO/MMIO
> mappings has always been outlawed.  It's the whole reason we have
> things like memcpy_toio(), memcpy_fromio() and memset_io(), which
> date back a few decades now, and they exist for exactly these kinds
> of reasons.
> 
> If you get an __iomem pointer, then you must respect that it
> essentially can not be non-dereferenced, and you must use one of the
> standard kernel accessors (read[bwl]/ioread*/write[bwl]/iowrite*/
> memcpy_fromio/memcpy_toio/memset_io) to access it.  That's the API
> contract you implicitly signed up to by using something like ioremap()
> or other mapping which gives you an iomem mapping.

Thanks Russell. If it's definitely never allowed then the existing x86
code needs to be fixed to use an IO access function in that case. I get
that those accessors are there for this reason, but I wanted to make
sure that we don't ever expect to touch Device memory any other way (for
example, conflicting mappings between a VM and hypervisor). I am certain
there's other non-ACPI code that is going to have this happen :)

Jon.
