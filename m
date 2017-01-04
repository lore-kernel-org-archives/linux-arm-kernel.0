From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 17:33:52 +0000
Subject: [Patch v2 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <1483054046-3327-2-git-send-email-andy.gross@linaro.org>
References: <1483054046-3327-1-git-send-email-andy.gross@linaro.org>
 <1483054046-3327-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20170104173352.GO18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 05:27:25PM -0600, Andy Gross wrote:
> This patch adds a quirk parameter to the arm_smccc_smc call.  The quirk
> structure allows for specialized SMC operations due to SoC specific
> requirements.  The current arm_smccc_smc is renamed and macros are used
> instead to specify the standard arm_smccc_smc or the arm_smccc_smc_quirk
> function.
> 
> This patch and partial implementation was suggested by Will Deacon.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm/kernel/armksyms.c      |  2 +-
>  arch/arm/kernel/smccc-call.S    |  7 ++++---
>  arch/arm64/kernel/arm64ksyms.c  |  2 +-
>  arch/arm64/kernel/asm-offsets.c |  7 +++++--
>  arch/arm64/kernel/smccc-call.S  |  7 ++++---
>  include/linux/arm-smccc.h       | 28 ++++++++++++++++++++++++----
>  6 files changed, 39 insertions(+), 14 deletions(-)

[...]

> @@ -101,4 +115,10 @@ asmlinkage void arm_smccc_hvc(unsigned long a0, unsigned long a1,
>  			unsigned long a5, unsigned long a6, unsigned long a7,
>  			struct arm_smccc_res *res);
>  
> +#define arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res) \
> +	__arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res, NULL)
> +
> +#define arm_smccc_smc_quirk(a0, a1, a2, a3, a4, a5, a6, a7, res, quirk) \
> +	__arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res, quirk)

This might be a bit cleaner with a variadic macro, but either way:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
