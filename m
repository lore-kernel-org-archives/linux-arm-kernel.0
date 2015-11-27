From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 16:13:15 +0000
Subject: [PATCH v3 60/62] arm/acpi: Configure interrupts dynamically
In-Reply-To: <1447753261-7552-61-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-61-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271557200.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Interrupt information is described in DSDT and is not available at
> the time of booting. Configure the interrupts dynamically when requested
> by Dom0
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/vgic.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/xen/arch/arm/vgic.c b/xen/arch/arm/vgic.c
> index 7bb4570..d05abde 100644
> --- a/xen/arch/arm/vgic.c
> +++ b/xen/arch/arm/vgic.c
> @@ -25,6 +25,7 @@
>  #include <xen/irq.h>
>  #include <xen/sched.h>
>  #include <xen/perfc.h>
> +#include <xen/acpi.h>
>  
>  #include <asm/current.h>
>  
> @@ -310,6 +311,8 @@ void vgic_disable_irqs(struct vcpu *v, uint32_t r, int n)
>      }
>  }
>  
> +#define VGIC_ICFG_MASK(intr) ( 1 << ( ( 2 * ( intr % 16 ) ) + 1 ) )

Coding style.


>  void vgic_enable_irqs(struct vcpu *v, uint32_t r, int n)
>  {
>      struct domain *d = v->domain;
> @@ -321,7 +324,23 @@ void vgic_enable_irqs(struct vcpu *v, uint32_t r, int n)
>      struct vcpu *v_target;
>  
>      while ( (i = find_next_bit(&mask, 32, i)) < 32 ) {
> +#ifdef CONFIG_ACPI
> +        struct vgic_irq_rank *vr = vgic_get_rank(v, n);

The rank is always the same, you can move this out of the while loop.


> +        uint32_t tr;
> +
>          irq = i + (32 * n);
> +        if( ( !acpi_disabled ) && ( n != 0 ) && is_hardware_domain(d) )

Instead of n != 0, I would prefer a more obvious irq >= 32 check


> +        {
> +            tr = vr->icfg[i >> 4] ;
> +
> +            if( ( tr & VGIC_ICFG_MASK(i) ) )

Coding style.


> +                irq_set_type(irq, ACPI_IRQ_TYPE_EDGE_BOTH);
> +            else
> +                irq_set_type(irq, ACPI_IRQ_TYPE_LEVEL_MASK);

Instead of this ad-hoc ACPI code, I would prefer if we get the irq type
and, if it is set to NONE or INVALID, we set it to what is in the
r->icfg (only for the hardware_domain of course). If it is set to
something other than NONE or INVALID, and it doesn't match what is on
r->icfg, then we could print out a warning.


> +        }
> +#else
> +        irq = i + (32 * n);
> +#endif

Please leave the irq = i + (32 * n) out of the #ifdef.


>          v_target = d->arch.vgic.handler->get_target_vcpu(v, irq);
>          p = irq_to_pending(v_target, irq);
>          set_bit(GIC_IRQ_GUEST_ENABLED, &p->status);
> -- 
> 2.1.0
> 
