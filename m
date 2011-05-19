From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 May 2011 09:56:21 +0100
Subject: [PATCH] ARM: sparsemem: fix highmem detection when using SPARSEMEM
In-Reply-To: <alpine.LFD.2.00.1105181341320.14430@xanadu.home>
References: <1305734711-6710-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1105181341320.14430@xanadu.home>
Message-ID: <1305795381.29560.10.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-18 at 18:42 +0100, Nicolas Pitre wrote:
> On Wed, 18 May 2011, Will Deacon wrote:
> 
> > sanity_check_meminfo walks over the registered memory banks and attempts
> > to split banks across lowmem and highmem when they would otherwise
> > overlap with the vmalloc space.
> >
> > When SPARSEMEM is used, there are two potential problems that occur
> > when the virtual address of the start of a bank is equal to vmalloc_min.
> >
> >  1.) The end of lowmem is calculated as __pa(vmalloc_min - 1) + 1.
> >      In the above scenario, this will give the end address of the
> >      previous bank, rather than the actual bank we are interested in.
> >      This value is later used as the memblock limit and artificially
> >      restricts the total amount of available memory.
> >
> >  2.) The checks to determine whether or not a bank belongs to highmem
> >      or not only check if __va(bank->start) is greater or less than
> >      vmalloc_min. In the case that it is equal, the bank is incorrectly
> >      treated as lowmem, which hoses the vmalloc area.
> >
> > This patch fixes these two problems by checking whether the virtual
> > start address of a bank is >= vmalloc_min and then calculating
> > lowmem_end by finding the virtual end address of the highest lowmem
> > bank.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks Nicolas!

Will
