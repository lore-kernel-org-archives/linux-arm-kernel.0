From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2016 10:03:26 +0000
Subject: [PATCH v2] arm64: lse: deal with clobbered x16 register after
 branch via PLT
In-Reply-To: <1456429733-20825-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456429733-20825-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160226100325.GB29125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Ard,

On Thu, Feb 25, 2016 at 08:48:53PM +0100, Ard Biesheuvel wrote:
> The LSE atomics implementation uses runtime patching to patch in calls
> to out of line non-LSE atomics implementations on cores that lack hardware
> support for LSE. To avoid paying the overhead cost of a function call even
> if no call ends up being made, the bl instruction is kept invisible to the
> compiler, and the out of line implementations preserve all registers, not
> just the ones that they are required to preserve as per the AAPCS64.
> 
> However, commit fd045f6cd98e ("arm64: add support for module PLTs") added
> support for routing branch instructions via veneers if the branch target
> offset exceeds the range of the ordinary relative branch instructions.
> Since this deals with jump and call instructions that are exposed to ELF
> relocations, the PLT code uses x16 to hold the address of the branch target
> when it performs an indirect branch-to-register, something which is
> explicitly allowed by the AAPCS64 (and ordinary compiler generated code
> does not expect register x16 or x17 to retain their values across a bl
> instruction).
> 
> Since the lse runtime patched bl instructions don't adhere to the AAPCS64,
> they don't deal with this clobbering of registers x16 and x17. So add them
> to the clobber list of the asm() statements that perform the call
> instructions, and drop x16 and x17 from the list of registers that are
> caller saved in the out of line non-LSE implementations.
> 
> In addition, since we have given these functions two scratch registers,
> they no longer need to stack/unstack temp registers, and the only remaining
> stack accesses are for the frame pointer. So pass -fomit-frame-pointer as
> well, this eliminates all stack accesses from these functions.

[...]

> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 197e06afbf71..7af60139f718 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -36,7 +36,7 @@ static inline void atomic_andnot(int i, atomic_t *v)
>  	"	stclr	%w[i], %[v]\n")
>  	: [i] "+r" (w0), [v] "+Q" (v->counter)
>  	: "r" (x1)
> -	: "x30");
> +	: "x16", "x17", "x30");
>  }

The problem with this is that we potentially end up spilling/reloading
x16 and x17 even when we patch in the LSE atomic. That's why I opted for
the explicit stack accesses in my patch, so that they get overwritten
with NOPs when we switch to the LSE version.

Will
