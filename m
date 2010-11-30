From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 30 Nov 2010 10:01:00 +0000
Subject: [PATCH 5/8] ARM: hw_breakpoint: don't advertise reserved
	breakpoints
In-Reply-To: <1291052088-17243-6-git-send-email-will.deacon@arm.com>
References: <1291052088-17243-1-git-send-email-will.deacon@arm.com>
	<1291052088-17243-6-git-send-email-will.deacon@arm.com>
Message-ID: <20101130100100.GA4398@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 05:34:45PM +0000, Will Deacon wrote:
> To permit handling of watchpoint exceptions without signalling a
> debugger, it is necessary to reserve breakpoint registers for in-kernel
> use only.
> 
> This patch ensures that we record and subtract the number of reserved
> breakpoints from the number of usable breakpoint registers that we
> advertise to userspace via the ptrace API.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c |  205 ++++++++++++++++++++++-----------------
>  1 files changed, 116 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index 61eeb41..b8acfbc 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -44,6 +44,7 @@ static DEFINE_PER_CPU(struct perf_event *, wp_on_reg[ARM_MAX_WRP]);
>  
[...]
> +/* Determine number of BRP register available. */
> +static int get_num_brp_resources(void)
> +{
> +	u32 didr;
> +	ARM_DBG_READ(c0, 0, didr);
> +	return ((didr >> 24) & 0xf) + 1;
> +}
> +
> +/* Does this core support mismatch breakpoints? */
> +static int core_has_mismatch_brps(void)
> +{
> +	return (get_debug_arch() >= ARM_DEBUG_ARCH_V7_ECP14 &&
> +		get_num_brp_resources() > 1);
> +}
> +
> +/* Determine number of usable WRPs available. */
> +static int get_num_wrps(void)
> +{
> +	/*
> +	 * FIXME: When a watchpoint fires, the only way to work out which
> +	 * watchpoint it was is by disassembling the faulting instruction
> +	 * and working out the address of the memory access.
> +	 *
> +	 * Furthermore, we can only do this if the watchpoint was precise
> +	 * since imprecise watchpoints prevent us from calculating register
> +	 * based addresses.
> +	 *
> +	 * For the time being, we only report 1 watchpoint register so we
> +	 * always know which watchpoint fired. In the future we can either
> +	 * add a disassembler and address generation emulator, or we can
> +	 * insert a check to see if the DFAR is set on watchpoint exception
> +	 * entry [the ARM ARM states that the DFAR is UNKNOWN, but
> +	 * experience shows that it is set on some implementations].
> +	 */
> +
> +#if 0
> +	int wrps;
> +	u32 didr;
> +	ARM_DBG_READ(c0, 0, didr);
> +	wrps = ((didr >> 28) & 0xf) + 1;
> +#endif
> +	int wrps = 1;
> +
> +	if (core_has_mismatch_brps() && wrps >= get_num_brp_resources())
> +		wrps = get_num_brp_resources() - 1;
> +
> +	return wrps;
> +}
Hi Will,

Minor nitpick, is the comment above still valid? It looks like this could 
return something other than 1. Is this to handle the case when there aren't 
any watchpoint registers?

Jamie
