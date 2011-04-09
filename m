From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 9 Apr 2011 17:10:52 +0200
Subject: V4L/ARM: videobuf-dma-contig no longer works on my ARM machine
In-Reply-To: <20110409071624.GE5573@n2100.arm.linux.org.uk>
References: <201009301335.51643.jkrzyszt@tis.icnet.pl>
	<201104090333.52312.jkrzyszt@tis.icnet.pl>
	<20110409071624.GE5573@n2100.arm.linux.org.uk>
Message-ID: <201104091711.00191.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(CC: Jiri Slaby, the author of the problematic change; truncate subject)

On Sat, 09 Apr 2011, at 09:16:24, Russell King - ARM Linux wrote:
> On Sat, Apr 09, 2011 at 03:33:39AM +0200, Janusz Krzysztofik wrote:
> > Since there were no actual problems reported before, I suppose the
> > old code, which was passing to remap_pfn_range() a physical page
> > number calculated from dma_alloc_coherent() privided dma_handle,
> > worked correctly on all platforms actually using
> > videobud-dma-config. Now, on my ARM machine, a completely
> > different, then completely wrong physical address, calculated as
> > virt_to_phys(dma_alloc_coherent()), is used instead of the
> > dma_handle, which causes the machine to hang.
> 
> virt_to_phys(dma_alloc_coherent()) is and always has been invalid,
> and will break on several architectures apart from ARM.

Hi Russell,
Thanks for confirmation.

For now, I have two working, but not very elegant, solutions:

1. For architectures which provide dma_mmap_coherent() (only ARM for 
now), use it instead of remap_pfn_range(). However, this requires 
setting vma->vm_pgoff to 0 before calling dma_mmap_coherent(). I don't 
really understand what this vma->vm_pgoff business is all about, I've 
only verified that:

a) a non-zero value, comming with any but the first buffer, for a reason 
not quite clear to me, breaks comparison of the requested vma size, 
calculated as:
	(vma->vm_end - vma->vm_start) >> PAGE_SHIFT
with the just allocated arm_vmregion avaliable space, calculated as:
	((c->vm-end - c->vm_start) >> PAGE_SHIFT) - vma->vm_pgoff

b) vma->vm_pgoff is overwriten, for a reason not quite clear to me, by 
remap_pfn_range() called from dma_mmap_coherent(), so first resetting 
its value to 0 should not affect anything else but dma_mmap_coherent().

If someone can explain me how this vm_pgoff handling inconsistency 
should be fixed without dirty hacks, I can try to implement it.

2. Use depreciated bus_to_virt(dma_handle) instead of mem->vaddr, like 
this:
	remap_pfn_range(..., 
		PFN_DOWN(virt_to_phys(bus_to_virt(dma_handle))), ...)

If 1. is acceppted, then 2. may still be considered for architectures 
which neither support virt_to_phys(dma_alloc_coherent()) nor provide 
their own dma_mmap_coherent() implementation.

Thanks,
Janusz
