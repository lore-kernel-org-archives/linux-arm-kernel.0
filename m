From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 20 Nov 2014 21:14:56 +0900
Subject: [PATCH v2 1/3] ARM: kprobes: introduces checker
In-Reply-To: <1416291582-74982-2-git-send-email-wangnan0@huawei.com>
References: <1416291582-74982-1-git-send-email-wangnan0@huawei.com>
 <1416291582-74982-2-git-send-email-wangnan0@huawei.com>
Message-ID: <546DDB40.6040604@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/11/18 15:19), Wang Nan wrote:
> diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> index 6d64420..f114a3f 100644
> --- a/arch/arm/kernel/kprobes.c
> +++ b/arch/arm/kernel/kprobes.c
> @@ -61,6 +61,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	kprobe_decode_insn_t *decode_insn;
>  	const union decode_action *actions;
>  	int is;
> +	const struct decode_checker **checkers;
>  
>  	if (in_exception_text(addr))
>  		return -EINVAL;
> @@ -74,9 +75,11 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		insn = __opcode_thumb32_compose(insn, inst2);
>  		decode_insn = thumb32_probes_decode_insn;
>  		actions = kprobes_t32_actions;
> +		checkers = kprobes_t32_checkers;
>  	} else {
>  		decode_insn = thumb16_probes_decode_insn;
>  		actions = kprobes_t16_actions;
> +		checkers = kprobes_t16_checkers;
>  	}
>  #else /* !CONFIG_THUMB2_KERNEL */
>  	thumb = false;
> @@ -85,12 +88,13 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	insn = __mem_to_opcode_arm(*p->addr);
>  	decode_insn = arm_probes_decode_insn;
>  	actions = kprobes_arm_actions;
> +	checkers = kprobes_arm_checkers;
>  #endif
>  
>  	p->opcode = insn;
>  	p->ainsn.insn = tmp_insn;
>  
> -	switch ((*decode_insn)(insn, &p->ainsn, true, actions)) {
> +	switch ((*decode_insn)(insn, &p->ainsn, true, actions, NULL)) {

BTW, even if checkers always empty at this point, we should pass the checkers to this function.

Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
