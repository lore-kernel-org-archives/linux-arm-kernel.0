From: t.fujak@samsung.com (Tomasz Fujak)
Date: Mon, 27 Dec 2010 11:56:15 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <8yasjxobc1o.fsf@huya.qualcomm.com>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<00ea01cba290$4d67f500$e837df00$%szyprowski@samsung.com>
	<20101223121917.GG3636@n2100.arm.linux.org.uk>
	<4D135004.3070904@samsung.com>
	<20101223134838.GK3636@n2100.arm.linux.org.uk>
	<4D1356D7.2000008@samsung.com>
	<20101223141608.GM3636@n2100.arm.linux.org.uk>
	<AANLkTinzsOom5awOr6Y8e7PKRbCWYQOqEbdw9is6HroR@mail.gmail.com>
	<8yasjxobc1o.fsf@huya.qualcomm.com>
Message-ID: <4D1870CF.6030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-12-23 19:04, David Brown wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> A generic solution (that I think I already proposed) would be to
>> reserve a chunk of memory for the CMA that can be removed from the
>> normally mapped kernel memory through memblock at boot time. The size
>> of this memory region would be configurable through kconfig. Then, the
>> CMA would have a "dma" flag or something, and take chunks out of it
>> until there's no more, and then return errors. That would work for
>> ARM.
> That sounds an awful lot like the Android kernel's pmem implementation.
>
> Solving this problem is important for us as well, but, I'm not sure I
> see a better solution that something like Felipe suggests.
>
Alas, until  the multiple mapping problem is solved, we're stuck. Right
now, as brought to us by Russell, dma-able memory must be uncached.
Can't see reasonable use of such a memory in system-wide manner yet, at
least on A8.
A9 has PIPT caches in the data hierarchy, so some workaround could be
not to use such memory for program text. But could it really?

Any ideas?
> The disadvantage, of course, being that the memory isn't available for
> the system when the user isn't doing the multi-media.
>
The CMA is intended to do this: multimedia memory doubles as movable
zone, but again - according to RMK the problem is real (we just haven't
run into it yet though). And it's no fun when the device goes to a crawl
due to swapping while a third of the physical memory lies unused.
> David
>
