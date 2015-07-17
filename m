From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 17 Jul 2015 10:27:26 +0300
Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
Message-ID: <01d401d0c062$086c2ee0$19448ca0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On Behalf Of Eric Auger
> Sent: Thursday, July 09, 2015 11:22 AM
> To: eric.auger at st.com; eric.auger at linaro.org; linux-arm-kernel at lists.infradead.org;
> marc.zyngier at arm.com; christoffer.dall at linaro.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org
> Cc: patches at linaro.org; andre.przywara at arm.com; p.fedin at samsung.com; pbonzini at redhat.com
> Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
> 
> on ARM, a devid field is populated in kvm_msi struct in case the
> flag is set to KVM_MSI_VALID_DEVID. Let's populate the corresponding
> kvm_kernel_irq_routing_entry devid field and set the msi type to
> KVM_IRQ_ROUTING_EXTENDED_MSI.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  virt/kvm/irqchip.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 21c1424..e678f8a 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -72,9 +72,17 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
>  {
>  	struct kvm_kernel_irq_routing_entry route;
> 
> -	if (!irqchip_in_kernel(kvm) || msi->flags != 0)
> +	if (!irqchip_in_kernel(kvm))
>  		return -EINVAL;
> 
> +	if (msi->flags & KVM_MSI_VALID_DEVID) {
> +		route.devid = msi->devid;
> +		route.type = KVM_IRQ_ROUTING_EXTENDED_MSI;
> +	} else if (!msi->flags)
> +		return -EINVAL;

 Did you mean "if (msg->flags)" here (inverted condition)?

> +
> +	/* historically the route.type was not set */
> +
>  	route.msi.address_lo = msi->address_lo;
>  	route.msi.address_hi = msi->address_hi;
>  	route.msi.data = msi->data;
> --
> 1.9.1

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
