From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2011 16:06:23 +0000
Subject: [PATCH 3/4] Add condition code checking to SWP emulation handler.
In-Reply-To: <20111208173204.7572.16929.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173204.7572.16929.stgit@localhost6.localdomain6>
Message-ID: <20111209160623.GJ5196@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 05:32:06PM +0000, Leif Lindholm wrote:
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index 5f452f8..6a5210e 100644
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
> @@ -185,6 +186,17 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
>  
>  	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);
>  
> +	res = arm_check_condition(instr, regs->ARM_cpsr);
> +	switch (res) {
> +	case ARM_OPCODE_CONDTEST_FAIL:
> +		/* Condition failed - return to next instruction */
> +		regs->ARM_pc += 4;
> +		return 0;
> +	case ARM_OPCODE_CONDTEST_UNCOND:
> +		/* If unconditional encoding - not a SWP, undef */
> +		return -EFAULT;
> +	}
> +

Maybe have:

	case ARM_OPCODE_CONDTEST_PASS:
		break;

for clarity. You could always have -EFAULT for the default case.

Will
