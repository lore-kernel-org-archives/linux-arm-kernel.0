From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Nov 2011 16:59:05 +0000
Subject: [PATCH v8 15/16] ARM: LPAE: add support for ATAG_MEM64
In-Reply-To: <4EB95ECB.8060905@codeaurora.org>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
 <4EB95ECB.8060905@codeaurora.org>
Message-ID: <20111108165905.GF10506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 04:54:35PM +0000, Stephen Boyd wrote:
> On 11/7/2011 8:16 AM, Catalin Marinas wrote:
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 7e7977a..223af71 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -638,6 +638,29 @@ static int __init parse_tag_mem32(const struct tag *tag)
> >  
> >  __tagtable(ATAG_MEM, parse_tag_mem32);
> >  
> > +static int __init parse_tag_mem64(const struct tag *tag)
> > +{
> > +	/* We only use 32-bits for the size. */
> > +	unsigned long size;
> > +	phys_addr_t start, end;
> > +
> > +	start = tag->u.mem64.start;
> > +	size = tag->u.mem64.size;
> > +	end = start + size;
> > +
> > +	/* Ensure that the memory region is in range. */
> > +	if (end & ~PHYS_MASK)
> > +		pr_warning("Ignoring out-of-range mem64 tag (%.8llx-%.8llx)\n",
> 
> Can you add 0x (or #) here so we can see the 0x hex part?

There are some inconsistencies across the kernel, we just used the
printk format found in sanity_check_meminfo(). I don't have a problem
with changing this, though maybe some separate clean-up patch would be
better.

-- 
Catalin
