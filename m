From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jul 2015 18:16:07 +0100
Subject: [PATCH 12/18] arm64: cmpxchg: avoid "cc" clobber in ll/sc routines
In-Reply-To: <1436779519-2232-13-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-13-git-send-email-will.deacon@arm.com>
Message-ID: <20150721171607.GF7250@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:25:13AM +0100, Will Deacon wrote:
> We can perform the cmpxchg comparison using eor and cbnz which avoids
> the "cc" clobber for the ll/sc case and consequently for the LSE case
> where we may have to fall-back on the ll/sc code at runtime.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h | 14 ++++++--------
>  arch/arm64/include/asm/atomic_lse.h   |  4 ++--
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index 77d3aabf52ad..d21091bae901 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -96,14 +96,13 @@ __LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
>  
>  	asm volatile("// atomic_cmpxchg\n"
>  "1:	ldxr	%w1, %2\n"
> -"	cmp	%w1, %w3\n"
> -"	b.ne	2f\n"
> +"	eor	%w0, %w1, %w3\n"
> +"	cbnz	%w0, 2f\n"
>  "	stxr	%w0, %w4, %2\n"
>  "	cbnz	%w0, 1b\n"
>  "2:"
>  	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
> -	: "Ir" (old), "r" (new)
> -	: "cc");
> +	: "Lr" (old), "r" (new));

For the LL/SC case, does this make things any slower? We replace a cmp +
b.ne with two arithmetic ops (eor and cbnz, unless the latter is somehow
smarter). I don't think the condition flags usually need to be preserved
across an asm statement, so the "cc" clobber probably didn't make much
difference anyway.

-- 
Catalin
