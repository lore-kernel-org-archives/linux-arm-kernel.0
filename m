From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Mar 2018 13:33:46 +0100
Subject: [PATCH v2 2/2] arm64: uaccess: Fix omissions from usercopy
 whitelist
In-Reply-To: <1522230649-22008-3-git-send-email-Dave.Martin@arm.com>
References: <1522230649-22008-1-git-send-email-Dave.Martin@arm.com>
 <1522230649-22008-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180328123345.GE30850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 10:50:49AM +0100, Dave Martin wrote:
> When the hardend usercopy support was added for arm64, it was
> concluded that all cases of usercopy into and out of thread_struct
> were statically sized and so didn't require explicit whitelisting
> of the appropriate fields in thread_struct.
> 
> Testing with usercopy hardening enabled has revealed that this is
> not the case for certain ptrace regset manipulation calls on arm64.
> This occurs because the sizes of usercopies associated with the
> regset API are dynamic by construction, and because arm64 does not
> always stage such copies via the stack: indeed the regset API is
> designed to avoid the need for that by adding some bounds checking.
> 
> This is currently believed to affect only the fpsimd and TLS
> registers.
> 
> Because the whitelisted fields in thread_struct must be contiguous,
> this patch groups them together in a nested struct.  It is also
> necessary to be able to determine the location and size of that
> struct, so rather than making the struct anonymous (which would
> save on edits elsewhere) or adding an anonymous union containing
> named and unnamed instances of the same struct (gross), this patch
> gives the struct a name and makes the necessary edits to code that
> references it (noisy but simple).
> 
> Care is needed to ensure that the new struct does not contain
> padding (which the usercopy hardening would fail to protect).
> 
> For this reason, the presence of tp2_value is made unconditional,
> since a padding field would be needed there in any case.  This pads
> up to the 16-byte alignment required by struct user_fpsimd_state.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 9e8084d3f761 ("arm64: Implement thread_struct whitelist for hardened usercopy")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since v1:
> 
>  * Add a BUILD_BUG_ON() check for padding in the whitelist struct.
>  * Move to using sizeof_field() for assigning *size; get rid of the
>    dummy pointer that was used previously.
>  * Delete bogus comment about why no whitelist is (was) needed.
> ---
>  arch/arm64/include/asm/processor.h | 38 +++++++++++++++++++-----------
>  arch/arm64/kernel/fpsimd.c         | 47 +++++++++++++++++++-------------------
>  arch/arm64/kernel/process.c        |  6 ++---
>  arch/arm64/kernel/ptrace.c         | 30 ++++++++++++------------
>  arch/arm64/kernel/signal.c         |  3 ++-
>  arch/arm64/kernel/signal32.c       |  3 ++-
>  arch/arm64/kernel/sys_compat.c     |  2 +-
>  7 files changed, 72 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 4a04535..224af48 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -34,6 +34,8 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/build_bug.h>
> +#include <linux/stddef.h>
>  #include <linux/string.h>
>  
>  #include <asm/alternative.h>
> @@ -102,11 +104,18 @@ struct cpu_context {
>  
>  struct thread_struct {
>  	struct cpu_context	cpu_context;	/* cpu context */
> -	unsigned long		tp_value;	/* TLS register */
> -#ifdef CONFIG_COMPAT
> -	unsigned long		tp2_value;
> -#endif
> -	struct user_fpsimd_state fpsimd_state;
> +
> +	/*
> +	 * Whitelisted fields for hardened usercopy:
> +	 * Maintainers must ensure manually that this contains no
> +	 * implicit padding.
> +	 */
> +	struct {
> +		unsigned long	tp_value;	/* TLS register */
> +		unsigned long	tp2_value;
> +		struct user_fpsimd_state fpsimd_state;
> +	} uw;

I was trying to figure out a way to avoid the '.uw.' everywhere we want to
access these members. I tried using an anonymous union, but then I couldn't
figure out a way to enforce the BUILD_BUG_ON you have later on in the patch
so I guess it's fine as-is.

Thanks!

Will
