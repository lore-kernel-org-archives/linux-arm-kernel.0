From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 13 Jan 2011 08:01:51 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <alpine.LFD.2.00.1101121357580.25498@xanadu.home>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<00ea01cba290$4d67f500$e837df00$%szyprowski@samsung.com>
	<20101223121917.GG3636@n2100.arm.linux.org.uk>
	<00ec01cba2a2$af20b8b0$0d622a10$%szyprowski@samsung.com>
	<20101223134432.GJ3636@n2100.arm.linux.org.uk>
	<001c01cbb289$864391f0$92cab5d0$%szyprowski@samsung.com>
	<alpine.LFD.2.00.1101121357580.25498@xanadu.home>
Message-ID: <002f01cbb2ef$c55c00a0$501401e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, January 12, 2011 8:04 PM Nicolas Pitre wrote:

> On Wed, 12 Jan 2011, Marek Szyprowski wrote:
> 
> > I understand that modifying L1 page tables is definitely not a proper way of
> > handling this. It simply costs too much. But what if we consider that the DMA
> > memory can be only allocated from a specific range of the system memory?
> > Assuming that this range of memory is known during the boot time, it CAN be
> > mapped with two-level of tables in MMU. First level mapping will stay the
> > same all the time for all processes, but it would be possible to unmap the
> > pages required for DMA from the second level mapping what will be visible
> > from all the processes at once.
> 
> How much memory are we talking about?  What is the typical figure?

One typical scenario we would like to support is full-hd decoding. One frame is
about 4MB (1920x1080x2 ~= 4MB). Depending on the codec, it may require up to 15
buffers what gives about 60MB. This simple calculation does not include memory
for the framebuffer, temporary buffers for the hardware codec and buffers for 
the stream.

> > Is there any reason why such solution won't work?
> 
> It could work indeed.
> 
> One similar solution that is already in place is to use highmem for that
> reclaimable DMA memory.  It is easy to ensure affected highmem pages are
> not mapped in kernel space.  And you can decide at boot time how many
> highmem pages you want even if the system has less that 1GB of RAM.

Hmmm, right, this might also help solving the problem.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
