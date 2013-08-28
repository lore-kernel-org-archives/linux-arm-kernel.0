From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:47:33 +0100
Subject: [PATCH 16/19] ARM: net: fix arm instruction endian-ness in
 bpf_jit_32.c
In-Reply-To: <1377639509-22778-17-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-17-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828164733.GF3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:26PM +0100, Ben Dooks wrote:
> Use <asm/opcodes.h> to correctly transform instruction byte ordering
> into in-memory ordering.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/net/bpf_jit_32.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index f50d223..510d923 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -19,6 +19,7 @@
>  #include <linux/if_vlan.h>
>  #include <asm/cacheflush.h>
>  #include <asm/hwcap.h>
> +#include <asm/opcodes.h>
>  
>  #include "bpf_jit_32.h"
>  
> @@ -113,8 +114,11 @@ static u32 jit_udiv(u32 dividend, u32 divisor)
>  
>  static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
>  {
> +	inst |= (cond << 28);
> +	inst = __opcode_to_mem_arm(inst);
> +
>  	if (ctx->target != NULL)
> -		ctx->target[ctx->idx] = inst | (cond << 28);
> +		ctx->target[ctx->idx] = inst;
>  
>  	ctx->idx++;
>  }
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
