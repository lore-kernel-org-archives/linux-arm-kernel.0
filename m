From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 10 Apr 2013 21:51:11 +0200
Subject: [PATCH] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201304101545.49264.heiko@sntech.de>
References: <201304100135.12471.heiko@sntech.de>
 <136562781.D2dqZAGJoQ@flatron> <201304101545.49264.heiko@sntech.de>
Message-ID: <124150661.H9fd6KrsIX@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of April 2013 15:45:48 Heiko St?bner wrote:
> Am Mittwoch, 10. April 2013, 14:31:29 schrieb Tomasz Figa:
> > On Wednesday 10 of April 2013 14:20:22 Heiko St?bner wrote:
> > > Hi Tomasz,
> > > 
> > > thanks for your comments, more inline.
> > > 
> > > Am Mittwoch, 10. April 2013, 12:36:39 schrieb Tomasz Figa:
> > > > Hi Heiko,
> > > > 
> > > > Basically looks good to me, but please see my inline comments
> > > > about
> > > > handling of EINT0-3.
> > > > 
> > > > On Wednesday 10 of April 2013 01:35:12 Heiko St?bner wrote:
> > > > > The s3c24xx pins follow a similar pattern as the other Samsung
> > > > > SoCs
> > > > > and
> > > > > can therefore reuse the already introduced infrastructure.
> > > 
> > > [...]
> > > 
> > > > > +struct s3c24xx_eint_data {
> > > > > +	struct samsung_pinctrl_drv_data *drvdata;
> > > > > +	struct irq_domain *domains[NUM_EINT];
> > > > > +	int parents[NUM_EINT_IRQ];
> > > > > +};
> > > > > +
> > > > > +struct s3c24xx_eint_domain_data {
> > > > > +	struct samsung_pin_bank *bank;
> > > > > +	struct s3c24xx_eint_data *eint_data;
> > > > 
> > > > What about:
> > > > 
> > > > +	bool eint0_3_parent_only;
> > > > 
> > > > (or whatever name would be more appropriate), which would store
> > > > the
> > > > information about the s3c24xx-specific quirk in 24xx-specific data
> > > > structure, without the need to add another field to the generic
> > > > samsung_pinctrl_drv_data structure?
> > > > 
> > > > See my further comments on how I would see using this field in
> > > > interrupt handling code.
> > > 
> > > ok, sounds good, especially gathering the type from the wakeup-int
> > > property
> > > 
> > > > > +};
> > > 
> > > [...]
> > > 
> > > > Now I would split the following 3 functions into two sets of 3
> > > > functions, one set for s3c2412 and other for remaining SoCs and
> > > > make
> > > > separate EINT0-3 IRQ chips for both cases.
> > > 
> > > Not doing the decision every time, might bring some very slight
> > > speed
> > > improvements, so is probably the right way to go.
> > > 
> > > > > +
> > > > > +static void s3c24xx_eint0_3_ack(struct irq_data *data)
> > > > > +{
> > > > > +	struct samsung_pin_bank *bank =
> > > > > irq_data_get_irq_chip_data(data);
> > > > > +	struct samsung_pinctrl_drv_data *d = bank->drvdata;
> > > > > +	struct s3c24xx_eint_domain_data *ddata = bank->irq_domain-
> > > > >
> > > > >host_data;
> > > > >
> > > > > +	struct s3c24xx_eint_data *eint_data = ddata->eint_data;
> > > > > +	int parent_irq = eint_data->parents[data->hwirq];
> > > > > +	struct irq_chip *parent_chip = irq_get_chip(parent_irq);
> > > > > +
> > > > > +	if (d->ctrl->type == S3C2412) {
> > > > > +		unsigned long bitval = 1UL << data->hwirq;
> > > > > +		writel(bitval, d->virt_base + EINTPEND_REG);
> > > > > +	}
> > > > > +
> > > > > +	if (parent_chip->irq_ack)
> > > > > +		parent_chip-
>irq_ack(irq_get_irq_data(parent_irq));
> > > > 
> > > > Btw. Is this parent level acking really needed here?
> > > 
> > > Depends. If using chained_irq_* of course not, but if the
> > > irq-handler
> > > should stay in charge of when to ack it might be better this way.
> > > 
> > > Generic s3c24xx SoCs need acking in the main controller only, while
> > > s3c2412 needs acking in both the main controller and eintpend.
> > > 
> > > > > +}
> > > 
> > > [...]
> > > 
> > > > > +static void s3c24xx_demux_eint0_3(unsigned int irq, struct
> > > > > irq_desc
> > > > > *desc) +{
> > > > > +	struct irq_data *data = irq_desc_get_irq_data(desc);
> > > > > +	struct s3c24xx_eint_data *eint_data =
> > > > > irq_get_handler_data(irq);
> > > > > +	unsigned int virq;
> > > > > +
> > > > 
> > > > Instead of acking the interrupt at parent chip from ack callback
> > > > of
> > > > EINT0_3 chip, I would rather use chained_irq_enter() here...
> > > > 
> > > > > +	/* the first 4 eints have a simple 1 to 1 mapping */
> > > > > +	virq = irq_linear_revmap(eint_data->domains[data->hwirq],
> > > > > data->hwirq); +	/* Something must be really wrong if an 
unmapped
> > > > 
> > > > EINT
> > > > 
> > > > > +	 * was unmasked...
> > > > > +	 */
> > > > > +	BUG_ON(!virq);
> > > > > +
> > > > > +	generic_handle_irq(virq);
> > > > 
> > > > ...and chained_irq_exit() here.
> > > 
> > > If I understand it correctly, the way chained_irq_* works it would
> > > limit the eints to a level style handling. With the way it's
> > > currently the whole determination of when to ack,mask and unmask is
> > > completely for the real handler (edge or level) to decide, as the
> > > original interrupt gets completely forwarded into the irq-domain
> > > without further
> > > constraints.
> > > 
> > > So, after the change on regular s3c24xx SoCs when the real irq
> > > handler
> > > wants to ack the irq, it would be a no-op, as it would already have
> > > been acked by chained_irq_enter.
> > > 
> > > Masking might be even more interesting. Currently control is
> > > transfered
> > > completely to the pinctrl irq-domain, which then controls the
> > > masking of the interrupt thru the parent-calls - on regular s3c24xx
> > > the masking of these is also only done in the main controller.
> > > 
> > > When using chained_irq_* it also wants to mask the interrupt which
> > > might conflict with regular enable_irq/disable_irq calls being done
> > > for example in driver code.
> > > 
> > > 
> > > So in short I agree with the earlier split of the irqchip, but would
> > > keep the irq operations themself centralized in the pinctrl driver,
> > > instead of using chained_irq_* functions.
> > 
> > Right, my solution wouldn't work properly in case of regular s3c24xx
> > and edge triggered interrupts.
> > 
> > However I'm still wondering if it's OK to manually call parent chip
> > operations in case of s3c2416. This would imply the same operation
> > calling order as imposed by flow handler of the chained EINT (which
> > can be handle_edge_irq), while the parent chip is probably level
> > triggered, isn't it?
> 
> I think imposing the same calling order is the right way to go :-) .
> 
> The eints can be set hardware-wise to either level or edge triggered,
> but their flow handler is currently hard set to handle_edge_irq. I
> remember seeing a patch from the Openmoko guys somewhere indicating
> that this does not work at all with level irqs.

