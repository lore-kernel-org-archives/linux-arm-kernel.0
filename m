From: vrex@nvidia.com (Vinod Rex)
Date: Wed, 21 Sep 2011 15:10:01 -0700
Subject: change_page_attr() implementation for ARM?
Message-ID: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Cortex-A9, we have observed stale data being read from write-combine (C=0 B=1) memory regions mapped into userspace which have a duplicate cacheable mapping in the kernel address space (due to the kernel linear mapping).

The issue appears to be due to speculative prefetch on the cacheable kernel linear mapping which gets lines into the L2 cache. When reads are performed on the write-combine mapping for this address range, these reads get the stale data from L2 instead of memory.

As per the Cortex-A9 spec, behavior for double mappings with conflicting page attributes is undefined, so we need a way to make sure all duplicate mappings have the same memory type attributes. 

Similar issue on x86 is handled using the change_page_attr()/set_memory_*() functions defined in arch/x86/mm/pageattr.c. ?This function modifies the attributes of the page in kernel linear map to match the corresponding mapping in userspace to avoid having duplicate mappings with different page attributes. It accomplishes this by splitting section (large page) mappings into 4KB page mappings as needed so that the page attribute change is done only for the requested memory region.

Would a similar implementation for ARM be appropriate? We are experimenting with a port of change_page_attr() to ARM that seems to solve our problems.

Other approaches proposed to solve this on ARM, by remapping CMA reserved region using 4KB page mappings will not help us since IOMMU mappings don't use DMA contiguous allocation routines.
