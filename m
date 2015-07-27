From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 27 Jul 2015 13:35:20 +0100
Subject: [PATCH v2] xen/events: Support event channel rebind on ARM
In-Reply-To: <1437996911-18985-1-git-send-email-julien.grall@citrix.com>
References: <1437996911-18985-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55B62588.3050502@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/15 12:35, Julien Grall wrote:
> Currently, the event channel rebind code is gated with the presence of
> the vector callback.
> 
> The virtual interrupt controller on ARM has the concept of per-CPU
> interrupt (PPI) which allow us to support per-VCPU event channel.
> Therefore there is no need of vector callback for ARM.
> 
> Xen is already using a free PPI to notify the guest VCPU of an event.
> Furthermore, the xen code initialization in Linux (see
> arch/arm/xen/enlighten.c) is requesting correctly a per-CPU IRQ.
> 
> Introduce new helper xen_support_evtchn_rebind to allow architecture
> decide whether rebind an event is support or not. It will always return
> 1 on ARM and keep the same behavior on x86.
> 
> This is also allow us to drop the usage of xen_have_vector_callback
> entirely in the ARM code.

This did not apply cleanly.  Please always base patches on Linus's
master branch.

This also breaks the x86 build.

/local/davidvr/work/k.org/tip/arch/x86/include/asm/xen/events.h: In
function ?xen_support_evtchn_rebind?:
/local/davidvr/work/k.org/tip/arch/x86/include/asm/xen/events.h:29:85:
error: ?xen_have_vector_callback? undeclared (first use in this function)
  return (!xen_hvm_domain() || xen_have_vector_callback);

> --- a/arch/arm/include/asm/xen/events.h
> +++ b/arch/arm/include/asm/xen/events.h
> @@ -20,4 +20,10 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
>  							    atomic64_t,	\
>  							    counter), (val))
>  
> +/* Rebind event channel is supported by default */
> +static inline bool xen_support_evtchn_rebind(void)
> +{
> +	return 1;

This should be true (similarly for arm64).

David
