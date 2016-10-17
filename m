From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Oct 2016 19:19:35 +0100
Subject: [PATCH] arm64: sysreg: Fix use of XZR in write_sysreg_s
In-Reply-To: <1476724859-18818-1-git-send-email-will.deacon@arm.com>
References: <1476724859-18818-1-git-send-email-will.deacon@arm.com>
Message-ID: <20161017181935.GD23170@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:20:59PM +0100, Will Deacon wrote:
> Commit 8a71f0c656e0 ("arm64: sysreg: replace open-coded mrs_s/msr_s with
> {read,write}_sysreg_s") introduced a write_sysreg_s macro for writing
> to system registers that are not supported by binutils.
> 
> Unfortunately, this was implemented with the wrong template (%0 vs %x0),
> so in the case that we are writing a constant 0, we will generate
> invalid instruction syntax and bail with a cryptic assembler error:
> 
>   | Error: constant expression required
> 
> This patch fixes the template.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Whoops; I should've spotted that in review. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/sysreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e8d46e8e6079..6c80b3699cb8 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -286,7 +286,7 @@ asm(
>  
>  #define write_sysreg_s(v, r) do {					\
>  	u64 __val = (u64)v;						\
> -	asm volatile("msr_s " __stringify(r) ", %0" : : "rZ" (__val));	\
> +	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
>  } while (0)
>  
>  static inline void config_sctlr_el1(u32 clear, u32 set)
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
