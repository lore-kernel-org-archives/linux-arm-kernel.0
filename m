From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 12:20:03 +0000
Subject: [PATCH v3 30/62] arm/irq: Add helper function for setting
 interrupt type
In-Reply-To: <1447753261-7552-31-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-31-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261218260.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Add a helper function to set edge/level type information for an
> interrupt.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/irq.c        | 22 +++++++++++++++-------
>  xen/include/asm-arm/irq.h |  2 ++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/xen/arch/arm/irq.c b/xen/arch/arm/irq.c
> index 1f38605..90b6e58 100644
> --- a/xen/arch/arm/irq.c
> +++ b/xen/arch/arm/irq.c
> @@ -655,6 +655,19 @@ unlock:
>      return ret;
>  }
>  
> +int irq_set_type(unsigned int irq, unsigned int type)
> +{
> +    int res;
> +
> +    /* Setup the IRQ type */
> +    if ( irq < NR_LOCAL_IRQS )
> +        res = irq_local_set_type(irq, type);
> +    else
> +        res = irq_set_spi_type(irq, type);
> +
> +    return res;
> +}
> +
>  int platform_get_irq(const struct dt_device_node *device, int index)
>  {
>      struct dt_irq dt_irq;
> @@ -668,14 +681,9 @@ int platform_get_irq(const struct dt_device_node *device, int index)
>      irq = dt_irq.irq;
>      type = dt_irq.type;
>  
> -    /* Setup the IRQ type */
> -    if ( irq < NR_LOCAL_IRQS )
> -        res = irq_local_set_type(irq, type);
> -    else
> -        res = irq_set_spi_type(irq, type);
> -
> +    res = irq_set_type(irq, type);
>      if ( res )
> -            return -1;
> +        return -1;

I would just as well do:

if ( irq_set_type(irq, type) )
    return -1;

and remove res.

In any case:

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>      return irq;
>  }
> diff --git a/xen/include/asm-arm/irq.h b/xen/include/asm-arm/irq.h
> index f33c331..493773c 100644
> --- a/xen/include/asm-arm/irq.h
> +++ b/xen/include/asm-arm/irq.h
> @@ -52,6 +52,8 @@ void arch_move_irqs(struct vcpu *v);
>  /* Set IRQ type for an SPI */
>  int irq_set_spi_type(unsigned int spi, unsigned int type);
>  
> +int irq_set_type(unsigned int irq, unsigned int type);
> +
>  int platform_get_irq(const struct dt_device_node *device, int index);
>  
>  void irq_set_affinity(struct irq_desc *desc, const cpumask_t *cpu_mask);
> -- 
> 2.1.0
> 
