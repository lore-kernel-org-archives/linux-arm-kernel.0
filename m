From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jan 2013 19:13:55 +0000
Subject: [PATCH 2/2] ARM: memory: define TASK_UNMAPPED_BASE in terms of
 TASK_SIZE
In-Reply-To: <alpine.LFD.2.02.1301301352180.6300@xanadu.home>
References: <1359554912-26872-1-git-send-email-will.deacon@arm.com>
 <1359554912-26872-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1301301352180.6300@xanadu.home>
Message-ID: <20130130191355.GM7484@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 06:57:24PM +0000, Nicolas Pitre wrote:
> On Wed, 30 Jan 2013, Will Deacon wrote:
> 
> > TASK_UNMAPPED_BASE is defined directly in terms of PAGE_OFFSET, which is
> > confusing given that the modules area sits between here and TASK_SIZE
> > and is not available for user allocations.
> > 
> > This patch defines TASK_UNMAPPED_BASE in terms of TASK_SIZE instead and
> > fixes a bug introduced by 394ef6403abc ("mm: use vm_unmapped_area() on
> > arm architecture") whereby TASK_UNMAPPED_BASE is no longer page-aligned
> > for bottom-up mmap, causing get_unmapped_area to choke on misaligned
> > addresses.
> > 
> > Reported-by: Christoffer Dall <cdall@cs.columbia.edu>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/memory.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index a0fd518..255a01b 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -37,7 +37,7 @@
> >   */
> >  #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
> >  #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
> > -#define TASK_UNMAPPED_BASE	(UL(CONFIG_PAGE_OFFSET) / 3)
> > +#define TASK_UNMAPPED_BASE	((TASK_SIZE / 3) & ~UL(SZ_16M - 1))
> 
> Please round this up not down.  In most cases, TASK_SIZE is 0xbf000000 
> which is not nicely divisible by 3, unlike PAGE_OFFSET was.  By rounding 
> up you get a nice 0x40000000 as before.

Sure, I think ALIGN does that for us, so I can use that instead.

Cheers,

Will
