From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 3 Feb 2017 14:53:25 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: Stop injecting the MSI occurrence
 twice
In-Reply-To: <1486089003-413-1-git-send-email-shankerd@codeaurora.org>
References: <1486089003-413-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170203135325.GL27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

[please cc the kvmarm list for kvm/arm patches, thanks]

On Thu, Feb 02, 2017 at 08:30:03PM -0600, Shanker Donthineni wrote:
> The IRQFD framework calls the architecture dependent function
> twice if the corresponding GSI type is edge triggered. For ARM,
> the function kvm_set_msi() is getting called twice whenever the
> IRQFD receives the event signal. The rest of the code path is
> trying to inject the MSI without any validation checks. No need
> to call the function vgic_its_inject_msi() second time to avoid
> an unnecessary overhead in IRQ queue logic. It also avoids the
> possibility of VM seeing the MSI twice.
> 
> Simple fix, return -1 if the argument 'level' value is zero.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  virt/kvm/arm/vgic/vgic-irqfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
> index d918dcf..f138ed2 100644
> --- a/virt/kvm/arm/vgic/vgic-irqfd.c
> +++ b/virt/kvm/arm/vgic/vgic-irqfd.c
> @@ -99,6 +99,9 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>  	if (!vgic_has_its(kvm))
>  		return -ENODEV;
>  
> +	if (!level)
> +		return -1;
> +
>  	return vgic_its_inject_msi(kvm, &msi);
>  }
>  
> -- 

Reviewed-by: Christoffer Dall <cdall@linaro.org>
