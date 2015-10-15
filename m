From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 11:37:38 +0100
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <561F736A.4000308@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
 <20151014170759.GE5041@leverpostej> <561F736A.4000308@arm.com>
Message-ID: <20151015103738.GC8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 10:35:38AM +0100, Suzuki K. Poulose wrote:
> On 14/10/15 18:07, Mark Rutland wrote:
> >On Wed, Oct 14, 2015 at 12:20:26PM +0100, Suzuki K. Poulose wrote:
> 
> >>+ * Number of page-table levels required to address 'va_bits' wide
> >>+ * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
> >>+ * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
> >>+ *
> >>+ *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
> >>+ *
> >>+ * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
> >>+ * due to build issues. So we use the following magic formula.
> >>+ */
> >>+#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
> >
> >I think I failed the interview question [1]. :(
> >
> >I read the comment to mean this was a brand-new piece of magic, as
> >opposed to a constant-folded copy of DIV_ROUND_UP. So it seems there's
> >still some scope for confusion, even if that only includes me.
> >
> 
> Wouldn't it be better to modify the comment to say, we open coded the DIV_ROUND_UP ?
> We could potentially end up in a conflict if somebody else does __DIV_ROUND_UP.
> I have seen similar issues with the CPU feature series, where if I include one
> particular header file in another, kernel build breaks without giving you a clue,
> what caused the error. Usually due to the multiple definitions (e.g NSEC_PER_SEC)
> and other conflicts. Given that this header file gets included with asm/page.h and
> hence would be used included for people outside arch/arm64, I would prefer, not to
> head there, instead update the comment, something like this :
> 
> 
> /*
>  * Number of page-table levels required to address 'va_bits' wide
>  * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
>  * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
>  *
>  *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
>  *
>  * where DIV_ROUND_UP (n, d) = > ((n) + (d) - 1) / (d)
>  *
>  * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
>  * due to build issues. So we open code the DIV_ROUND_UP and hence
>  * we get :
>  *  ((va_bits - PAGE_SHIFT) + (PAGE_SHIFT - 3) -1) / (PAGE_SHIFT - 3)
>  *
>  * which gets simplified as :
>  *  (((va_bits) - 4) / (PAGE_SHIFT - 3))
>  *
>  */
> 
> Let me know if you are happy with that ?

I am also happy with this. For the above, feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
