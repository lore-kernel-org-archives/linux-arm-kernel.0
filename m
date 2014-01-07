From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Jan 2014 15:52:48 +0000
Subject: [PATCH] arm: SIGBUS on unsupported ARMv6 unaligned accesses
In-Reply-To: <1387304271-29226-1-git-send-email-robin.murphy@arm.com>
References: <1387304271-29226-1-git-send-email-robin.murphy@arm.com>
Message-ID: <20140107155243.GA3350@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 06:17:51PM +0000, Robin Murphy wrote:
> This patch changes the default behaviour for userspace alignment faults
> on v6 from silent fixup to SIGBUS. This only affects code that violates
> the v6 unaligned access model - bad assembly/JIT code or high-level
> language code in violation of the relevant language spec - which should
> be corrected rather than unwittingly relying on performance-degrading
> fixups. Fixup behaviour can still be controlled from boot parameters or
> at runtime for compatibility with existing incorrect software.
> 
> There will be no impact for v5 and earlier.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

People sholdn't be relying on transparent alignment fixups any more,
and anyone doing so is already doing something wrong and would benefit
from knowing about it.

Since nobody else has raised concerns, I would vote for going ahead
with this.


People running OABI userspace on v6 might fall foul of this, but I
think requiring them to pass an alignment= command line parameter
may be an acceptable compromise.  The alternative is to apply the
new default only if AEABI && !OABI_COMPAT.  But traditionally, most
people building with OABI_COMPAT=y are running EABI userspace anyway.
As you say, people running on v5 shouldn't be affected.

So,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

> ---
> 
> This is very much the hard-line approach to the issue, but userspace
> really shouldn't be depending on the ability to execute architecturally
> invalid code; ultimately this is an ABI that deserves to be broken.
> The only trouble with going in softly and just turning on the warning
> alone is that it should already be rare enough to be easily missed.
> "Break everything AND scream about it" as the default isn't going to
> make any friends, but does make bad code as visible as possible.
> 
> Anyone is of course free to turn warnings off, and/or fixups back on -
> defaulting to UM_SIGNAL on UM_IGNORE is to ensure fixup has to be
> explicitly requested, by which point they should be well aware of what
> they're doing and why.
> 
>  arch/arm/mm/alignment.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 9240364..9a93315 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -106,10 +106,10 @@ static int safe_usermode(int new_usermode, bool warn)
>  	 * making any progress.
>  	 */
>  	if (cpu_is_v6_unaligned() && !(new_usermode & (UM_FIXUP | UM_SIGNAL))) {
> -		new_usermode |= UM_FIXUP;
> +		new_usermode |= UM_SIGNAL;
>  
>  		if (warn)
> -			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.\n");
> +			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.  Defaulting to signal mode.\n");
>  	}
>  
>  	return new_usermode;
> @@ -971,7 +971,7 @@ static int __init alignment_init(void)
>  		cr_alignment &= ~CR_A;
>  		cr_no_alignment &= ~CR_A;
>  		set_cr(cr_alignment);
> -		ai_usermode = safe_usermode(ai_usermode, false);
> +		ai_usermode = safe_usermode(ai_usermode | UM_WARN, false);
>  	}
>  #endif
>  
> -- 
> 1.7.9.5
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
