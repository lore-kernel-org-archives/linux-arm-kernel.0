From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Oct 2017 17:47:18 +0100
Subject: [PATCH v3 06/20] KVM: arm/arm64: Check that system supports split
 eoi/deactivate
In-Reply-To: <20170923004207.22356-7-cdall@linaro.org>
References: <20170923004207.22356-1-cdall@linaro.org>
 <20170923004207.22356-7-cdall@linaro.org>
Message-ID: <edc875ee-335c-56c1-0cbc-9e45f7915529@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/17 01:41, Christoffer Dall wrote:
> Some systems without proper firmware and/or hardware description data
> don't support the split EOI and deactivate operation.
> 
> On such systems, we cannot leave the physical interrupt active after the
> timer handler on the host has run, so we cannot support KVM with an
> in-kernel GIC with the timer changes we are about to introduce.
> 
> This patch makes sure that trying to initialize the KVM GIC code will
> fail on such systems.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
>  drivers/irqchip/irq-gic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index f641e8e..ab12bf4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1420,7 +1420,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>  	if (ret)
>  		return;
>  
> -	gic_set_kvm_info(&gic_v2_kvm_info);
> +	if (static_key_true(&supports_deactivate))
> +		gic_set_kvm_info(&gic_v2_kvm_info);
>  }
>  
>  int __init
> 

Should we add the same level of checking on the ACPI path, just for the
sake symmetry?

Also, do we need to add the same thing for GICv3?

Otherwise looks OK to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
