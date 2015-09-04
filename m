From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Sep 2015 18:14:08 +0100
Subject: [PATCH v4 TRIVIAL 2/2] ARM: Fix GICv2m build warning on 32 bits
In-Reply-To: <1935621cb5eb23d740e8e49c1ab15dddcc14511c.1441373056.git.p.fedin@samsung.com>
References: <cover.1441373056.git.p.fedin@samsung.com>
 <1935621cb5eb23d740e8e49c1ab15dddcc14511c.1441373056.git.p.fedin@samsung.com>
Message-ID: <55E9D160.3090709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/15 14:29, Pavel Fedin wrote:
> After GICv2m was enabled for 32-bit ARM kernel, a warning popped up:
> 
> drivers/irqchip/irq-gic-v2m.c: In function ?gicv2m_compose_msi_msg?:
> drivers/irqchip/irq-gic-v2m.c:100:2: warning: right shift count >= width
> of type [enabled by default]
>   msg->address_hi = (u32) (addr >> 32);
>   ^
> 
> This patch fixes it by using proper macros for splitting up the value.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  drivers/irqchip/irq-gic-v2m.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index fdf7065..9055b02 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -97,8 +97,8 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
>  	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
>  
> -	msg->address_hi = (u32) (addr >> 32);
> -	msg->address_lo = (u32) (addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->address_lo = lower_32_bits(addr);
>  	msg->data = data->hwirq;
>  }
>  
> 

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

I'll add that to my queue of GIC fixes.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
