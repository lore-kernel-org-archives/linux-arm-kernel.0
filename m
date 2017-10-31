From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 31 Oct 2017 07:23:15 +0100
Subject: [PATCH v4 20/21] KVM: arm64: Take any host SError before
 entering the guest
In-Reply-To: <20171019145807.23251-21-james.morse@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-21-james.morse@arm.com>
Message-ID: <20171031062315.GY2166@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Thu, Oct 19, 2017 at 03:58:06PM +0100, James Morse wrote:
> On VHE systems KVM masks SError before switching the VBAR value. Any
> host RAS error that the CPU knew about before world-switch may become
> pending as an SError during world-switch, and only be taken once we enter
> the guest.
> 
> Until KVM can take RAS SErrors during world switch, add an ESB to
> force any RAS errors to be synchronised and taken on the host before
> we enter world switch.
> 
> RAS errors that become pending during world switch are still taken
> once we enter the guest.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index cf5d78ba14b5..5dc6f2877762 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -392,6 +392,7 @@ static inline void __cpu_init_stage2(void)
>  
>  static inline void kvm_arm_vhe_guest_enter(void)
>  {
> +	esb();

I don't fully appreciate what the point of this is?

As I understand it, our fundamental goal here is to try to distinguish
between errors happening on the host or in the guest.

If that's correct, then why don't we do it at the last possible moment
when we still have a scratch register left, in the world switch code
itself, and in the case abort the guest entry and report back a "host
SError" return code.

If the answer to that question is, that since we will always have some
instruction window before entering the guest and things will never be
precise anyway, so we do it here where it's more convenient, then my
counter-question would be why we do it at all then?  If we're not
precise anyway, then why not simply take our chances and hope that the
hardware delivers the SError before we mask them, and if not, tough
luck?

>  	local_daif_mask();
>  }
>  
> -- 
> 2.13.3
> 

Thanks,
-Christoffer
