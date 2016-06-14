From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 14 Jun 2016 17:16:50 +0100
Subject: [PATCH 6/6] arm64: trap userspace "dc cvau" cache operation on
 errata-affected core
In-Reply-To: <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
Message-ID: <57602DF2.1040501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/16 17:49, Andre Przywara wrote:
> The ARM errata 819472, 826319, 827319 and 824069 for affected
> Cortex-A53 cores demand to promote "dc cvau" instructions to
> "dc civac". Since we allow userspace to also emit those instructions,
> we should make sure that "dc cvau" gets promoted there too.
> So lets grasp the nettle here and actually trap every userland cache
> maintenance instruction once we detect at least one affected core in
> the system.
> We then emulate the instruction by executing it on behalf of userland,
> promoting "dc cvau" to "dc civac" on the way and injecting access
> fault back into userspace.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>


> +
> +asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
> +{
> +	unsigned long address;
> +	int ret;
> +
> +	/* if this is a write with: Op0=1, Op2=1, Op1=3, CRn=7 */
> +	if ((esr & 0x01fffc01) == 0x0012dc00) {
> +		int rt = (esr >> 5) & 0x1f;
> +		int crm = (esr >> 1) & 0x0f;
> +
> +		address = regs->regs[rt];
> +
> +		switch (crm) {
> +		case 11:		/* DC CVAU, gets promoted */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 10:		/* DC CVAC, gets promoted */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 14:		/* DC CIVAC */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 5:			/* IC IVAU */
> +			__user_cache_maint("ic ivau", address, ret);
> +			break;
> +		default:
> +			force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
> +			return;
> +		}
> +	} else {
> +		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
> +		return;

Correct me if I am wrong, I think we should handle DC ZVA and emulate the same ?
Thats the only EL0 accessible instruction we don't handle above.

Suzuki
