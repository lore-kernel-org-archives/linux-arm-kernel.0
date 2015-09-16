From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 16 Sep 2015 15:42:45 +0100
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
In-Reply-To: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
References: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <87vbbamnmi.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Marc Zyngier <marc.zyngier@arm.com> writes:

> When setting the debug register from userspace, make sure that
> copy_from_user() is called with its parameters in the expected
> order. It otherwise doesn't do what you think.

Oops. Well that exposes a big hole in my testing. While I tested
debugging inside the guest worked before and after being guest debugged
I think GDBs tendency to reload all the debug registers between each
step may have masked this.

Debugging GDB in action or some sort of migration event would of course
screw this up but I'm afraid my testing wasn't evil enough.

Anyway have a:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Benn?e <alex.bennee@linaro.org>
> Fixes: 84e690bfbed1 ("KVM: arm64: introduce vcpu->arch.debug_ptr")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index b41607d..1d0463e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -272,7 +272,7 @@ static int set_bvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  {
>  	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg];
>  
> -	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
> +	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
>  		return -EFAULT;
>  	return 0;
>  }
> @@ -314,7 +314,7 @@ static int set_bcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  {
>  	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bcr[rd->reg];
>  
> -	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
> +	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
>  		return -EFAULT;
>  
>  	return 0;
> @@ -358,7 +358,7 @@ static int set_wvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  {
>  	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wvr[rd->reg];
>  
> -	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
> +	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
>  		return -EFAULT;
>  	return 0;
>  }
> @@ -400,7 +400,7 @@ static int set_wcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  {
>  	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wcr[rd->reg];
>  
> -	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
> +	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
>  		return -EFAULT;
>  	return 0;
>  }

-- 
Alex Benn?e
