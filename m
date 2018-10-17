From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 17 Oct 2018 09:48:15 -0700
Subject: [PATCH V2 1/4] mm: mmap: Allow for "high" userspace addresses
In-Reply-To: <20181017163459.20175-2-steve.capper@arm.com>
References: <20181017163459.20175-1-steve.capper@arm.com>
 <20181017163459.20175-2-steve.capper@arm.com>
Message-ID: <20181017164815.GA7966@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 05:34:56PM +0100, Steve Capper wrote:
> This patch adds support for "high" userspace addresses that are
> optionally supported on the system and have to be requested via a hint
> mechanism ("high" addr parameter to mmap).
> 
> Rather than duplicate the arch_get_unmapped_* stock implementations,
> this patch instead introduces two architectural helper macros and
> applies them to arch_get_unmapped_*:
>  arch_get_mmap_end(addr) - get mmap upper limit depending on addr hint
>  arch_get_mmap_base(addr, base) - get mmap_base depending on addr hint
> 
> If these macros are not defined in architectural code then they default
> to (TASK_SIZE) and (base) so should not introduce any behavioural
> changes to architectures that do not define them.

Can you explain (in the changelog) why we need to do this for arm64
when it wasn't needed for the equivalent feature on x86-64?  I think the
answer is that x86-64 already has its own arch_get_unmapped* functions and
rather than duplicating arch_get_unmapped* for arm64, you want to continue
using the generic ones with just this minor hooking.  But I'd like that
spelled out explicitly for the next person who comes along and wonders.
