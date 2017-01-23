From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2017 18:38:26 +0000
Subject: [PATCH 3/4] PCI: Xilinx NWL: Modifying flow handler for legacy
 interrupts
In-Reply-To: <1484997072-19276-3-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <1484997072-19276-3-git-send-email-bharatku@xilinx.com>
Message-ID: <bab088a5-ed6d-1d9d-b38f-0a271c2bc766@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> Legacy interrupts are level sensitive, so using handle_level_irq
> is more approprate as it is masks interrupts until End point handles
> interrupts and unmasks interrutps after End point handler is executed.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index e1809f9..50f9c0d 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -433,7 +433,7 @@ static void nwl_unmask_leg_irq(struct irq_data *data)
>  static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
>  			  irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
>  
>  	return 0;
> 

Please merge this patch and the following one in patch #2. There is no
need for going through equally broken intermediate steps.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
