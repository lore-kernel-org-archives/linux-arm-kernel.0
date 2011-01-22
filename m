From: ccross@google.com (Colin Cross)
Date: Fri, 21 Jan 2011 18:45:16 -0800
Subject: __arm_ioremap creates page table with domain set to kernel
Message-ID: <AANLkTi=iD_ipD=KBdgB+xT4dP2Yd7UYu1fmpQ4NO5OJx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_SMP is set, __arm_ioremap always creates a page table
mapping by calling ioremap_page_range in lib/ioremap.c, and passes it
the memory prot value but not the domain.  iormap_page_range
eventually calls pte_alloc_kernel, which sets the domain to
DOMAIN_KERNEL, instead of DOMAIN_IO.

The kernel domain is normally set to client, the same as the IO
domain, but it can get temporarily switched to manager mode.  When it
is in manager mode, it ignores the memory protection bits, and the
instruction prefetcher is allowed by the ARMv7 spec to ignore the XN
(eXecute Never) bit and fetch from IO memory.  I don't know that this
would ever actually occur, but the ARM spec says in B3.6.2:

The XN attribute is not checked for domains marked as Manager.
Read-sensitive memory must not be
included in domains marked as Manager, because the XN bit does not
prevent prefetches in these cases.

If this is a real problem, I don't see any quick fix.  The domain bits
are set in the pmd, so ioremapped memory can not share a pmd with
regular vmalloc memory, and ioremap_page_range has no way to carry a
domain to pte_alloc_kernel.
