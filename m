From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 9 Jul 2010 19:32:46 +0530
Subject: Memory type used for ioremap
In-Reply-To: <1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

I was trying to map peripheral region (memory mapped) nd faced problem with writes not working from kernel (ioremapped address), while writes using user space (devmem2) worked fine.

This prompted me to check if there were any differences in mapping the region when using devmem2 (mmap)and when using ioremap from kernel module. I observed that, when mapped using devmem2, the 2nd level page descriptor had TEX[2:0]=0 while in case of ioremap, the entry had TEX[2:0]=0 (C & B were 0 in both the cases).

As per ARM ARM, TEX=0 is "Strongly-ordered" while TEX=1 is "Normal" memory type, but of course as Russell has explained in the other mail, I had ignored TRE (assumed =0). So what could be wrong here? Why does userspace access work while kernel space doesn't? Of course, after *hacking* 2nd level page descriptor (ioremapped) entry to force TEX=0, I was able to write from kernel module!

Any inputs?

Thanks
-
Hemant
 
 

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
> Sent: Friday, July 09, 2010 5:41 PM
> To: Pedanekar, Hemant
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Memory type used for ioremap
> 
> On Fri, 2010-07-09 at 03:16 +0100, Pedanekar, Hemant wrote:
> > I have few doubts regarding the memory type configured when we call
> > ioremap for mapping a region (e.g., on-chip peripheral MMRs):
> >  
> > Please note that this is regarding Cortx A8.
> >  
> > After examining 2nd level page descriptor, I see that the 
> memory type
> > configured for ioremapped region (as per TEX[2:0]=1 and CB=0) is
> > "Outer and Inner Non-cacheable - Normal". Is this correct
> > observation? I thought the ioremap would set memory type as 
> one of the
> > "Device". 
> >  
> > What is the recommended method if I want to map some region as
> > "Strongly-ordered" or "Device"?
> 
> If you are trying to ioremap normal RAM, we no longer allow this and
> force the memory type to be Normal Non-cacheable. This is an ARM
> architecture requirement (otherwise you create mismatched memory
> attributes aliases).
> 
> 
> -- 
> Catalin
> 
> 
