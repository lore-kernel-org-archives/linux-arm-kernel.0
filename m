From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Sep 2013 11:09:16 -0700
Subject: [PATCH 2/2] KVM: Add documentation for KVM_ARM_SUITABLE_TARGET
 ioctl
In-Reply-To: <1378904393-29101-3-git-send-email-anup.patel@linaro.org>
References: <1378904393-29101-1-git-send-email-anup.patel@linaro.org>
 <1378904393-29101-3-git-send-email-anup.patel@linaro.org>
Message-ID: <20130911180916.GI9860@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:29:53PM +0530, Anup Patel wrote:
> To implement CPU=Host we have added KVM_ARM_SUITABLE_TARGET ioctl
> which provides a CPU target type to user space for creating VCPU
> matching underlying Host.
> 
> This patch adds info related to this new KVM_ARM_SUITABLE_TARGET
> ioctl in the KVM API documentation.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>+
> ---
>  Documentation/virtual/kvm/api.txt |   25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index ef925ea..1ae9721 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2283,7 +2283,7 @@ current state.  "addr" is ignored.
>  Capability: basic
>  Architectures: arm, arm64
>  Type: vcpu ioctl
> -Parameters: struct struct kvm_vcpu_init (in)
> +Parameters: struct kvm_vcpu_init (in)
>  Returns: 0 on success; -1 on error
>  Errors:
>   ?EINVAL: ???the target is unknown, or the combination of features is invalid.
> @@ -2303,8 +2303,24 @@ Possible features:
>  	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>  	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).

unrelated change, can you put in separate patch?

>  
> +4.83 KVM_ARM_SUITABLE_TARGET

hmm, I'm a little uneasy about the use of the word 'suitable'.
KVM_ARM_PREFERRED_TARGET ?

>  
> -4.83 KVM_GET_REG_LIST
> +Capability: basic
> +Architectures: arm, arm64
> +Type: vcpu ioctl

this should be a system ioctl (or at least a VM ioctl) so we can query
the preferred vcpu without creating one.

> +Parameters: None
> +Returns: 0 on success; -1 on error

no parameters and return 0 on success?

I would suggest returning struct kvm_vcpu_init (out) instead.  It makes
for a more flexible API in case we want to say something about the
preferred/supported vcpu features as well in the future.

> +Errors:
> + ?EINVAL: ???no suitable target available for the host

EINVAL is not really a proper error code for this IMHO, because it
indicates the user supplied something incorrect.  How about ENODEV?

> +
> +This queries KVM for suitable CPU target type which can be emulated by 
> +KVM on underlying host. This is not a mandatory API and could be used
> +to create VCPUs matching underlying host.

this last sentece caused me to trip.  Isn't the second part of the
sentence (after the 'and') what you are trying to say in the first
sentece, and what you want to say here is that it is not required to
call this ioctl before calling KVM_ARM_VCPU_INIT?  I'm not sure this
information is required at all, but it doesn't hurt I guess.

> +
> +The ioctl returns a target type which can be directly passed-back to 

s/passed-back/passed back/
or consider revising it to "... which can be used for the target type in
the KVM_ARM_VCPU_INIT ioctl."

> +the KVM_ARM_VCPU_INIT ioctl.
> +
> +4.84 KVM_GET_REG_LIST
>  
>  Capability: basic
>  Architectures: arm, arm64
> @@ -2323,8 +2339,7 @@ struct kvm_reg_list {
>  This ioctl returns the guest registers that are supported for the
>  KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
>  
> -
> -4.84 KVM_ARM_SET_DEVICE_ADDR
> +4.85 KVM_ARM_SET_DEVICE_ADDR
>  
>  Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
>  Architectures: arm, arm64
> @@ -2362,7 +2377,7 @@ must be called after calling KVM_CREATE_IRQCHIP, but before calling
>  KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
>  base addresses will return -EEXIST.
>  
> -4.85 KVM_PPC_RTAS_DEFINE_TOKEN
> +4.86 KVM_PPC_RTAS_DEFINE_TOKEN
>  
>  Capability: KVM_CAP_PPC_RTAS
>  Architectures: ppc
> -- 
> 1.7.9.5
> 
