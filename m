From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 9 Jan 2015 18:59:36 +0100
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
Message-ID: <20150109175936.GB13161@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31, Pratyush Anand wrote:
>
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +		unsigned long addr)
> +{
> +	probe_opcode_t insn;
> +
> +	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
> +
> +	switch (arm_probe_decode_insn(insn, &auprobe->ainsn)) {
> +	case INSN_REJECTED:
> +		return -EINVAL;
> +
> +	case INSN_GOOD_NO_SLOT:
> +		auprobe->simulate = true;
> +		if (auprobe->ainsn.prepare)
> +			auprobe->ainsn.prepare(insn, &auprobe->ainsn);
> +		break;
> +
> +	case INSN_GOOD:
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}

forgot to mention... shouldn't it also check IS_ALIGNED(addr, AARCH64_INSN_SIZE) ?

I do not know if unaligned insn address is valid on arm64 or not, but please
note that at least it should not cross the page boundary, set_swbp() needs to
write AARCH64_INSN_SIZE == UPROBE_SWBP_INSN bytes and it assumes that this
should fit the single page.

Oleg.
