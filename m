From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 16:30:24 +0100
Subject: [PATCH 1/3] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <20140502140709.GA6780@linaro.org>
References: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
 <1397782023-28114-2-git-send-email-lauraa@codeaurora.org>
 <20140502140709.GA6780@linaro.org>
Message-ID: <20140502153023.GH17370@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 03:07:11PM +0100, Steve Capper wrote:
> On Thu, Apr 17, 2014 at 05:47:01PM -0700, Laura Abbott wrote:
> > In a similar fashion to other architecture, add the infrastructure
> > and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
> > enabled, module ranges will be marked read-only/no-execute as
> > appropriate.
> > 
> > Change-Id: I4251a0929b1fe6f43f84b14f0a64fed30769700e
> > Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> > ---
> 
> [ ... ]
> 
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > new file mode 100644
> > index 0000000..e48f980
> > --- /dev/null
> > +++ b/arch/arm64/mm/pageattr.c
> 
> [ ... ]
> 
> > +static int change_memory_common(unsigned long addr, int numpages,
> > +				pgprot_t prot, bool set)
> > +{
> > +	unsigned long start = addr;
> > +	unsigned long size = PAGE_SIZE*numpages;
> > +	unsigned long end = start + size;
> > +	int ret;
> > +
> > +	if (start < MODULES_VADDR || start >= MODULES_END)
> > +		return -EINVAL;
> > +
> > +	if (end < MODULES_VADDR || end >= MODULES_END)
> > +		return -EINVAL;
> > +
> > +	if (set)
> > +		ret = apply_to_page_range(&init_mm, start, size,
> > +					set_page_range, (void *)prot);
> > +	else
> > +		ret = apply_to_page_range(&init_mm, start, size,
> > +					clear_page_range, (void *)prot);
> > +
> > +	flush_tlb_kernel_range(start, end);
> 
> Could you please add an isb() here? (We're about to nuke the one in
> flush_tlb_kernel_range).

Thinking about this even more (too much?), how does this work with SMP
anyway? You need each CPU to execute an isb(), so this just a race that
is dealt with already (probably treated as benign)?

Will
