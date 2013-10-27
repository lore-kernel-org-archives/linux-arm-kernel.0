From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Oct 2013 10:18:43 +0000
Subject: [RFC 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <20131025130839.GA9999@mudshark.cambridge.arm.com>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
 <20131025130839.GA9999@mudshark.cambridge.arm.com>
Message-ID: <20131027101843.GZ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 02:08:40PM +0100, Will Deacon wrote:
> Hi Laura,
> 
> On Wed, Jun 12, 2013 at 06:23:29PM +0100, Laura Abbott wrote:
> > Other architectures define various set_memory functions to allow
> > attributes to be changed (e.g. set_memory_x, set_memory_rw, etc.)
> > Currently, these functions are missing on ARM. Define these in an
> > appropriate manner for ARM.
> 
> [...]
> 
> > +int set_memory_ro(unsigned long addr, int numpages)
> > +{
> > +	unsigned long start = addr;
> > +	unsigned long size = PAGE_SIZE*numpages;
> > +	unsigned end = start + size;
> > +
> > +	apply_to_page_range(&init_mm, start, size, pte_set_ro, NULL);
> > +	dsb();
> > +	flush_tlb_kernel_range(start, end);
> 
> The TLB_WB flag gives you the dsb, so you don't need to code it explicitly
> here (same comment for the other occurrences in this patch).

The version I have here doesn't have the above as a plain function, but
uses a macro to create these.  It also checks that the memory start and
end are within the modules area to avoid any problems with it being used
elsewhere.  The date on those patches was the 17th June.
