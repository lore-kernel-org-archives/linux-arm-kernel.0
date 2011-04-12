From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 12 Apr 2011 15:39:18 +0400
Subject: [PATCH 4/6] ARM: kprobes: Fix emulation of SXTB16, SXTB, SXTH,
	UXTB16,	UXTB and UXTH instructions
In-Reply-To: <1302590726-3484-5-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
	<1302590726-3484-5-git-send-email-tixy@yxit.co.uk>
Message-ID: <4DA439E6.90906@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-04-2011 10:45, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>

> These sign extension instructions are encoded as extend-and-add
> instructions where the register to add is specified as r15. The decoding
> routines weren't checking for this and were using the incorrect
> emulation code, giving incorrect results.

> Signed-off-by: Jon Medhurst<tixy@yxit.co.uk>
> ---
>   arch/arm/kernel/kprobes-decode.c |   14 ++++++++++++--
>   1 files changed, 12 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index a824a79..30ba313 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -1390,18 +1390,28 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>   		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
>
>   	/* SXTAB16   : cccc 0110 1000 xxxx xxxx xxxx 0111 xxxx :   */
> -	/* SXTB      : cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* SXTB16    : cccc 0110 1000 1111 xxxx xxxx 0111 xxxx :   */
>   	/* ???       : cccc 0110 1001 xxxx xxxx xxxx 0111 xxxx :   */
>   	/* SXTAB     : cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* SXTB      : cccc 0110 1010 1111 xxxx xxxx 0111 xxxx :   */
>   	/* SXTAH     : cccc 0110 1011 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* SXTH      : cccc 0110 1011 1111 xxxx xxxx 0111 xxxx :   */
>   	/* UXTAB16   : cccc 0110 1100 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* UXTB16    : cccc 0110 1100 1111 xxxx xxxx 0111 xxxx :   */
>   	/* ???       : cccc 0110 1101 xxxx xxxx xxxx 0111 xxxx :   */
>   	/* UXTAB     : cccc 0110 1110 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* UXTB      : cccc 0110 1110 1111 xxxx xxxx 0111 xxxx :   */
>   	/* UXTAH     : cccc 0110 1111 xxxx xxxx xxxx 0111 xxxx :   */
> +	/* UXTH      : cccc 0110 1111 1111 xxxx xxxx 0111 xxxx :   */
>   	if ((insn & 0x0f8000f0) == 0x06800070) {
>   		if ((insn & 0x00300000) == 0x00100000)
>   			return INSN_REJECTED;	/* Unallocated space */
> -		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
> +
> +		if ((insn & 0x000f0000) == 0x000f0000) {
> +			return prep_emulate_rd12rm0(insn, asi);
> +		} else {
> +			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
> +		}

    Why use {} around single statements? checkpatch.pl used to warn about this...

WBR, Sergei
