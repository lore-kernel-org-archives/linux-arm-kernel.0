From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 27 Jun 2016 15:28:15 +0200
Subject: [PATCH 01/15] arm64: KVM: Merged page tables documentation
In-Reply-To: <1465297115-13091-2-git-send-email-marc.zyngier@arm.com>
References: <1465297115-13091-1-git-send-email-marc.zyngier@arm.com>
 <1465297115-13091-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160627132815.GG26498@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:58:21AM +0100, Marc Zyngier wrote:
> Since dealing with VA ranges tends to hurt my brain badly, let's
> start with a bit of documentation that will hopefully help
> understanding what comes next...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 45 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index f05ac27..00bc277 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -29,10 +29,49 @@
>   *
>   * Instead, give the HYP mode its own VA region at a fixed offset from
>   * the kernel by just masking the top bits (which are all ones for a
> - * kernel address).
> + * kernel address). We need to find out how many bits to mask.
>   *
> - * ARMv8.1 (using VHE) does have a TTBR1_EL2, and doesn't use these
> - * macros (the entire kernel runs at EL2).
> + * We want to build a set of page tables that cover both parts of the
> + * idmap (the trampoline page used to initialize EL2), and our normal
> + * runtime VA space, at the same time.
> + *
> + * Given that the kernel uses VA_BITS for its entire address space,
> + * and that half of that space (VA_BITS - 1) is used for the linear
> + * mapping, we can limit the EL2 space to the same size.

we can also limit the EL2 space to (VA_BITS - 1).

> + *
> + * The main question is "Within the VA_BITS space, does EL2 use the
> + * top or the bottom half of that space to shadow the kernel's linear
> + * mapping?". As we need to idmap the trampoline page, this is
> + * determined by the range in which this page lives.
> + *
> + * If the page is in the bottom half, we have to use the top half. If
> + * the page is in the top half, we have to use the bottom half:
> + *
> + * if (PA(T)[VA_BITS - 1] == 1)
> + *	HYP_VA_RANGE = [0 ... (1 << (VA_BITS - 1)) - 1]
> + * else
> + *	HYP_VA_RANGE = [(1 << (VA_BITS - 1)) ... (1 << VA_BITS) - 1]

Is this pseudo code or what am I looking at?  What is T?

I don't understand what this is saying.

Can this be written using known constructs such as hyp_idmap_end,
PHYS_OFFSET etc.?

And perhaps the pseudo code should define HYP_VA_SHIFT instead of the
range to simplify it,@least I'm confused.

> + *
> + * In practice, the second case can be simplified to
> + *	HYP_VA_RANGE = [0 ... (1 << VA_BITS) - 1]
> + * because we'll never get anything in the bottom range.

and now I'm more confused, are we not supposed to map the idmap in the
bottom range?  Is this part of the comment necessary?

> + *
> + * This of course assumes that the trampoline page exists within the
> + * VA_BITS range. If it doesn't, then it means we're in the odd case
> + * where the kernel idmap (as well as HYP) uses more levels than the
> + * kernel runtime page tables (as seen when the kernel is configured
> + * for 4k pages, 39bits VA, and yet memory lives just above that
> + * limit, forcing the idmap to use 4 levels of page tables while the
> + * kernel itself only uses 3). In this particular case, it doesn't
> + * matter which side of VA_BITS we use, as we're guaranteed not to
> + * conflict with anything.
> + *
> + * An alternative would be to always use 4 levels of page tables for
> + * EL2, no matter what the kernel does. But who wants more levels than
> + * strictly necessary?
> + *
> + * Thankfully, ARMv8.1 (using VHE) does have a TTBR1_EL2, and doesn't
> + * need any of this madness (the entire kernel runs at EL2).

Not sure how these two last paragraphs helps understanding what this
patch set is about to implement, as it seems to raise more questions
than answer them, but I will proceed to trying to read the code...


Thanks,
-Christoffer

>   */
>  #define HYP_PAGE_OFFSET_SHIFT	VA_BITS
>  #define HYP_PAGE_OFFSET_MASK	((UL(1) << HYP_PAGE_OFFSET_SHIFT) - 1)
> -- 
> 2.1.4
> 
