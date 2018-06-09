From: christoffer.dall@arm.com (Christoffer Dall)
Date: Sat, 9 Jun 2018 11:26:40 +0200
Subject: [PATCH v2 2/6] arm64: KVM: Handle Set/Way CMOs as NOPs if FWB is
 present
In-Reply-To: <20180530124706.25284-3-marc.zyngier@arm.com>
References: <20180530124706.25284-1-marc.zyngier@arm.com>
 <20180530124706.25284-3-marc.zyngier@arm.com>
Message-ID: <20180609092640.GD5097@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 01:47:02PM +0100, Marc Zyngier wrote:
> Set/Way handling is one of the ugliest corners of KVM. We shouldn't
> have to handle that, but better safe than sorry.
> 
> Thankfully, FWB fixes this for us by not requiering any maintenance
> whatsoever, which means we don't have to emulate S/W CMOs, and don't
> have to track VM ops either.

I tiny bit of rationale here would have been nice.  As I understand it,
if we're presenting the guest with a fully coherent system, there should
never be a need to invalidate anything, because the guest will always
see the most recent value no matter how it sings and dances, right?

> 
> We still have to trap S/W though, if only to prevent the guest from
> doing something bad.
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

Is it strictly true that the guest is broken if it does any form of S/W
ops?  Does the guest actually know that it's running on a fully coherent
system, or is the argument that no software, ever, should do S/W, even
for reboot etc.?

I think this should have slightly more info, or that part of the comment
should just be dropped, to avoid misleading future readers who don't
have the full picture.

> +	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> +		kvm_set_way_flush(vcpu);
> +
>  	return true;
>  }
>  
> -- 
> 2.17.1
> 

Besides the usual nits on commentary:

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
