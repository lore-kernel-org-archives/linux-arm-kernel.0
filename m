From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 04 Dec 2013 19:23:02 +0200
Subject: [PATCH v3 14/15] ARM: add uprobes support
In-Reply-To: <1385520814-10663-15-git-send-email-dave.long@linaro.org>
References: <1385520814-10663-1-git-send-email-dave.long@linaro.org>
 <1385520814-10663-15-git-send-email-dave.long@linaro.org>
Message-ID: <529F64F6.6010209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 04:53 AM, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Using Rabin Vincent's ARM uprobes patches as a base, enable uprobes
> support on ARM.
> 
> Caveats:
> 
>  - Thumb is not supported
>  - XOL abort/trap handling is not implemented
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/Kconfig                   |   4 +
>  arch/arm/include/asm/ptrace.h      |   6 +
>  arch/arm/include/asm/thread_info.h |   5 +-
>  arch/arm/include/asm/uprobes.h     |  34 ++++++
>  arch/arm/kernel/Makefile           |   1 +
>  arch/arm/kernel/signal.c           |   4 +
>  arch/arm/kernel/uprobes-arm.c      | 223 +++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/uprobes.c          | 198 ++++++++++++++++++++++++++++++++
>  arch/arm/kernel/uprobes.h          |  27 +++++
>  9 files changed, 501 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/include/asm/uprobes.h
>  create mode 100644 arch/arm/kernel/uprobes-arm.c
>  create mode 100644 arch/arm/kernel/uprobes.c
>  create mode 100644 arch/arm/kernel/uprobes.h
> 

[snip]

> diff --git a/arch/arm/kernel/uprobes-arm.c b/arch/arm/kernel/uprobes-arm.c
> new file mode 100644
> index 0000000..0a83ad7
> --- /dev/null
> +++ b/arch/arm/kernel/uprobes-arm.c
> @@ -0,0 +1,223 @@
> +#include <linux/kernel.h>
> +#include <linux/wait.h>
> +#include <linux/uprobes.h>
> +#include <linux/module.h>
> +
> +#include "probes.h"
> +#include "probes-arm.h"
> +#include "uprobes.h"
> +
> +static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
> +{
> +	probes_opcode_t insn = *pinsn;

In a current implementation pinsn points to an ixol field of arch_uprobe
structure, which has native endianness and is written via
__opcode_to_mem_arm() macro in arch_uprobe_analyze_insn() function.
So *pinsn should be wrapped with __opcode_to_mem_arm/__mem_to_opcode_arm()
macros in this function.

> +	probes_opcode_t temp;
> +	probes_opcode_t mask;
> +	int freereg;
> +	u32 free = 0xffff;
> +	u32 regs;
> +
> +	for (regs = oregs; regs; regs >>= 4, insn >>= 4) {
> +		if ((regs & 0xf) == REG_TYPE_NONE)
> +			continue;
> +
> +		free &= ~(1 << (insn & 0xf));
> +	}
> +
> +	/* No PC, no problem */
> +	if (free & (1 << 15))
> +		return 15;
> +
> +	if (!free)
> +		return -1;
> +
> +	/*
> +	 * fls instead of ffs ensures that for "ldrd r0, r1, [pc]" we would
> +	 * pick LR instead of R1.
> +	 */
> +	freereg = free = fls(free) - 1;
> +
> +	temp = *pinsn;
> +	insn = *pinsn;
> +	regs = oregs;
> +	mask = 0xf;
> +
> +	for (; regs; regs >>= 4, mask <<= 4, free <<= 4, temp >>= 4) {
> +		if ((regs & 0xf) == REG_TYPE_NONE)
> +			continue;
> +
> +		if ((temp & 0xf) != 15)
> +			continue;
> +
> +		insn &= ~mask;
> +		insn |= free & mask;
> +	}
> +
> +	*pinsn = insn;
> +	return freereg;
> +}
> +

[snip]

> +
> +enum probes_insn
> +uprobe_decode_ldmstm(probes_opcode_t insn,
> +		     struct arch_specific_insn *asi, struct decode_header *d)
> +{
> +	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
> +						   asi);
> +	unsigned reglist = insn & 0xffff;
> +	int rn = (insn >> 16) & 0xf;
> +	int lbit = insn & (1 << 20);
> +	unsigned used = reglist | (1 << rn);
> +
> +	if (rn == 15)
> +		return INSN_REJECTED;
> +
> +	if (!(used & (1 << 15)))
> +		return INSN_GOOD;
> +
> +	if (used & (1 << 14))
> +		return INSN_REJECTED;
> +
> +	/* Use LR instead of PC */
> +	insn ^= 0xc000;
> +
> +	auprobe->pcreg = 14;
> +	auprobe->ixol[0] = insn;

insn contains canonical opcode, but ixol should contain
an opcode in native endianness. So it should be

auprobe->ixol[0] = __opcode_to_mem_arm(insn);

> +
> +	auprobe->prehandler = uprobe_set_pc;
> +	if (lbit)
> +		auprobe->posthandler = uprobe_write_pc;
> +	else
> +		auprobe->posthandler = uprobe_unset_pc;
> +
> +	return INSN_GOOD;
> +}
> +


-- 
Taras Kondratiuk
