From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2017 18:23:17 +0000
Subject: [PATCH 1/4] PCI: Xilinx NWL: Fix, do not check for legacy status
 in while loop
In-Reply-To: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
Message-ID: <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> - The legacy status register value for particular INTx becomes low
> only after DEASSERT_INTx is received.
> - Few End Points take time for sending DEASSERT_INTx, checking
> legacy status register in while loop causes invoking of EP
> handler continuosly until DEASSERT_INTx is received.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 43eaa4a..c8b5a33 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
>  
>  	chained_irq_enter(chip, desc);
>  	pcie = irq_desc_get_handler_data(desc);
> +	status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> +				  MSGF_LEG_SR_MASKALL;
>  
> -	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> -				MSGF_LEG_SR_MASKALL) != 0) {
> +	if (status != 0) {
>  		for_each_set_bit(bit, &status, INTX_NUM) {
>  			virq = irq_find_mapping(pcie->legacy_irq_domain,
>  						bit + 1);
> 

But even if you only handle the interrupt once, it is still asserted,
right? You exit the low-level exception handler, only to take the
interrupt immediately again. So what is the gain here?

As an aside, please add a cover letter to your patch series. It is
immensely useful as a summary of what is being done, as well as an
anchor for the patches themselves.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
