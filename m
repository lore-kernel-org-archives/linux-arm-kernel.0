From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 3 Feb 2017 13:37:44 +0000
Subject: [PATCH v4] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
In-Reply-To: <69159364-f20a-c4e9-3e0b-187593d206fb@arm.com>
References: <1486120110-15205-1-git-send-email-bharatku@xilinx.com>
 <3c78506f-9bcb-0b43-4625-27229ee1f642@arm.com>
 <8520D5D51A55D047800579B094147198263E03C4@XAP-PVEXMBX02.xlnx.xilinx.com>
 <69159364-f20a-c4e9-3e0b-187593d206fb@arm.com>
Message-ID: <8520D5D51A55D047800579B094147198263E04CA@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 > On 03/02/17 12:16, Bharat Kumar Gogada wrote:
> >> On 03/02/17 11:08, Bharat Kumar Gogada wrote:
> >>> - Adding mutex lock for protecting legacy mask register
> >>> - Few wifi end points which only support legacy interrupts, performs
> >>> hardware reset functionalities after disabling interrupts by
> >>> invoking disable_irq and then re-enable using enable_irq, they
> >>> enable hardware interrupts first and then virtual irq line later.
> >>> - The legacy irq line goes low only after DEASSERT_INTx is
> >>> received.As the legacy irq line is high immediately after hardware
> >>> interrupts are enabled but virq of EP is still in disabled state and
> >>> EP handler is never executed resulting no DEASSERT_INTx.If dummy irq
> >>> chip is used, interrutps are not masked and system is hanging with CPU stall.
> >>> - Adding irq chip functions instead of dummy irq chip for legacy
> >>> interrupts.
> >>> - Legacy interrupts are level sensitive, so using handle_level_irq
> >>> is more appropriate as it is masks interrupts until End point
> >>> handles interrupts and unmasks interrutps after End point handler is
> executed.
> >>> - Legacy interrupts are level triggered, virtual irq line of End
> >>> Point shows as edge in /proc/interrupts.
> >>> - Setting irq flags of virtual irq line of EP to level triggered at
> >>> the time of mapping.
> >>>
> >>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> >>> ---
> >>>  drivers/pci/host/pcie-xilinx-nwl.c |   45
> >> +++++++++++++++++++++++++++++++++++-
> >>>  1 files changed, 44 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> index 43eaa4a..e4605f9 100644
> >>> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> @@ -184,6 +184,7 @@ struct nwl_pcie {
> >>>  	u8 root_busno;
> >>>  	struct nwl_msi msi;
> >>>  	struct irq_domain *legacy_irq_domain;
> >>> +	spinlock_t leg_mask_lock;
> >>>  };
> >>>
> >>>  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
> >>> @@
> >>> -395,11 +396,52 @@ static void nwl_pcie_msi_handler_low(struct
> >>> irq_desc
> >> *desc)
> >>>  	chained_irq_exit(chip, desc);
> >>>  }
> >>>
> >>> +static void nwl_mask_leg_irq(struct irq_data *data) {
> >>> +	struct irq_desc *desc = irq_to_desc(data->irq);
> >>> +	struct nwl_pcie *pcie;
> >>> +	unsigned long flags;
> >>> +	u32 mask;
> >>> +	u32 val;
> >>> +
> >>> +	pcie = irq_desc_get_chip_data(desc);
> >>> +	mask = 1 << (data->hwirq - 1);
> >>> +	spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> >>
> >> I've asked you to use a raw spinlock for a reason. If using RT, this
> >> gets turned into a sleeping lock...
> >>
> >  In include/linux/spinlock.h
> > #define spin_lock_irqsave(lock, flags)                          \
> > do {                                                            \
> >         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
> > } while (0)
> >
> > The above API invokes raw_spin_lock_irqsave know.
> > So is there any difference between raw_spin_lock_irqsave and
> spin_lock_irqsave ?
> 
> When using RT, yes. RT upgrades all spinlocks to sleeping locks. We're trying
> hard not to break RT, despite most of it not being merged yet. So your patch will
> work on mainline Linux, and will break horribly on Linux/RT.
> 
> So please, turn this into a raw spinlock as requested.

Thanks for the explanation, will do it. 

Regards,
Bharat
