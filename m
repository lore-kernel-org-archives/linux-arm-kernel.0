From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 2 May 2018 17:56:07 +0200
Subject: [PATCH 10/17] irqchip/irq-mvebu-sei: add new driver for Marvell
 SEI
In-Reply-To: <20180502111744.5391afff@windsurf.home>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-11-miquel.raynal@bootlin.com>
 <20180502111744.5391afff@windsurf.home>
Message-ID: <20180502175607.3a34a068@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 2 May 2018 11:17:44 +0200, Thomas Petazzoni wrote:

> > +static const struct irq_domain_ops mvebu_sei_ap_domain_ops = {
> > +	.xlate = irq_domain_xlate_onecell,
> > +	.alloc = mvebu_sei_irq_domain_alloc,
> > +	.free = mvebu_sei_irq_domain_free,
> > +};
> > +
> > +static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
> > +	.xlate = irq_domain_xlate_twocell,
> > +	.alloc = mvebu_sei_irq_domain_alloc,
> > +	.free = mvebu_sei_irq_domain_free,
> > +};  
> 
> Why do you need two cells for the interrupts coming from the CP and
> only one cell for the interrupts coming from the AP ?
> 
> For thermal in the AP, you do:
> 
> +					interrupt-parent = <&sei_wired_controller>;
> +					interrupts = <18>;
> 
> i.e, you don't specify an interrupt type. For thermal in the CP, you do:
> 
> +				interrupts-extended =
> +					<&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
> 
> here you specify an interrupt type. I'm not sure why you have this
> difference. Even more so because I think a SEI level interrupt is not
> possible, since you only have a "SET" register and no "CLR" register.

OK, my comment is not very correct here, I'm comparing apple to
oranges. The former its an interrupt directly pointing to the GICP_SEI,
while the latter is an interrupt of the ICU, which itself will notify
the GICP_SEI through an MSI.

However, I'm still confused as to why you have .xlate =
irq_domain_xlate_twocell for the mvebu_sei_cp_domain_ops. I think there
is no need for ->xlate() call back here because it's going to be a MSI
domain.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
