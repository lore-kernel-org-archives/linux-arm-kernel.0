From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 15 May 2017 08:59:35 +0200
Subject: [PATCH] ARM: KVM: Fix tracepoint generation after move to
 virt/kvm/arm/
In-Reply-To: <20170512100452.8245-1-marc.zyngier@arm.com>
References: <20170512100452.8245-1-marc.zyngier@arm.com>
Message-ID: <20170515065935.GE9309@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 11:04:52AM +0100, Marc Zyngier wrote:
> Moving most of the shared code to virt/kvm/arm had for consequence
> that KVM/ARM doesn't build anymore, because the code that used to
> define the tracepoints is now somewhere else.
> 
> Fix this by defining CREATE_TRACE_POINTS in coproc.c, and clean-up
> trace.h as well.
> 
> Fixes: 35d2d5d490e2 ("KVM: arm/arm64: Move shared files to virt/kvm/arm")

Whoops.

> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, applied to kvmarm/master.

-Christoffer

> ---
>  arch/arm/kvm/coproc.c | 1 +
>  arch/arm/kvm/trace.h  | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 2c14b69511e9..ac8d36da4d08 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -32,6 +32,7 @@
>  #include <asm/vfp.h>
>  #include "../vfp/vfpinstr.h"
>  
> +#define CREATE_TRACE_POINTS
>  #include "trace.h"
>  #include "coproc.h"
>  
> diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
> index fc0943776db2..b0d10648c486 100644
> --- a/arch/arm/kvm/trace.h
> +++ b/arch/arm/kvm/trace.h
> @@ -1,5 +1,5 @@
> -#if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _TRACE_KVM_H
> +#if !defined(_TRACE_ARM_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ARM_KVM_H
>  
>  #include <linux/tracepoint.h>
>  
> @@ -74,10 +74,10 @@ TRACE_EVENT(kvm_hvc,
>  		  __entry->vcpu_pc, __entry->r0, __entry->imm)
>  );
>  
> -#endif /* _TRACE_KVM_H */
> +#endif /* _TRACE_ARM_KVM_H */
>  
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH arch/arm/kvm
> +#define TRACE_INCLUDE_PATH .
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE trace
>  
> -- 
> 2.11.0
> 
