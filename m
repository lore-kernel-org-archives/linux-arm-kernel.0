From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 13:59:06 +0100
Subject: [PATCH V2] arm64: mm: Optimise tlb flush logic where we have >4K
 granule
In-Reply-To: <20140502123011.GA4054@linaro.org>
References: <1399027034-1277-1-git-send-email-steve.capper@linaro.org>
 <20140502112618.GD17370@arm.com> <20140502123011.GA4054@linaro.org>
Message-ID: <20140502125906.GF17370@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 01:31:28PM +0100, Steve Capper wrote:
> On Fri, May 02, 2014 at 12:26:18PM +0100, Will Deacon wrote:
> > On Fri, May 02, 2014 at 11:37:14AM +0100, Steve Capper wrote:
> > > The tlb maintainence functions: __cpu_flush_user_tlb_range and
> > > __cpu_flush_kern_tlb_range do not take into consideration the page
> > > granule when looping through the address range, and repeatedly flush
> > > tlb entries for the same page when operating with 64K pages.
> > > 
> > > This patch re-works the logic s.t. we instead advance the loop by
> > >  1 << (PAGE_SHIFT - 12), so avoid repeating ourselves.
> > > 
> > > Also the routines have been converted from assembler to static inline
> > > functions to aid with legibility and potential compiler optimisations.
> > > 
> > > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > > Changed in V2: added the missing isb(.) to the kernel tlb flush.
> > 
> > Hold your horses ;)
> 
> :-)
> 
> > 
> > You mentioned remapping kernel text rw/ro, but if you think about it, it's
> > still executable for both of these, so the isb() isn't needed. Do we have a
> > case for changing whether or not something is executable?
> 
> I think module loading and unloading in future would likely need this.
> i.e. if we get stuff like set_memory_nx and friends for ARM64.
> 
> We've just had this added to ARM:
>  75374ad ARM: mm: Define set_memory_* functions for ARM

Ok, but if it's just set_memory_nx that needs this, I'd rather put the isb()
there instead of penalising all kernel TLB flushes.

Will
