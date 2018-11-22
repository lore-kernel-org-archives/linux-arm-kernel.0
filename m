From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 16:59:44 +0100
Subject: [RFC PATCH v3 05/17] irqchip/sun4i: add support for suniv
 interrupt controller
In-Reply-To: <20181122150200.p6e22sp3v4npb42w@ThinkPad>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
 <20181122083547.srnopylueqx6p2qj@flea>
 <20181122150200.p6e22sp3v4npb42w@ThinkPad>
Message-ID: <20181122155944.vkx2u4iwwedheor2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 06:02:00PM +0300, Mesih Kilinc wrote:
> > > diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> > > index e3e5b91..7ca4a4d 100644
> > > --- a/drivers/irqchip/irq-sun4i.c
> > > +++ b/drivers/irqchip/irq-sun4i.c
> > > @@ -28,11 +28,21 @@
> > >  #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
> > >  #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
> > >  #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
> > > -#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
> > > -#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
> > > +#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0x4 * x)
> > > +#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 * x)
> > 
> > You shouldn't have all the values you use passed as argument, so
> > irq_ic_data should be one of them here.
> >
>
> Could you elaborate it a little bit?

You should change your macro to something like:

SUN4I_IRQ_ENABLE_REG(data, x) ((data)->enable_req_offset + 0x4 * x)

That way, you are transparent about the parameters that the macro
expects, and don't rely on some unwritten rule about the variable
name.

> > > +
> > > +static int __init suniv_ic_of_init(struct device_node *node,
> > > +				   struct device_node *parent)
> > > +{
> > > +	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
> > > +	if (!irq_ic_data) {
> > > +		pr_err("kzalloc failed!\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	irq_ic_data->enable_req_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
> > > +	irq_ic_data->mask_req_offset = SUNIV_IRQ_MASK_REG_OFFSET;
> > > +
> > > +	return sun4i_of_init(node, parent);
> > > +}
> > > +
> > > +IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
> > 
> > You can even split that addition to a new patch as well.
> 
> OK. I will do 3 patches. First one will add a struct that holds only
> base and domain. Second one will add register offsets to that struct. 
> Third one will add f1c100s support. Is that ok?

Sounds perfect :)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/6f17eed2/attachment.sig>
