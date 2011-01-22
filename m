From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 21 Jan 2011 22:37:02 -0500 (EST)
Subject: __arm_ioremap creates page table with domain set to kernel
In-Reply-To: <AANLkTi=iD_ipD=KBdgB+xT4dP2Yd7UYu1fmpQ4NO5OJx@mail.gmail.com>
References: <AANLkTi=iD_ipD=KBdgB+xT4dP2Yd7UYu1fmpQ4NO5OJx@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101212232000.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jan 2011, Colin Cross wrote:

> If CONFIG_SMP is set, __arm_ioremap always creates a page table
> mapping by calling ioremap_page_range in lib/ioremap.c, and passes it
> the memory prot value but not the domain.  iormap_page_range
> eventually calls pte_alloc_kernel, which sets the domain to
> DOMAIN_KERNEL, instead of DOMAIN_IO.
> 
> The kernel domain is normally set to client, the same as the IO
> domain, but it can get temporarily switched to manager mode.  When it
> is in manager mode, it ignores the memory protection bits, and the
> instruction prefetcher is allowed by the ARMv7 spec to ignore the XN
> (eXecute Never) bit and fetch from IO memory.  I don't know that this
> would ever actually occur, but the ARM spec says in B3.6.2:
> 
> The XN attribute is not checked for domains marked as Manager.
> Read-sensitive memory must not be
> included in domains marked as Manager, because the XN bit does not
> prevent prefetches in these cases.
> 
> If this is a real problem, I don't see any quick fix.  The domain bits
> are set in the pmd, so ioremapped memory can not share a pmd with
> regular vmalloc memory, and ioremap_page_range has no way to carry a
> domain to pte_alloc_kernel.

This has been fixed already. Have a look at:

|commit 247055aa21ffef1c49dd64710d5e94c2aee19b58
|Author: Catalin Marinas <catalin.marinas@arm.com>
|Date:   Mon Sep 13 16:03:21 2010 +0100
|
|    ARM: 6384/1: Remove the domain switching on ARMv6k/v7 CPUs
|
|[...]


Nicolas
