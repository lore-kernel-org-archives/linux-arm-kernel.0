From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:50:18 +0100
Subject: [PATCH 18/19] ARM: kdgb: use <asm/opcodes.h> for data to be
 assembled as intruction
In-Reply-To: <1377639509-22778-19-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-19-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828165018.GH3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:28PM +0100, Ben Dooks wrote:
> The arch_kgdb_breakpoint() function uses an inline assembly directive
> to assemble a specific instruction using .word. This means the linker
> will not treat is as an instruction, and therefore incorrectly swap
> the endian-ness if running BE8.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

I wonder whether KGDB works with Thumb-2 kernels... but this patch
shouldn't make things any worse, anyway.

Cheers
---Dave

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/kgdb.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> index 48066ce..0a9d5dd 100644
> --- a/arch/arm/include/asm/kgdb.h
> +++ b/arch/arm/include/asm/kgdb.h
> @@ -11,6 +11,7 @@
>  #define __ARM_KGDB_H__
>  
>  #include <linux/ptrace.h>
> +#include <asm/opcodes.h>
>  
>  /*
>   * GDB assumes that we're a user process being debugged, so
> @@ -41,7 +42,7 @@
>  
>  static inline void arch_kgdb_breakpoint(void)
>  {
> -	asm(".word 0xe7ffdeff");
> +	asm(__inst_arm(0xe7ffdeff));
>  }
>  
>  extern void kgdb_handle_bus_error(void);
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
