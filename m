From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 22:11:29 +0100
Subject: [PATCH v5 2/5] KVM: introduce kvm_arch_is_virtual_intc_initialized
In-Reply-To: <1417622832-5460-3-git-send-email-eric.auger@linaro.org>
References: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
 <1417622832-5460-3-git-send-email-eric.auger@linaro.org>
Message-ID: <20150111211129.GD3868@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 05:07:09PM +0100, Eric Auger wrote:
> Introduce __KVM_HAVE_ARCH_VIRTUAL_INTC_INITIALIZED define and
> associated kvm_arch_is_virtual_intc_initialized function. This latter
> allows to test whether the virtual interrupt controller is initialized
> and ready to accept virtual IRQ injection. On some architectures,
> the virtual interrupt controller is dynamically instantiated, justifying
> that kind of check.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  include/linux/kvm_host.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ea53b04..45fea3c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -696,6 +696,18 @@ static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
>  #endif
>  }
>  
> +#ifndef __KVM_HAVE_ARCH_VIRTUAL_INTC_INITIALIZED

maybe you can drop the _virtual_ from all these names to make it
slightly shorter.

alternatively to this approach you could expose a function from the
irqfd layer that KVM intc implementations call into to say "I'm
ready"...  Not sure if it would look nicer.

> +/*
> + * returns trues if the virtual interrupt controller is initialized and
> + * ready to accept virtual IRQ. On some architectures the virtual interrupt
> + * controller is dynamically instantiated and this is not always true.
> + */
> +static inline bool kvm_arch_is_virtual_intc_initialized(struct kvm *kvm)
> +{
> +	return true;
> +}

don't you need to define a prototype if the architecture does define the
symbol?

> +#endif
> +
>  int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
>  void kvm_arch_destroy_vm(struct kvm *kvm);
>  void kvm_arch_sync_events(struct kvm *kvm);
> -- 
> 1.9.1
> 
