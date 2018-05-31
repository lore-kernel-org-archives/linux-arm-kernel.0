From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 12:51:27 +0100
Subject: [PATCH v2 2/6] arm64: KVM: Handle Set/Way CMOs as NOPs if FWB is
 present
In-Reply-To: <20180530124706.25284-3-marc.zyngier@arm.com>
References: <20180530124706.25284-1-marc.zyngier@arm.com>
 <20180530124706.25284-3-marc.zyngier@arm.com>
Message-ID: <20180531115127.2ymmtlwemz6g5qzj@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 01:47:02PM +0100, Marc Zyngier wrote:
> Set/Way handling is one of the ugliest corners of KVM. We shouldn't
> have to handle that, but better safe than sorry.
> 
> Thankfully, FWB fixes this for us by not requiering any maintenance
> whatsoever, which means we don't have to emulate S/W CMOs, and don't
> have to track VM ops either.
> 
> We still have to trap S/W though, if only to prevent the guest from
> doing something bad.

S/W ops *also* do I-cache maintenance, so we'd still need to emulate
that. Though it looks like we're missing that today...

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 6e3b969391fd..9a740f159245 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -195,7 +195,13 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
>  	if (!p->is_write)
>  		return read_from_write_only(vcpu, p, r);
>  
> -	kvm_set_way_flush(vcpu);
> +	/*
> +	 * Only track S/W ops if we don't have FWB. It still indicates
> +	 * that the guest is a bit broken...
> +	 */
> +	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> +		kvm_set_way_flush(vcpu);
> +

Assuming we implement I-cache maintenance, we can have something like:

	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
		kvm_set_way_flush_dcache(vcpu);

	kvm_set_way_flush_icache(vcpu);

Thanks,
Mark.

>  	return true;
>  }
>  
> -- 
> 2.17.1
> 
