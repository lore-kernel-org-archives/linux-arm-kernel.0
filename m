From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 15 Nov 2018 15:44:18 +0000
Subject: [RFC PATCH v2 08/23] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
In-Reply-To: <1538141967-15375-9-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-9-git-send-email-Dave.Martin@arm.com>
Message-ID: <87h8gicpm5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> Since SVE will be enabled or disabled on a per-vcpu basis, a flag
> is needed in order to track which vcpus have it enabled.
>
> This patch adds a suitable flag and a helper for checking it.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

> ---
>
> Changes since RFCv1:
>
>  * Convert vcpu_has_sve() to a macro so that it can operate on a vcpu
>    without circular header dependency problems.
>
>    This avoids the helper requiring a vcpu_arch argument, which was
>    a little ugly.
> ---
>  arch/arm64/include/asm/kvm_host.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index d4b65414..20baf4a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -307,6 +307,10 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
>  #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
>  #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
> +#define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
> +
> +#define vcpu_has_sve(vcpu) (system_supports_sve() && \
> +			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
>
>  #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)


--
Alex Benn?e
