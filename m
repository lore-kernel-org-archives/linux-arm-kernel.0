From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 17 May 2016 17:10:12 +0800
Subject: [PATCH v12 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <1461783185-9056-6-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-6-git-send-email-dave.long@linaro.org>
Message-ID: <20160517091009.GA5082@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 02:53:00PM -0400, David Long wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> +
> +static bool __kprobes aarch64_insn_is_steppable(u32 insn)

Could we add more comment for this function? In the comment, we can tell
that which type of instructions are steppable, which are not.

> +{
> +	if (aarch64_get_insn_class(insn) == AARCH64_INSN_CLS_BR_SYS) {
> +		if (aarch64_insn_is_branch(insn) ||
> +		    aarch64_insn_is_msr_imm(insn) ||
> +		    aarch64_insn_is_msr_reg(insn) ||
> +		    aarch64_insn_is_exception(insn))
> +			return false;
> +
> +		if (aarch64_insn_is_mrs(insn))
> +			return aarch64_insn_extract_system_reg(insn)
> +			     != AARCH64_INSN_SPCLREG_DAIF;
> +
> +		if (aarch64_insn_is_hint(insn))
> +			return aarch64_insn_is_nop(insn);
> +
> +		return true;
> +	}
> +
> +	if (aarch64_insn_uses_literal(insn) ||
> +	    aarch64_insn_is_exclusive(insn))
> +		return false;
> +
> +	return true;

Thanks
Huang Shijie
