From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 19:59:29 +0000
Subject: [PATCH] ARM: Fix compile after delay page freeing patch
In-Reply-To: <20110222194332.GQ15225@atomide.com>
References: <20110222194332.GQ15225@atomide.com>
Message-ID: <20110222195929.GA31275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 11:43:32AM -0800, Tony Lindgren wrote:
> Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
> (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
> the following compile error for at least omap1_defconfig:
> 
> In file included from arch/arm/mm/init.c:27:
> arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
> arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'

Grant already mentioned this to me this evening.

This happens if you build with CONFIG_SWAP=n, and is something that the
asm-generic/tlb.h also appears to suffer from.  Why no one else has
noticed this I've no idea.

Note that linux/swap.h has this comment:

/* only sparc can not include linux/pagemap.h in this file
 * so leave page_cache_release and release_pages undeclared... */
#define free_page_and_swap_cache(page) \
        page_cache_release(page)
#define free_pages_and_swap_cache(pages, nr) \
        release_pages((pages), (nr), 0);

which is rather annoying, because it makes the build error dependent on
the configuration.

So, we should add linux/pagemap.h to both asm-generic/tlb.h and the ARM
tlb.h as they both should suffer the same problem.

Note that arch/x86/mm/init.c and arch/x86/mm/pgtable.c both include
asm/tlb.h without linux/pagemap.h, and use the generic version.  I bet
no one's tried building x86 with CONFIG_SWAP=n yet...
