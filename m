From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Mar 2014 11:00:42 +0000
Subject: [PATCH 1/3] perf tests: Introduce perf_regs_load function on ARM
In-Reply-To: <1393840403-26639-2-git-send-email-jean.pihet@linaro.org>
References: <1393840403-26639-1-git-send-email-jean.pihet@linaro.org>
 <1393840403-26639-2-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140304110042.GD8766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Mon, Mar 03, 2014 at 09:53:21AM +0000, Jean Pihet wrote:
> Introducing perf_regs_load function, which is going
> to be used for dwarf unwind test in following patches.
> 
> It takes single argument as a pointer to the regs dump
> buffer and populates it with current registers values.

[...]

> diff --git a/tools/perf/arch/arm/tests/regs_load.S b/tools/perf/arch/arm/tests/regs_load.S
> new file mode 100644
> index 0000000..241c6df
> --- /dev/null
> +++ b/tools/perf/arch/arm/tests/regs_load.S
> @@ -0,0 +1,51 @@
> +#include <linux/linkage.h>
> +
> +#define R0 0x00
> +#define R1 0x08

Why are you using a 64-bit stride for 32-bit registers? (which prevents you
from using stm later on).

> +.text
> +.type perf_regs_load,%function
> +ENTRY(perf_regs_load)
> +	push {r1}

Do you only push r1 here so that you can do the stack arithmetic later? That
doesn't make sense to me -- can't you str sp directly?

> +	str r0, [r0, #R0]
> +	str r1, [r0, #R1]
> +	str r2, [r0, #R2]
> +	str r3, [r0, #R3]
> +	str r4, [r0, #R4]
> +	str r5, [r0, #R5]
> +	str r6, [r0, #R6]
> +	str r7, [r0, #R7]
> +	str r8, [r0, #R8]
> +	str r9, [r0, #R9]
> +	str sl, [r0, #SL]
> +	str fp, [r0, #FP]
> +	str ip, [r0, #IP]
> +	add r1, sp, #4		@ Retrieve and save sp at entry time
> +	str r1, [r0, #SP]
> +	str lr, [r0, #LR]
> +	str lr, [r0, #PC]	@ Save caller PC

This isn't necessarily the `caller PC' (depending on how you define it).
It's the return address, which is probably (but not always) the instruction
following the branch to this function.

Will
