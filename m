From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 15 Jul 2010 22:10:28 -0400 (EDT)
Subject: Question of kmap_atomic
In-Reply-To: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
References: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1007152200520.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jul 2010, Minchan Kim wrote:

> I am stuck with looking at ARM's kmap_atomic.
> I am not familiar with ARM cache model.
> As I look the code, ARM seems to have a VIPT aliasing model.

There are VIPT as well as VIVT models available.

> Before Nicolas's 17ebba1fe, kmap_atomic always calls kmap_high_get to
> prevent aliasing problem of 7929eb9cf64 regardless of VIVT and VIPT.

The aliasing issue is fundamental for VIVT.  But on VIPT it is also 
advantageous to reuse a kmap entry if possible as this saves on the PTE 
setup and TLB flush that is required otherwise.

> But the patch made it to not call kmap_high_get when VIPT-aliasing
> model in CONFIG_DEBUG_HIGHMEM.
> Doesn't it cause aliasing problem as 7929eb9cf64 says, again?

No because with VIPT, the cache is tagged with physical addresses, and 
therefore the same cache data will be used for the same memory 
regardless of the virtual address used to reach it.  On VIVT this is not 
the case and the comment in 7929eb9cf64 applies to VIVT only.


Nicolas
