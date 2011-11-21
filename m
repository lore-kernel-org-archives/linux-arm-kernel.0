From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Nov 2011 18:53:51 +0000
Subject: [PATCH 3/4] [RFC] Add condition code checking to SWP emulation
 handler.
In-Reply-To: <20111121183058.28964.79067.stgit@localhost6.localdomain6>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
 <20111121183058.28964.79067.stgit@localhost6.localdomain6>
Message-ID: <20111121185351.GL20611@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 06:30:58PM +0000, Leif Lindholm wrote:
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index 5f452f8..2e379d5 100644
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
> @@ -183,6 +184,16 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
>  	unsigned int address, destreg, data, type;
>  	unsigned int res = 0;
>  
> +	res = arm_check_condition(instr, regs->ARM_cpsr);
> +	if (!res) {
> +		/* Condition failed - return to next instruction */
> +		regs->ARM_pc += 4;
> +		return 0;
> +	} else if (res != 1) {
> +		/* If unconditional encoding - not a SWP, undef */
> +		return -EFAULT;
> +	}
> +
>  	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);

Although the definition of this perf event is by no means well defined, I
think I'd like it to increment even if the opcode condigion isn't satisfied.
After all, we *have* faulted by this point, we just haven't needed to do
anything much in the handler.

Will
