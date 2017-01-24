From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 24 Jan 2017 10:15:33 +0000
Subject: [PATCH 1/4] PCI: Xilinx NWL: Fix, do not check for legacy
 status in while loop
In-Reply-To: <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
Message-ID: <8520D5D51A55D047800579B094147198263CCF96@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> > - The legacy status register value for particular INTx becomes low
> > only after DEASSERT_INTx is received.
> > - Few End Points take time for sending DEASSERT_INTx, checking legacy
> > status register in while loop causes invoking of EP handler
> > continuosly until DEASSERT_INTx is received.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 43eaa4a..c8b5a33 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct irq_desc
> > *desc)
> >
> >  	chained_irq_enter(chip, desc);
> >  	pcie = irq_desc_get_handler_data(desc);
> > +	status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> > +				  MSGF_LEG_SR_MASKALL;
> >
> > -	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> > -				MSGF_LEG_SR_MASKALL) != 0) {
> > +	if (status != 0) {
> >  		for_each_set_bit(bit, &status, INTX_NUM) {
> >  			virq = irq_find_mapping(pcie->legacy_irq_domain,
> >  						bit + 1);
> >
> 
> But even if you only handle the interrupt once, it is still asserted, right? You exit
> the low-level exception handler, only to take the interrupt immediately again. So
> what is the gain here?
> 
Whenever masking of INTx happens (like as in my next patch[PATCH 2/4]), the irq line goes low,
but  status bit will be set until DEASSERT_INTx comes.
In this scenario if it is always in while loop, even though line went low it will not be seen 
until DEASSERT_INTx, unnecessarily invoking EP driver. so instead of while loop  
using if condition so that this change in line is noticed.
> As an aside, please add a cover letter to your patch series. It is immensely useful
> as a summary of what is being done, as well as an anchor for the patches
> themselves.
> 
Agreed, will do next time. 

Thanks & Regards,
Bharat
