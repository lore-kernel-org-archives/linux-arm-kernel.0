From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 27 Sep 2018 18:01:31 +0100
Subject: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
In-Reply-To: <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
 <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
Message-ID: <89110505-da2e-3266-c2aa-6e5128c520a4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/18 13:12, Maciej Slodczyk wrote:
[...]
> @@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   		unsigned long addr)
>   {
>   	probes_opcode_t insn;
> +	enum probes_insn retval;
> +	unsigned int bpinsn;
>   
> -	/* TODO: Currently we do not support AARCH32 instruction probing */
> -	if (mm->context.flags & MMCF_AARCH32)
> -		return -ENOTSUPP;
> -	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
> +	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
> +
> +	if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>   		return -EINVAL;
>   
> -	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
> +	/* check if AARCH32 */
> +	if (is_compat_task()) {
> +
> +		/* Thumb is not supported yet */
> +		if (addr & 0x3)

I'm only skimming, so forgive me if I'm missing something which should 
be obvious, but this has a big red flag all over it. If "addr" is the 
actual instruction address (or even a branch target, for a 
non-interworking branch), plenty of Thumb instructions will just happen 
to lie at 4-byte-aligned addresses anyway.

Furthermore, how would this check ever catch anything anyway given 
!IS_ALIGNED(addr, AARCH64_INSN_SIZE) above?

Robin.
