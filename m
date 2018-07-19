From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 13:08:10 +0200
Subject: [RFC PATCH 10/16] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
In-Reply-To: <1529593060-542-11-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-11-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180719110810.2edkoz53b6vrafum@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 03:57:34PM +0100, Dave Martin wrote:
> Since SVE will be enabled or disabled on a per-vcpu basis, a flag
> is needed in order to track which vcpus have it enabled.
> 
> This patch adds a suitable flag and a helper for checking it.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 9671ddd..609d08b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -308,6 +308,14 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
>  #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
>  #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
> +#define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
> +
> +static inline bool vcpu_has_sve(struct kvm_vcpu_arch const *vcpu_arch)
> +{
> +	return system_supports_sve() &&

system_supports_sve() checks cpus_have_const_cap(), not
this_cpu_has_cap(), so, iiuc, the result of this check won't
change, regardless of which cpu it's run on at the time.

> +		(vcpu_arch->flags & KVM_ARM64_GUEST_HAS_SVE);

Since this flag can only be set if system_supports_sve() is
true at vcpu init time, then it isn't necessary to always check
system_supports_sve() in this function. Or, should
system_supports_sve() be changed to use this_cpu_has_cap()?

Thanks,
drew

> +
> +}
>  
>  #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
>  
> -- 
> 2.1.4
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
