From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 12 Nov 2013 14:45:30 +0100
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <20131017101325.GD23462@arm.com>
References: <20131017.080523.1821831578701162178.hdoyu@nvidia.com><20131017101325.GD23462@arm.com>
Message-ID: <20131112.154530.1203401124062257324.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Please clarify a few points inlined.

Catalin Marinas <catalin.marinas@arm.com> wrote @ Thu, 17 Oct 2013 12:13:26 +0200:

> On Thu, Oct 17, 2013 at 06:05:23AM +0100, Hiroshi Doyu wrote:
> > I found a bit old discussion[1] about CPA support on ARM32(Cortex-A9).
> > 
> > It seesm that CPA API on ARM wasn't possible because maintaining
> > multiple pagetables under SMP is difficult. Instead currently we are
> > using precallocated memory via DMA API.
> > 
> > Is this situation still same for Cortex-A15 and ARM64? If the
> > mismatched aliasing problem doesn't happen, is CPA API feasible?
> 
> On ARMv7+LPAE and AArch64 we use separate TTBR1 for the kernel (linear)
> mapping so in theory you could implement change_page_attr(). The
> mismatched aliases restriction still exists but it is clarified on what
> is and isn't allowed (so you can have Normal non-cacheable and Normal
> cacheable aliases, as long as you take care of removing any dirty cache
> lines that could potentially corrupt your data). The DMA API already
> takes care of this.

In DMA API, creating a new map is done via ioremap_page_range() in
kernel virtual address space. OTOH, the removing is done via
unmap_kernel_range(). unmap_kernel_range() internally calls
flush_cache_all(). So as long as kernel linear mapping side cache is
kept clean, there's no risk that stale data(on linear side) is
written back to RAM(corruption). That's why ARM doesn't need CPA API
at all?

> So, is the DMA API not enough for what you need?

In DMA API, get_vm_area_caller() is used to allocate kernel virtual
range, and the size VMALLOC range can be a limit if aggressively
used. This is minor issue, though.
