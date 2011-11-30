From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 17:01:48 +0000
Subject: [PATCH 3/4] Add condition code checking to SWP emulation handler.
In-Reply-To: <20111125171947.14878.76518.stgit@localhost6.localdomain6>
References: <20111125171621.14878.49918.stgit@localhost6.localdomain6>
 <20111125171947.14878.76518.stgit@localhost6.localdomain6>
Message-ID: <20111130170148.GH2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 05:19:53PM +0000, Leif Lindholm wrote:
> This patch fixes two separate issues with the SWP emulation handler:
> 1: Certain processors implementing ARMv7-A can (legally) take an
>    undef exception even when the condition code would have meant that
>    the instruction should not have been executed.
> 2: Opcodes with all flags set (condition code = 0xf) have been reused
>    in recent, and not-so-recent, versions of the ARM architecture to
>    implement unconditional extensions to the instruction set. The
>    existing code would still have processed any undefs triggered by
>    executing an opcode with such a value.
> 
> This patch uses the new generic ARM instruction set condition code
> checks to implement proper handling of these situations.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> ---
>  arch/arm/kernel/swp_emulate.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index 5f452f8..8629bf7 100644
> --- a/arch/arm/kernel/swp_emulate.c
> +++ b/arch/arm/kernel/swp_emulate.c
> @@ -25,6 +25,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/perf_event.h>
>  
> +#include <asm/opcodes.h>
>  #include <asm/traps.h>
>  #include <asm/uaccess.h>
>  
> @@ -185,6 +186,19 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
>  
>  	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);
>  
> +	res = arm_check_condition(instr, regs->ARM_cpsr);
> +	switch (res) {
> +	case ARM_OPCODE_CONDTEST_FAIL: {
> +		/* Condition failed - return to next instruction */
> +		regs->ARM_pc += 4;
> +		return 0;
> +	} break;
> +	case ARM_OPCODE_CONDTEST_UNCOND: {
> +		/* If unconditional encoding - not a SWP, undef */
> +		return -EFAULT;
> +	} break;
> +	}
> +

Can we lose the extra { } inside the switch here?

Those cases contain no declarations, so there's no need for a nested
block in either case.  This also solves the indentation problem.

Documentation/CodingStyle appears to prefer an unconditional break; to
be indented flush with the contents of the case block that it ends.

Cheers
---Dave
