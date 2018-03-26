From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 27 Mar 2018 00:20:33 +0300
Subject: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked function
In-Reply-To: <20180325180959.28008-4-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
Message-ID: <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2018 21:09, Stefan Agner wrote:
> As documented in GCC naked functions should only use Basic asm
> syntax. The Extended asm or mixture of Basic asm and "C" code is
> not guaranteed. Currently this works because it was hard coded
> to follow and check GCC behavior for arguments and register
> placement.
> 
> Furthermore with clang using parameters in Extended asm in a
> naked function is not supported:
>   arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>           references not allowed in naked functions
>                 : "r" (type), "r" (arg1), "r" (arg2)
>                        ^
> 
> Use a regular function to be more portable. This aligns also with
> the other smc call implementations e.g. in qcom_scm-32.c and
> bcm_kona_smc.c.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Keep stmfd/ldmfd to avoid potential ABI issues
> 
>  arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
> index 3fb1b5a1dce9..689e6565abfc 100644
> --- a/arch/arm/firmware/trusted_foundations.c
> +++ b/arch/arm/firmware/trusted_foundations.c
> @@ -31,21 +31,25 @@
>  
>  static unsigned long cpu_boot_addr;
>  
> -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>  {
> +	register u32 r0 asm("r0") = type;
> +	register u32 r1 asm("r1") = arg1;
> +	register u32 r2 asm("r2") = arg2;
> +
>  	asm volatile(
>  		".arch_extension	sec\n\t"
> -		"stmfd	sp!, {r4 - r11, lr}\n\t"
> +		"stmfd	sp!, {r4 - r11}\n\t"
>  		__asmeq("%0", "r0")
>  		__asmeq("%1", "r1")
>  		__asmeq("%2", "r2")
>  		"mov	r3, #0\n\t"
>  		"mov	r4, #0\n\t"
>  		"smc	#0\n\t"
> -		"ldmfd	sp!, {r4 - r11, pc}"
> +		"ldmfd	sp!, {r4 - r11}\n\t"
>  		:
> -		: "r" (type), "r" (arg1), "r" (arg2)
> -		: "memory");
> +		: "r" (r0), "r" (r1), "r" (r2)
> +		: "memory", "r3", "r12", "lr");

Although seems "lr" won't be affected by SMC invocation because it should be
banked and hence could be omitted entirely from the code. Maybe somebody could
confirm this.
