From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 28 Mar 2017 14:46:04 +0200
Subject: [PATCH v2 7/9] arm64: KVM: Do not corrupt registers on failed
 64bit CP read
In-Reply-To: <20170327160345.12402-8-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-8-marc.zyngier@arm.com>
Message-ID: <20170328124600.GG31156@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:03:43PM +0100, Marc Zyngier wrote:
> If we fail to emulate a mrrc instruction, we:
> 1) deliver an exception,
> 2) spit a nastygram on the console,
> 3) write back some garbage to Rt/Rt2
> 
> While 1) and 2) are perfectly acceptable, 3) is out of the scope of
> the architecture... Let's mimick the code in kvm_handle_cp_32 and
> be more cautious.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 4e5d4eee8cec..1080a76e960f 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1678,20 +1678,18 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
>  		params.regval |= vcpu_get_reg(vcpu, Rt2) << 32;
>  	}
>  
> -	if (!emulate_cp(vcpu, &params, target_specific, nr_specific))
> -		goto out;
> -	if (!emulate_cp(vcpu, &params, global, nr_global))
> -		goto out;
> -
> -	unhandled_cp_access(vcpu, &params);
> +	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
> +	    !emulate_cp(vcpu, &params, global, nr_global)) {

super nit: I choked a bit on this contruct, any objections to adding a
comment like the following above:

	/*
	 * Try to emulate the coprocessor access using the target
	 * specific table first, and using the global table aftwards.
	 * If either of the tables contains a handler, handle the
	 * potential register operation in the case of a read and return
	 * with success.
	 */

Too much?

(If not, I can also add this when applying).

> +		/* Split up the value between registers for the read side */
> +		if (!params.is_write) {
> +			vcpu_set_reg(vcpu, Rt, lower_32_bits(params.regval));
> +			vcpu_set_reg(vcpu, Rt2, upper_32_bits(params.regval));
> +		}
>  
> -out:
> -	/* Split up the value between registers for the read side */
> -	if (!params.is_write) {
> -		vcpu_set_reg(vcpu, Rt, lower_32_bits(params.regval));
> -		vcpu_set_reg(vcpu, Rt2, upper_32_bits(params.regval));
> +		return 1;
>  	}
>  
> +	unhandled_cp_access(vcpu, &params);
>  	return 1;
>  }
>  
> -- 
> 2.11.0
> 

Otherwise:

Reviewed-by: Christoffer Dall <cdall@linaro.org>
