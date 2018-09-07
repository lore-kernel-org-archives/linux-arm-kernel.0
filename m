From: steve.capper@arm.com (Steve Capper)
Date: Fri, 7 Sep 2018 15:04:39 +0100
Subject: [PATCH 3/5] arm64: mm: Copy over arch_get_unmapped_area
In-Reply-To: <0b6b0dba-b8ae-3e8d-68d1-6b93dfb777c0@redhat.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
 <20180829124543.25314-4-steve.capper@arm.com>
 <0b6b0dba-b8ae-3e8d-68d1-6b93dfb777c0@redhat.com>
Message-ID: <20180907140439.5ji2c2fdxhvzzv32@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 02:15:32AM -0400, Jon Masters wrote:
> On 08/29/2018 08:45 AM, Steve Capper wrote:
> 
> > In order to support 52-bit VAs for userspace we need to alter the mmap
> > area choosing logic to give 52-bit VAs where "high" addresses are
> > requested.
> 
> <snip>
> 
> > +unsigned long
> > +arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
> > +			  const unsigned long len, const unsigned long pgoff,
> > +			  const unsigned long flags)
> 
> <snip>
> 
> > +	/* requested length too big for entire address space */
> > +	if (len > TASK_SIZE - mmap_min_addr)
> > +		return -ENOMEM;
> > +
> > +	if (flags & MAP_FIXED)
> > +		return addr;
> 
> arch/x86/mm/mmap.c:
> 
>  *  With 5-level paging this request would be granted and result in a
>  *  mapping which crosses the border of the 47-bit virtual address
>  *  space. If the application cannot handle addresses above 47-bit this
>  *  will lead to misbehaviour and hard to diagnose failures.
>  *
>  * Therefore ignore address hints which would result in a mapping
>  * crossing the 47-bit virtual address boundary.
> 
> You'll probably want something similar above.
>

Thanks Jon, I'll roll this into a future patch.

Cheers,
-- 
Steve
