From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 31 Jan 2017 09:34:43 +0000
Subject: [PATCH v3] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
In-Reply-To: <868tpr8u3r.fsf@arm.com>
References: <1485853152-31819-1-git-send-email-bharatku@xilinx.com>
 <868tpr8u3r.fsf@arm.com>
Message-ID: <8520D5D51A55D047800579B094147198263DDD4D@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 > On Tue, Jan 31 2017 at 08:59:12 AM, Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com> wrote:
> > - Adding mutex lock for protecting legacy mask register
> > - Few wifi end points which only support legacy interrupts, performs
> > hardware reset functionalities after disabling interrupts by invoking
> > disable_irq and then re-enable using enable_irq, they enable hardware
> > interrupts first and then virtual irq line later.
> > - The legacy irq line goes low only after DEASSERT_INTx is received.As
> > the legacy irq line is high immediately after hardware interrupts are
> > enabled but virq of EP is still in disabled state and EP handler is
> > never executed resulting no DEASSERT_INTx.If dummy irq chip is used,
> > interrutps are not masked and system is hanging with CPU stall.
> > - Adding irq chip functions instead of dummy irq chip for legacy
> > interrupts.
> > - Legacy interrupts are level sensitive, so using handle_level_irq is
> > more appropriate as it is masks interrupts until End point handles
> > interrupts and unmasks interrutps after End point handler is executed.
> > - Legacy interrupts are level triggered, virtual irq line of End Point
> > shows as edge in /proc/interrupts.
> > - Setting irq flags of virtual irq line of EP to level triggered at
> > the time of mapping.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c |   43
> +++++++++++++++++++++++++++++++++++-
> >  1 files changed, 42 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 43eaa4a..76dd094 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -184,6 +184,7 @@ struct nwl_pcie {
> >  	u8 root_busno;
> >  	struct nwl_msi msi;
> >  	struct irq_domain *legacy_irq_domain;
> > +	struct mutex leg_mask_lock;
> >  };
> >
> >  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off) @@
> > -395,11 +396,50 @@ static void nwl_pcie_msi_handler_low(struct irq_desc
> *desc)
> >  	chained_irq_exit(chip, desc);
> >  }
> >
> > +static void nwl_mask_leg_irq(struct irq_data *data) {
> > +	struct irq_desc *desc = irq_to_desc(data->irq);
> > +	struct nwl_pcie *pcie;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	pcie = irq_desc_get_chip_data(desc);
> > +	mask = 1 << (data->hwirq - 1);
> > +	mutex_lock(&pcie->leg_mask_lock);
> > +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> > +	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
> > +	mutex_unlock(&pcie->leg_mask_lock);
> 
> Have you looked at which context this is called in? In a number of cases, the
> mask/unmask methods are called whilst you're in an interrupt context. If you
> sleep there (which is what happens with a contended mutex), you die horribly.
> 
> Given these constraints, you should use raw_spin_lock_irqsave and co, since this
> can be called from both interrupt and non-interrupt contexts.
> 
I have seen very few wifi drivers calling these in MAC flow, raw_spin_lock_irqsave 
looks more safe, will do it.

Thanks & Regards,
Bharat
