From: cpandya@codeaurora.org (Chintan Pandya)
Date: Wed, 21 Mar 2018 11:02:47 +0530
Subject: [PATCH] arm/arm64: smccc: Fix CLANG compilation for ARM 64 bit
 archs
In-Reply-To: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
References: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
Message-ID: <bcfad897-fc05-d16e-0197-9b0ee17b3b87@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/21/2018 3:44 AM, Isaac J. Manjarres wrote:
> Currently, there are references to registers that
> have had their names changed in 64 bit ARM architectures,
> such as "r0." While GCC automatically does the conversion of
> these registers to their 64 bit counterparts, CLANG
> does not, resulting in compilation failures when
> building the kernel. Allow for differentiation of
> which register names to use, based on ARM architecture.
> 
> Change-Id: If89d47b2feb217d97bb61a3f99e61096705a4984
Please remove this "Change-Id". Doesn't mean anything in upstream.

> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>   include/linux/arm-smccc.h | 57 ++++++++++++++++++++++++++++++-----------------
>   1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index a031897..1208729 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -155,6 +155,15 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   
>   #define SMCCC_SMC_INST	"smc	#0"
>   #define SMCCC_HVC_INST	"hvc	#0"
> +#define R0_STR		"x0"
> +#define R1_STR		"x1"
> +#define R2_STR		"x2"
> +#define R3_STR		"x3"
> +#define R4_STR		"x4"
> +#define R5_STR		"x5"
> +#define R6_STR		"x6"
> +#define R7_STR		"x7"
> +
>   
>   #elif defined(CONFIG_ARM)
>   #include <asm/opcodes-sec.h>
> @@ -162,6 +171,14 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   
>   #define SMCCC_SMC_INST	__SMC(0)
>   #define SMCCC_HVC_INST	__HVC(0)
> +#define R0_STR		"r0"
> +#define R1_STR		"r1"
> +#define R2_STR		"r2"
> +#define R3_STR		"r3"
> +#define R4_STR		"r4"
> +#define R5_STR		"r5"
> +#define R6_STR		"r6"
> +#define R7_STR		"r7"
>   
>   #endif
>   
> @@ -194,47 +211,47 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   
>   #define __declare_arg_0(a0, res)					\
>   	struct arm_smccc_res   *___res = res;				\
> -	register u32           r0 asm("r0") = a0;			\
> -	register unsigned long r1 asm("r1");				\
> -	register unsigned long r2 asm("r2");				\
> -	register unsigned long r3 asm("r3")
> +	register u32           r0 asm(R0_STR) = a0;			\
> +	register unsigned long r1 asm(R1_STR);				\
> +	register unsigned long r2 asm(R2_STR);				\
> +	register unsigned long r3 asm(R3_STR)
>   
>   #define __declare_arg_1(a0, a1, res)					\
>   	struct arm_smccc_res   *___res = res;				\
> -	register u32           r0 asm("r0") = a0;			\
> -	register typeof(a1)    r1 asm("r1") = a1;			\
> -	register unsigned long r2 asm("r2");				\
> -	register unsigned long r3 asm("r3")
> +	register u32           r0 asm(R0_STR) = a0;			\
> +	register typeof(a1)    r1 asm(R1_STR) = a1;			\
> +	register unsigned long r2 asm(R2_STR);				\
> +	register unsigned long r3 asm(R3_STR)
>   
>   #define __declare_arg_2(a0, a1, a2, res)				\
>   	struct arm_smccc_res   *___res = res;				\
> -	register u32           r0 asm("r0") = a0;			\
> -	register typeof(a1)    r1 asm("r1") = a1;			\
> -	register typeof(a2)    r2 asm("r2") = a2;			\
> -	register unsigned long r3 asm("r3")
> +	register u32           r0 asm(R0_STR) = a0;			\
> +	register typeof(a1)    r1 asm(R1_STR) = a1;			\
> +	register typeof(a2)    r2 asm(R2_STR) = a2;			\
> +	register unsigned long r3 asm(R3_STR)
>   
>   #define __declare_arg_3(a0, a1, a2, a3, res)				\
>   	struct arm_smccc_res   *___res = res;				\
> -	register u32           r0 asm("r0") = a0;			\
> -	register typeof(a1)    r1 asm("r1") = a1;			\
> -	register typeof(a2)    r2 asm("r2") = a2;			\
> -	register typeof(a3)    r3 asm("r3") = a3
> +	register u32           r0 asm(R0_STR) = a0;			\
> +	register typeof(a1)    r1 asm(R1_STR) = a1;			\
> +	register typeof(a2)    r2 asm(R2_STR) = a2;			\
> +	register typeof(a3)    r3 asm(R3_STR) = a3
>   
>   #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
>   	__declare_arg_3(a0, a1, a2, a3, res);				\
> -	register typeof(a4) r4 asm("r4") = a4
> +	register typeof(a4) r4 asm(R4_STR) = a4
>   
>   #define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
>   	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
> -	register typeof(a5) r5 asm("r5") = a5
> +	register typeof(a5) r5 asm(R5_STR) = a5
>   
>   #define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
>   	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
> -	register typeof(a6) r6 asm("r6") = a6
> +	register typeof(a6) r6 asm(R6_STR) = a6
>   
>   #define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
>   	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
> -	register typeof(a7) r7 asm("r7") = a7
> +	register typeof(a7) r7 asm(R7_STR) = a7
>   
>   #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
>   #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
