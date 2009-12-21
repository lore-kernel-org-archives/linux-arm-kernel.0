From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 21 Dec 2009 11:56:23 +0530
Subject: CPU consumption is going as high as 95% on ARM Cortex A8
In-Reply-To: <20091217095641.GA399@n2100.arm.linux.org.uk>
References: <19F8576C6E063C45BE387C64729E73940449F43857@dbde02.ent.ti.com>
	<20091217095641.GA399@n2100.arm.linux.org.uk>
Message-ID: <19F8576C6E063C45BE387C64729E73940449F43E29@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, December 17, 2009 3:27 PM
> To: Hiremath, Vaibhav
> Cc: linux-arm-kernel at lists.infradead.org; linux-mm at kvack.org; linux-
> omap at vger.kernel.org
> Subject: Re: CPU consumption is going as high as 95% on ARM Cortex
> A8
> 
> On Thu, Dec 17, 2009 at 11:08:31AM +0530, Hiremath, Vaibhav wrote:
> > Issue/Usage :-
> > -------------
> > The V4l2-Capture driver captures the data from video decoder into
> buffer
> > and the application does some processing on this buffer. The mmap
> > implementation can be found at drivers/media/video/videobuf-dma-
> contig.c,
> > function__videobuf_mmap_mapper().
> 
>         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> will result in the memory being mapped as 'Strongly Ordered',
> resulting
> in there being multiple mappings with differing types.  In later
> kernels, we have pgprot_dmacoherent() and I'd suggest changing the
> above
> macro for that.
> 
[Hiremath, Vaibhav] Russell,

I tried with your suggestion above but unfortunately it didn't work for me. I am seeing the same behavior with the pgprot_dmacoherent(). I pulled your patch (which got applied cleanly on 2.6.32-rc5) -

-----------------------------------------
commit 26a26d329688ab018e068b412b03d43d7c299f0a
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Nov 20 21:06:43 2009 +0000

Subject: ARM: dma-mapping: switch ARMv7 DMA mappings to retain 'memory' attribute
-----------------------------------------

Any other pointers/suggestions?

Thanks,
Vaibhav

> > Without PAGE_READONLY/PAGE_SHARED
> >
> > Important bits are [0-9] - 0x383
> >
> > With PAGE_READONLY/PAGE_SHARED set
> >
> > Important bits are [0-9] - 0x38F
> 
> So the difference is the C and B bits, which is more or less
> expected
> with the change you've made.
> 
> >
> > The lines inside function "cpu_v7_set_pte_ext", is using the flag
> as shown below -
> >
> >    tst     r1, #L_PTE_USER
> >    orrne   r3, r3, #PTE_EXT_AP1
> >    tstne   r3, #PTE_EXT_APX
> >    bicne   r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> >
> > Without PAGE_READONLY/PAGE_SHARED		With flags set
> >
> > Access perm = reserved				Access Perm = Read
> Only
> 
> The bits you quote above are L_PTE_* bits, so you need to be careful
> decoding them.  0x383 gives
> 
> 	L_PTE_EXEC|L_PTE_USER|L_PTE_WRITE|L_PTE_YOUNG|L_PTE_PRESENT
> 
> which is as expected, and will be translated into: APX=0 AP1=1 AP0=0
> which is user r/o, system r/w.  The same will be true of 0x38f.
> 
> > - I tried the same thing with another platform (ARM9) and it works
> fine there.
> >
> > Can somebody help me to understand the flag
> PAGE_SHARED/PAGE_READONLY
> > and access permissions? Am I debugging this into right path? Does
> > anybody have seen/observed similar issue before?
> 
> I think you're just seeing the effects of 'strongly ordered' memory
> rather than anything actually wrong.
