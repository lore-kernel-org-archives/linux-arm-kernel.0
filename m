From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 16 Oct 2013 15:11:32 -0700
Subject: [RFC PATCH 1/5] ARM/ARM64: KVM: Update user space API header for
 PSCI emulation
In-Reply-To: <1381942954-22388-2-git-send-email-anup.patel@linaro.org>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-2-git-send-email-anup.patel@linaro.org>
Message-ID: <20131016221132.GE24837@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 10:32:30PM +0530, Anup Patel wrote:
> Update user space API interface headers for providing information to
> user space needed to emulate PSCI function calls in user space (i.e.
> QEMU or KVMTOOL).
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  include/uapi/linux/kvm.h |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index e32e776..dae2664 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>  #define KVM_EXIT_WATCHDOG         21
>  #define KVM_EXIT_S390_TSCH        22
>  #define KVM_EXIT_EPR              23
> +#define KVM_EXIT_PSCI             24
>  
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -301,6 +302,12 @@ struct kvm_run {
>  		struct {
>  			__u32 epr;
>  		} epr;
> +		/* KVM_EXIT_PSCI */
> +		struct {
> +			__u32 fn;
> +			__u64 args[7];
> +			__u64 ret[4];
> +		} psci;
>  		/* Fix the size of the union. */
>  		char padding[256];
>  	};
> -- 
> 1.7.9.5
> 
I am also wondering if this is not solving a very specific need without
thinking a little more carefully about this problem.

We have previously discussed the need for some secure side emulation
in QEMU, and I think perhaps we need something more generic which allows
user space to handle SMC calls and/or allows user space to "inject" some
secure world runtime that the kernel can run in a partially or fully
isolated container to handle SMC calls.

Peter raised this issue previously and pointed to a proposal he had as
well.

Is there a technical reason why we need something specifically directed
to PSCI?

-Christoffer
