From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 May 2015 18:37:21 +0100
Subject: [PATCH 4/4] ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV |
 BPF_K intruction.
In-Reply-To: <1430314657-2552-5-git-send-email-nschichan@freebox.fr>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
 <1430314657-2552-5-git-send-email-nschichan@freebox.fr>
Message-ID: <20150501173721.GO12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 03:37:37PM +0200, Nicolas Schichan wrote:
> In that case, emit_udiv() will be called with rn == ARM_R0 (r_scratch)
> and loading rm first into ARM_R0 will result in jit_udiv() function
> being called the same dividend and divisor. Fix that by loading rn
> first into ARM_R1 and then rm into ARM_R0.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> ---
>  arch/arm/net/bpf_jit_32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index b5f470d..ffaf311 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -449,10 +449,10 @@ static inline void emit_udiv(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx)
>  		return;
>  	}
>  #endif
> -	if (rm != ARM_R0)
> -		emit(ARM_MOV_R(ARM_R0, rm), ctx);
>  	if (rn != ARM_R1)
>  		emit(ARM_MOV_R(ARM_R1, rn), ctx);
> +	if (rm != ARM_R0)
> +		emit(ARM_MOV_R(ARM_R0, rm), ctx);

I don't think you've thought enough about this.  What if rm is ARM_R1?
What if rn = ARM_R0 and rm = ARM_R1?

How about:

	if (rn == ARM_R0 && rm == ARM_R1) {
		emit(ARM_MOV_R(ARM_R3, rn), ctx); // r3 <- r0(rn)
		emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- r1(rm)
		emit(ARM_MOV_R(ARM_R1, ARM_R3), ctx); // r1 <- r3
	} else if (rn == ARM_R0) {
		emit(ARM_MOV_R(ARM_R1, rn), ctx); // r1 <- rn
		if (rm != ARM_R0)
			emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- rm
	} else {
		if (rm != ARM_R0)
			emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- rm
		if (rn != ARM_R1)
			emit(ARM_MOV_R(ARM_R1, rn), ctx); // r1 <- rn
	}

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
