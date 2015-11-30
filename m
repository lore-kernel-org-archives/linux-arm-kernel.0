From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:42:03 +0000
Subject: [Xen-devel] [PATCH v3 60/62] arm/acpi: Configure interrupts
 dynamically
In-Reply-To: <1447753261-7552-61-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-61-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565C6E4B.7020401@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Interrupt information is described in DSDT and is not available at
> the time of booting. Configure the interrupts dynamically when requested
> by Dom0

Missing ".".

As said on a previous version of this patch [1], I'd like to keep the
ACPI changes very contained to Xen boot. Your change is not ACPI
specific and could be used for DT.

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
> +
>  void vgic_enable_irqs(struct vcpu *v, uint32_t r, int n)
>  {
>      struct domain *d = v->domain;
> @@ -321,7 +324,23 @@ void vgic_enable_irqs(struct vcpu *v, uint32_t r, int n)
>      struct vcpu *v_target;
>  
>      while ( (i = find_next_bit(&mask, 32, i)) < 32 ) {
> +#ifdef CONFIG_ACPI
> +        struct vgic_irq_rank *vr = vgic_get_rank(v, n);
> +        uint32_t tr;
> +
>          irq = i + (32 * n);
> +        if( ( !acpi_disabled ) && ( n != 0 ) && is_hardware_domain(d) )

You need to add a comment explaining the ( n != 0 ) i.e we don't SGIs
and PPIs are RO. It's implementation defined for PPI but it's preferable
to let Xen take care of it.

Also, we should set the type only for IRQ assigned to DOM0 (i.e p->desc
!= NULL). With your current solution, DOM0 may change the configuration
of the serial IRQ by mistake and take down Xen because the physical IRQ
is enabled and the behavior will be unpredictable.

> +        {
> +            tr = vr->icfg[i >> 4] ;
> +
> +            if( ( tr & VGIC_ICFG_MASK(i) ) )
> +                irq_set_type(irq, ACPI_IRQ_TYPE_EDGE_BOTH);
> +            else
> +                irq_set_type(irq, ACPI_IRQ_TYPE_LEVEL_MASK);

Given that only SPI can be configured it would have been better to call
irq_set_type.

Although, those 2 functions don't do what you think. They are setting
the type internally in Xen but don't change the GIC interrupt
configuration register.

Lastly, they will fail because the configuration has been set earlier
(as you did in patch #55)

> +        }
> +#else
> +        irq = i + (32 * n);
> +#endif
>          v_target = d->arch.vgic.handler->get_target_vcpu(v, irq);
>          p = irq_to_pending(v_target, irq);
>          set_bit(GIC_IRQ_GUEST_ENABLED, &p->status);
> 

Regards,

[1] http://lists.xen.org/archives/html/xen-devel/2015-06/msg01128.html

-- 
Julien Grall
