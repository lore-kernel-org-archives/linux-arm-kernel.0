From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2017 18:37:27 +0000
Subject: [PATCH 2/4] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
In-Reply-To: <1484997072-19276-2-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <1484997072-19276-2-git-send-email-bharatku@xilinx.com>
Message-ID: <1ac7a4bb-26b6-7a4b-9bf1-030d87e6f8e6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> - Few wifi end points which only support legacy interrupts,
> performs hardware reset functionalities after disabling interrupts
> by invoking disable_irq and then re-enable using enable_irq, they
> enable hardware interrupts first and then virtual irq line later.
> - The legacy irq line goes low only after DEASSERT_INTx is
> received.As the legacy irq line is high immediately after hardware
> interrupts are enabled but virq of EP is still in disabled state
> and EP handler is never executed resulting no DEASSERT_INTx.If dummy
> irq chip is used, interrutps are not masked and system is
> hanging with CPU stall.
> - Adding irq chip functions instead of dummy irq chip for legacy
> interrupts.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |   36 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index c8b5a33..e1809f9 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -396,10 +396,44 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void nwl_mask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct nwl_pcie *pcie;
> +	unsigned int mask = 0;

No need for this initialization. And if the function you're passing that
to takes a u32, why isn't that a u32 too?

> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = 1 << (data->hwirq - 1);
> +	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL & (~mask)),
> +			  MSGF_LEG_MASK);

Erm. This looks completely bogus. Let's say I mask INTA:

	mask = 1 << 0;
	nwl_bridge_writel(pcie, INTD|INTC|INTB, ...);

Now, in a separate context, I decide to mask INTB:

	mask = 1 << 1;
	nwl_bridge_writel(pcie, INTD|INTC|INTA, ...);

unmasking INTA in the process. Probably not what you intended.

> +
> +}
> +
> +static void nwl_unmask_leg_irq(struct irq_data *data)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +	struct nwl_pcie *pcie;
> +	unsigned int mask = 0;
> +
> +	pcie = irq_desc_get_chip_data(desc);
> +	mask = 1 << (data->hwirq - 1);
> +	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL | mask),
> +			  MSGF_LEG_MASK);

Same issue.

> +
> +}
> +
> +static struct irq_chip nwl_leg_irq_chip = {
> +	.name = "nwl_pcie:legacy",
> +	.irq_enable = nwl_unmask_leg_irq,
> +	.irq_disable = nwl_mask_leg_irq,
> +	.irq_mask = nwl_mask_leg_irq,
> +	.irq_unmask = nwl_unmask_leg_irq,
> +};
> +
>  static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
>  			  irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
>  
>  	return 0;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
