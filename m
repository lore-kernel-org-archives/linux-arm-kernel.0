From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Oct 2013 14:08:40 +0100
Subject: [RFC 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131025130839.GA9999@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Jun 12, 2013 at 06:23:29PM +0100, Laura Abbott wrote:
> Other architectures define various set_memory functions to allow
> attributes to be changed (e.g. set_memory_x, set_memory_rw, etc.)
> Currently, these functions are missing on ARM. Define these in an
> appropriate manner for ARM.

[...]

> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	unsigned long start = addr;
> +	unsigned long size = PAGE_SIZE*numpages;
> +	unsigned end = start + size;
> +
> +	apply_to_page_range(&init_mm, start, size, pte_set_ro, NULL);
> +	dsb();
> +	flush_tlb_kernel_range(start, end);

The TLB_WB flag gives you the dsb, so you don't need to code it explicitly
here (same comment for the other occurrences in this patch).

Will
