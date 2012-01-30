From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 17:00:06 +0000
Subject: [PATCHv2 4/6] ARM: extract out code patch function from kprobes
In-Reply-To: <1327757725-10114-5-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-5-git-send-email-rabin@rab.in>
Message-ID: <20120130170006.GD2248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 07:05:23PM +0530, Rabin Vincent wrote:
> Extract out the code patching code from kprobes so that it can be used
> from the jump label code.  Additionally, the separated code:
> 
>  - Uses the IS_ENABLED() macros instead of the #ifdefs for THUMB2
>    support
> 
>  - Unifies the two separate functions in kprobes, providing one function
>    that uses stop_machine() internally, and one that can be called from
>    stop_machine() directly
> 
>  - Patches the text on all CPUs only on processors requiring software
>    broadcasting of cache operations
> 
> Cc: Jon Medhurst <tixy@yxit.co.uk>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/Makefile  |    3 +-
>  arch/arm/kernel/kprobes.c |   86 ++++++++++++--------------------------------
>  arch/arm/kernel/patch.c   |   73 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/patch.h   |    7 ++++
>  4 files changed, 106 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm/kernel/patch.c
>  create mode 100644 arch/arm/kernel/patch.h

[...]

> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> new file mode 100644
> index 0000000..30eff23
> --- /dev/null
> +++ b/arch/arm/kernel/patch.c
> @@ -0,0 +1,73 @@

[...]

> +void __kprobes __patch_text(void *addr, unsigned int insn)
> +{
> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
> +	int size;
> +
> +	if (thumb2 && __opcode_is_thumb16(insn)) {
> +		*(u16 *)addr = __opcode_to_mem_thumb16(insn);
> +		size = sizeof(u16);
> +	} else if (thumb2 && ((uintptr_t)addr & 2)) {
> +		u16 *addrh = addr;
> +
> +		addrh[0] = __opcode_thumb32_first(insn);
> +		addrh[1] = __opcode_thumb32_second(insn);

It looks like we never convert to memory byte order in this case.

If not, should this be as follows?

	addrh[0] = __opcode_to_mem_thumb16(__opcode_thumb32_first(insn));
	addrh[1] = __opcode_to_mem_thumb16(__opcode_thumb32_second(insn));

> +
> +		size = sizeof(u32);
> +	} else {
> +		if (thumb2)
> +			insn = __opcode_to_mem_thumb32(insn);
> +		else
> +			insn = __opcode_to_mem_arm(insn);
> +
> +		*(u32 *)addr = insn;
> +		size = sizeof(u32);
> +	}
> +
> +	flush_icache_range((uintptr_t)(addr),
> +			   (uintptr_t)(addr) + size);
> +}

[...]

Cheers
---Dave
