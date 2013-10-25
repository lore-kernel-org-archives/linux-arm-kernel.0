From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Oct 2013 14:14:41 +0100
Subject: [PATCH 1/2] ARM64: perf: add support for perf registers API
In-Reply-To: <1382108078-8807-2-git-send-email-jean.pihet@linaro.org>
References: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
 <1382108078-8807-2-git-send-email-jean.pihet@linaro.org>
Message-ID: <20131025131441.GC9999@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 03:54:37PM +0100, Jean Pihet wrote:
> From: Jean Pihet <jean.pihet@newoldbits.com>
> 
> This patch implements the functions required for the perf registers API,
> allowing the perf tool to interface kernel register dumps with libunwind
> in order to provide userspace backtracing.
> Only the general purpose user space registers are exported, i.e.:
>  PERF_REG_ARM_X0,
>  ...
>  PERF_REG_ARM_X28,
>  PERF_REG_ARM_FP,
>  PERF_REG_ARM_LR,
>  PERF_REG_ARM_SP,
>  PERF_REG_ARM_PC
> and not the PERF_REG_ARM_V* registers.

[...]

> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> new file mode 100644
> index 0000000..bbcf63c
> --- /dev/null
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -0,0 +1,29 @@
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/perf_event.h>
> +#include <linux/bug.h>
> +#include <asm/perf_regs.h>
> +#include <asm/ptrace.h>
> +
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM_MAX))
> +		return 0;
> +
> +	return regs->regs[idx];
> +}
> +
> +#define REG_RESERVED (~((1ULL << PERF_REG_ARM_MAX) - 1))
> +
> +int perf_reg_validate(u64 mask)
> +{
> +	if (!mask || mask & REG_RESERVED)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +u64 perf_reg_abi(struct task_struct *task)
> +{
> +	return PERF_SAMPLE_REGS_ABI_64;
> +}

You need to deal with compat (AArch32) tasks here too, which means providing
something compatible with what we do on arch/arm/ depending on the thread
flags.

Will
