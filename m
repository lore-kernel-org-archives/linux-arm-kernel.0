From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Jul 2014 14:58:43 +0200
Subject: memory leak in arm kvm
In-Reply-To: <1406314837.27055.25.camel@deneb.redhat.com>
References: <1406314837.27055.25.camel@deneb.redhat.com>
Message-ID: <20140730125843.GB11610@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 03:00:37PM -0400, Mark Salter wrote:
> I've been looking into a memory leak in the arm kvm code which has been
> seen on arm64 platforms. It seems there is a small (2-4MB depending on
> pagesize) leak when a guest is started and stopped. The leak is
> happening in arch/arm/kvm/mmu.c when kvm_free_stage2_pgd() tries to
> unmap everything and free the pgd allocation. The problem I see is that
> unmap_range() does not remove all the page references to the pgd so when
> free_pages() is called, the pages are not actually freed because of
> page->count > 1. Looking further, the call to unmap_range() only ever
> calls put_page() once for the pgd and then it bails out of the while
> loop. This happens because of the arm64 kvm_p?d_addr_end() macros. They
> are defined to the normal p?d_addr_end macros. On arm64 with 3-level
> page tables, pud_addr_end() simply advances to the end. With 2-level
> page tables, pud_addr_end() and pmd_addr_end() both advance to end. So
> when the bottom of the while loop in unmap_range() uses those to advance
> to next pmd or pud, the loop ends up exiting. I can get around this by
> open coding the  kvm_p?d_addr_end macros thusly:

Hi Mark,

Did you try this with the follwing commit (found in next branch of the
kvmarm tree on git.kernel.org) applied:

4f853a714bf16338ff5261128e6c7ae2569e9505
arm/arm64: KVM: Fix and refactor unmap_range

This was reported previously on the list so wondering if it isn't the
same issue:

https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010522.html

Thanks,
-Christoffer
