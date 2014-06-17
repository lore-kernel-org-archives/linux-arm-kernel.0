From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jun 2014 20:43:07 +0200
Subject: [PATCH v2 4/5] pinctrl: sunxi: Properly handle level triggered
 gpio interrupts
In-Reply-To: <538DE60D.5070705@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-5-git-send-email-hdegoede@redhat.com>
 <20140603133022.GK27722@lukather> <538DE60D.5070705@redhat.com>
Message-ID: <20140617184307.GF3665@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 05:13:17PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 06/03/2014 03:30 PM, Maxime Ripard wrote:
> >On Sat, May 31, 2014 at 04:01:38PM +0200, Hans de Goede wrote:
> >>For level triggered gpio interrupts we need to use handle_fasteoi_irq,
> >>like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
> >>interrupt handlers a chance to actuall clear the source of the interrupt
> >>(which may involve sleeping waiting for i2c / spi / mmc transfers), before
> >>acknowledging the interrupt.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 57 +++++++++++++++++++++++++----------
> >>  1 file changed, 41 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >>index 61d3246..418a430 100644
> >>--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >>+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >>@@ -31,6 +31,11 @@
> >>  #include "../core.h"
> >>  #include "pinctrl-sunxi.h"
> >>
> >>+static void sunxi_pinctrl_irq_ack(struct irq_data *d);
> >>+static void sunxi_pinctrl_irq_mask(struct irq_data *d);
> >>+static void sunxi_pinctrl_irq_unmask(struct irq_data *d);
> >>+static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type);
> >>+
> >>  static struct sunxi_pinctrl_group *
> >>  sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
> >>  {
> >>@@ -545,10 +550,29 @@ static int sunxi_pinctrl_irq_request_resources(struct irq_data *d)
> >>  	return 0;
> >>  }
> >>
> >>-static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
> >>-				      unsigned int type)
> >>+static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
> >>+	.irq_ack		= sunxi_pinctrl_irq_ack,
> >>+	.irq_mask		= sunxi_pinctrl_irq_mask,
> >>+	.irq_unmask		= sunxi_pinctrl_irq_unmask,
> >>+	.irq_request_resources	= sunxi_pinctrl_irq_request_resources,
> >>+	.irq_set_type		= sunxi_pinctrl_irq_set_type,
> >>+	.flags			= IRQCHIP_SKIP_SET_WAKE,
> >>+};
> >>+
> >>+static struct irq_chip sunxi_pinctrl_level_irq_chip = {
> >>+	.irq_eoi		= sunxi_pinctrl_irq_ack,
> >>+	.irq_mask		= sunxi_pinctrl_irq_mask,
> >>+	.irq_unmask		= sunxi_pinctrl_irq_unmask,
> >>+	.irq_request_resources	= sunxi_pinctrl_irq_request_resources,
> >>+	.irq_set_type		= sunxi_pinctrl_irq_set_type,
> >>+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED
> >>+				  | IRQCHIP_EOI_IF_HANDLED,
> >>+};
> >
> >Maybe we can just forward declare these two structures, instead of all
> >their functions.
> 
> Variables cannot be forward declared, they can be declared extern, but last
> time I checked extern and static don't mix.

Actually, you can. It's called a tentative definition, see
http://c0x.coding-guidelines.com/6.9.2.html and
http://c0x.coding-guidelines.com/6.2.2.html for the definition of
internal linkage.

Maxime

> 
> >
> >>+
> >>+static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
> >>  {
> >>  	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> >>+	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
> >>  	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
> >>  	u8 index = sunxi_irq_cfg_offset(d->hwirq);
> >>  	unsigned long flags;
> >>@@ -575,6 +599,14 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
> >>  		return -EINVAL;
> >>  	}
> >>
> >>+	if (type & IRQ_TYPE_LEVEL_MASK) {
> >>+		d->chip = &sunxi_pinctrl_level_irq_chip;
> >>+		desc->handle_irq = handle_fasteoi_irq;
> >>+	} else {
> >>+		d->chip = &sunxi_pinctrl_edge_irq_chip;
> >>+		desc->handle_irq = handle_edge_irq;
> >
> >irq_set_chip_and_handler?
> 
> Does a lookup of the irqdata which we already have here, and
> that lookup takes a lock which is already held here.

Ah, yes.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/e3d07fb2/attachment.sig>
