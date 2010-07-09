From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 9 Jul 2010 22:55:31 +0530
Subject: Memory type used for ioremap
In-Reply-To: <20100709141416.GI22845@n2100.arm.linux.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
	<20100709141416.GI22845@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181D42@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Jul 09, 2010 at 07:32:46PM +0530, Pedanekar, Hemant wrote:
>> Catalin,
> 
> It'd help if I could see more of your mail than just the above when
> replying to it.  Please wrap your messages rather than typing entire
> paragraphs on one single line.
> 
> <save this message, go back and read your original, re-edit reply>
>

Sorry for that. Here is the earlier reply:

I was trying to map peripheral region (memory mapped) and faced problem with
writes not working from kernel (ioremapped address), while writes using user
space (devmem2) worked fine.

This prompted me to check if there were any differences in mapping the region
when using devmem2 (mmap)and when using ioremap from kernel module. I observed
that, when mapped using devmem2, the 2nd level page descriptor had TEX[2:0]=0
while in case of ioremap, the entry had TEX[2:0]=0 (C & B were 0 in both the
cases).

As per ARM ARM, TEX=0 is "Strongly-ordered" while TEX=1 is "Normal" memory type,
but of course as Russell has explained in the other mail, I had ignored TRE
(assumed =0). So what could be wrong here? Why does userspace access work while
kernel space doesn't? Of course, after *hacking* 2nd level page descriptor
(ioremapped) entry to force TEX=0, I was able to write from kernel module!

Any inputs?
 
> I think your problem might be to do with how the interconnects work.
> Each different memory type can have a different memory map.  If your
> peripheral is _only_ visible via the strongly ordered memory type,
> then it won't be visible via (shared or non-shared) device or memory like
> mappings. 
> 
> We have had devices in the past where certain peripherals are only
> visible via non-shared device mappings.  Could this be one of them?
>

If I wanted to have mapping for "Strongly-ordered" memory type, is there any
function that I can use from driver? I guess 'ioremap' won't help here? Probably
I need to use MT_MEMORY_NONCACHED and do a static mapping?

> Without knowing more about the device you're using, in particular
> how the bus matrix is setup, there's no way to comment definitively.
> What does the documentation for your device say about the type of
> mappings required for this peripheral?

I will confirm and update but looks like I need to have "Strongly-ordered" type.

Thanks
-
Hemant