Sounds like something broken to me. Level-triggered interrupts need 
different handling than edge-triggered handling and so different flow 
handlers exist for them.

To make my doubts clear, this is how I'm seeing the hardware on 2412:

  edge or level triggered     level triggered
       |   ___________________   |   ________________
       |  |                   |  |  |                |
EINT0 --> | EINT0   EINT0PEND | --> | IRQ0   ARM_INT | --> to the ARM core
       |  |                   |  |  |                |
EINT1 --> | EINT1   EINT1PEND | --> | IRQ1           |
       |  |                   |  |  |                |
EINT2 --> | EINT2   EINT2PEND | --> | IRQ2           |
       |  |                   |  |  |                |
EINT3 --> | EINT3   EINT3PEND | --> | IRQ3           |
          |___________________|     |________________|

             GPIO controller       Interrupt controller

Now EINT0-EINT3 signals of the GPIO controller are directly driven with 
external interrupt signals, either edge or level triggered, but the 
interrupt status is latched in EINT0PEND-EINT3PEND bits inside the GPIO 
controller and state of those bits is exported through EINT0PEND-EINT3PEND 
signals to the interrupt controller's IRQ0-IRQ3 signals, which are now 
level-triggered, since the interrupt is active only when EINTxPEND bit is 
high.

Now, if my vision is wrong, and the hardware has simply EINT0-EINT3 pins 
routed to IRQ0-IRQ3 signals of the interrupt controller, then what you're 
saying is completely right. In this case just ignore my moaning. ;)

Best regards,
Tomasz

> Only the main interrupts of the real demuxed eints (3_to_7 and 8_to...)
> are always level triggered, and therefore already use chained_irq...
> 
> In the current pinctrl driver, the parent eints do not have a flow
> handler of their own (as the chained handler replaces it). So all flow
> handling is done by the flowhandler of the irq in the pinctrl domain.
> 
> handle_IRQ(main_eint)
> -> demux_eint0_3
> -> generic_handle_irq(pinctrl_eint)
> -> handle_edge_irq (or handle_level_irq)
> -> call ack, mask or unmask of the pinctrl eint
> -> call ack, mask or unmask of the underlying main eint
> 
> 
> Heiko
