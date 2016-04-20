From: huawei.libin@huawei.com (Li Bin)
Date: Wed, 20 Apr 2016 09:29:28 +0800
Subject: [PATCH v11 5/9] arm64: Kprobes with single stepping support
In-Reply-To: <1457501543-24197-6-git-send-email-dave.long@linaro.org>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-6-git-send-email-dave.long@linaro.org>
Message-ID: <5716DB78.2010109@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

on 2016/3/9 13:32, David Long wrote:
> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
> +{
> +	unsigned long probe_addr = (unsigned long)p->addr;

Here should verify the addr alignment:

	if (probe_addr & 0x3)
		return -EINVAL;

Thanks,
Li Bin

> +
> +	/* copy instruction */
> +	p->opcode = le32_to_cpu(*p->addr);
> +
> +	if (in_exception_text(probe_addr))
> +		return -EINVAL;
> +
> +	/* decode instruction */
> +	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
> +	case INSN_REJECTED:	/* insn not supported */
> +		return -EINVAL;
> +
> +	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
> +		return -EINVAL;
> +
> +	case INSN_GOOD:	/* instruction uses slot */
> +		p->ainsn.insn = get_insn_slot();
> +		if (!p->ainsn.insn)
> +			return -ENOMEM;
> +		break;
> +	};
> +
> +	/* prepare the instruction */
> +	arch_prepare_ss_slot(p);
> +
> +	return 0;
> +}
> +
