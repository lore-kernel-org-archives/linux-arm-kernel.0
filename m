From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Oct 2011 11:08:21 +0100
Subject: [PATCH 6/9] drivers: add Contiguous Memory Allocator
In-Reply-To: <20111014165730.e98aee8a.akpm@linux-foundation.org>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-7-git-send-email-m.szyprowski@samsung.com>
	<20111014165730.e98aee8a.akpm@linux-foundation.org>
Message-ID: <20111016100821.GA21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 04:57:30PM -0700, Andrew Morton wrote:
> On Thu, 06 Oct 2011 15:54:46 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > +#ifdef phys_to_pfn
> > +/* nothing to do */
> > +#elif defined __phys_to_pfn
> > +#  define phys_to_pfn __phys_to_pfn
> > +#elif defined __va
> > +#  define phys_to_pfn(x) page_to_pfn(virt_to_page(__va(x)))
> > +#else
> > +#  error phys_to_pfn implementation needed
> > +#endif
> 
> Yikes!
> 
> This hackery should not be here, please.  If we need a phys_to_pfn()
> then let's write a proper one which lives in core MM and arch, then get
> it suitably reviewed and integrated and then maintained.

Another question is whether we have any arch where PFN != PHYS >> PAGE_SHIFT?
We've used __phys_to_pfn() to implement that on ARM (with a corresponding
__pfn_to_phys()).  Catalin recently added a cast to __phys_to_pfn() for
LPAE, which I don't think is required:

-#define        __phys_to_pfn(paddr)    ((paddr) >> PAGE_SHIFT)
+#define        __phys_to_pfn(paddr)    ((unsigned long)((paddr) >> PAGE_SHIFT))

since a phys_addr_t >> PAGE_SHIFT will be silently truncated if the passed
in physical address was 64-bit anyway.  (Note: we don't support > 32-bit
PFNs).

So, I'd suggest CMA should just use PFN_DOWN() and be done with it.
