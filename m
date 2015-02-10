From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 10 Feb 2015 17:22:41 +0800
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
In-Reply-To: <20150210084021.GM10842@pengutronix.de>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
 <20150210084021.GM10842@pengutronix.de>
Message-ID: <1423560161.24705.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-02-10 at 09:40 +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Jan 27, 2015 at 02:15:26PM +0800, Chaotian Jing wrote:
> > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > 
> > MTK EINT does not support generating interrupt on both edges.
> > Emulate this by changing edge polarity while enable irq,
> > set types and interrupt handling. This follows an example of
> > drivers/gpio/gpio-mxc.c.
<...>
> > +static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
> > +{
> > +	int start_level, curr_level;
> > +	unsigned int reg_offset;
> > +	const struct mtk_eint_offsets *eint_offsets = &(pctl->devdata->eint_offsets);
> > +	u32 mask = 1 << (hwirq & 0x1f);
> > +	u32 port = (hwirq >> 5) & eint_offsets->port_mask;
> > +	void __iomem *reg = pctl->eint_reg_base + (port << 2);
> > +	const struct mtk_desc_pin *pin;
> > +
> > +	pin = mtk_find_pin_by_eint_num(pctl, hwirq);
> > +	curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
> > +	do {
> > +		start_level = curr_level;
> > +		if (start_level)
> > +			reg_offset = eint_offsets->pol_clr;
> > +		else
> > +			reg_offset = eint_offsets->pol_set;
> > +		writel(mask, reg + reg_offset);
> > +
> > +		curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
> > +	} while (start_level != curr_level);
> > +
> > +	return start_level;
> > +}
> > +
> >  static void mtk_eint_mask(struct irq_data *d)
> >  {
> >  	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> > @@ -814,6 +840,9 @@ static void mtk_eint_unmask(struct irq_data *d)
> >  			eint_offsets->mask_clr);
> >  
> >  	writel(mask, reg);
> > +
> > +	if (pctl->eint_dual_edges[d->hwirq])
> > +		mtk_eint_flip_edge(pctl, d->hwirq);
> >  }
> From looking at the code it seems to me that there is a bug. Consider
> the following to happen:
> 
> 	pin changes level, say high to low, triggers irq
> 
> 	irq is masked by writel(mask, reg) in mtk_eint_mask
> 
> 	mtk_eint_flip_edge gets curr_level = low
> 
> 	pin goes up
> 
> 	writel(mask, reg + eint_offsets->pol_set);
> 
> 	oh, pin is high, so: writel(mask, reg + eint_offsets->pol_clr
> 
> So now you trigger the irq the next time when the pin goes down again.
> But that means to missed to trigger on the "pin goes up" in the above
> list, right?

Hi Uwe,

Yes, this could be a problem when irq happen. So I fix/workaround this
in mtk_eint_irq_handler() using soft-irq. When this bit is set, eint
will trigger the same interrupt again.
 
+			if (dual_edges) {
+				curr_level = mtk_eint_flip_edge(pctl, index);
+
+				/* If level changed, we might lost one edge
+				   interrupt, raised it through soft-irq */
+				if (start_level != curr_level)
+					writel(BIT(offset), reg -
+						eint_offsets->stat +
+						eint_offsets->soft_set);
+			}

Joe.C
