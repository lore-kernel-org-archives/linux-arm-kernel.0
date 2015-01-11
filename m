From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 22:17:13 +0100
Subject: [PATCH v5 4/5] KVM: irqfd: use
 kvm_arch_is_virtual_intc_initialized
In-Reply-To: <1417622832-5460-5-git-send-email-eric.auger@linaro.org>
References: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
 <1417622832-5460-5-git-send-email-eric.auger@linaro.org>
Message-ID: <20150111211713.GF3868@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 05:07:11PM +0100, Eric Auger wrote:
> On arm/arm64, the interrupt controller is dynamically instantiated.
> There is a risk the user-space assigns an irqfd before this latter
> is initialized and ready to accept virtual irq injection. On such
> attempt, the IRQFD setup is rejected and -EAGAIN is returned.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  virt/kvm/eventfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index b0fb390..f837c83 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -314,6 +314,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	unsigned int events;
>  	int idx;
>  
> +	if (!kvm_arch_is_virtual_intc_initialized(kvm))
> +		return -EAGAIN;
> +

You can fold this into the patch that defines the static inline since
nothing defines the KVM_HAVE_ARCH_... yet.

>  	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
>  	if (!irqfd)
>  		return -ENOMEM;
> -- 
> 1.9.1
> 
