From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2016 14:24:28 +0100
Subject: [RFC PATCH 4/7] arm64: tlbflush.h: add __tlbi() macro
In-Reply-To: <1471344312-26685-5-git-send-email-punit.agrawal@arm.com>
References: <1471344312-26685-1-git-send-email-punit.agrawal@arm.com>
 <1471344312-26685-5-git-send-email-punit.agrawal@arm.com>
Message-ID: <20160819132427.GD9893@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 11:45:09AM +0100, Punit Agrawal wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> As with dsb() and isb(), add a __tbli() helper so that we can avoid

Minor typo: s/__tbli/__tlbi/

> distracting asm boilerplate every time we want a TLBI. As some TLBI
> operations take an argument while others do not, some pre-processor is
> used to handle these two cases with different assembly blocks.
> 
> The existing tlbflush.h code is moved over to use the helper.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> [ rename helper to __tlbi, update commit log ]
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index b460ae2..d57a0be 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -25,6 +25,21 @@
>  #include <asm/cputype.h>
>  
>  /*
> + * Raw TLBI operations. Drivers and most kernel code should use the TLB
> + * management routines below in preference to these. Where necessary, these can
> + * be used to avoid asm() boilerplate.
> + *
> + * Can be used as __tlbi(op) or __tlbi(op, arg), depending on whether a
> + * particular TLBI op takes an argument or not. The macros below handle invoking
> + * the asm with or without the register argument as appropriate.
> + */
> +#define TLBI_0(op, arg)		asm ("tlbi " #op)
> +#define TLBI_1(op, arg)		asm ("tlbi " #op ", %0" : : "r" (arg))
> +#define TLBI_N(op, arg, n, ...)	TLBI_##n(op, arg)

Should this be prefixed with underscores, too?

Will
