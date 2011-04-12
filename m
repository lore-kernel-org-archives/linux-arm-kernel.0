From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 12 Apr 2011 15:42:52 +0400
Subject: [PATCH 5/6] ARM: kprobes: Fix emulation of SMUAD, SMUSD and SMMUL
	instructions
In-Reply-To: <1302590726-3484-6-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
	<1302590726-3484-6-git-send-email-tixy@yxit.co.uk>
Message-ID: <4DA43ABC.8060105@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-04-2011 10:45, Tixy wrote:

> From: Jon Medhurst<tixy@yxit.co.uk>

> The signed multiply instructions were being decoded incorrectly.

> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> ---
>   arch/arm/kernel/kprobes-decode.c |   22 +++++++++++++++-------
>   1 files changed, 15 insertions(+), 7 deletions(-)

> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index 30ba313..915b057 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -1436,18 +1436,26 @@ space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>   		return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn, asi);
>
>   	/* SMLAD  : cccc 0111 0000 xxxx xxxx xxxx 00x1 xxxx :Q */
> +	/* SMUAD  : cccc 0111 0000 xxxx 1111 xxxx 00x1 xxxx :Q */
>   	/* SMLSD  : cccc 0111 0000 xxxx xxxx xxxx 01x1 xxxx :Q */
> +	/* SMUSD  : cccc 0111 0000 xxxx 1111 xxxx 01x1 xxxx :  */
>   	/* SMMLA  : cccc 0111 0101 xxxx xxxx xxxx 00x1 xxxx :  */
> -	/* SMMLS  : cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx :  */
> +	/* SMMUL  : cccc 0111 0101 xxxx 1111 xxxx 00x1 xxxx :  */
>   	if ((insn&  0x0ff00090) == 0x07000010 ||
> -	    (insn&  0x0ff000d0) == 0x07500010 ||
> -	    (insn&  0x0ff000d0) == 0x075000d0)
> +	    (insn&  0x0ff000d0) == 0x07500010) {
> +
> +		if ((insn&  0x0000f000) == 0x0000f000) {
> +			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
> +		} else {
> +			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
> +		}

    Why use {} around the single statements here?

> +	}
> +
> +	/* SMMLS  : cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx :  */
> +	if ((insn & 0x0ff000d0) == 0x075000d0)
>   		return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);

    ... but not here. It's at least inconsistent. :-)

WBR, Sergei
