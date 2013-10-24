From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 24 Oct 2013 13:50:29 +0800
Subject: [Patch v2 08/10] usb: chipidea: host: add quirk for ehci operation
In-Reply-To: <20131024075103.2e2702ec@ipc1.ka-ro>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
 <1382423019-26184-9-git-send-email-peter.chen@freescale.com>
 <20131024075103.2e2702ec@ipc1.ka-ro>
Message-ID: <20131024055028.GA2760@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 07:51:03AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Peter Chen wrote:
> > For chipidea controller, it does not follow ehci spec strictly.
> > Taking resume signal as an example, it will stop resume signal about
> > 20-21ms later automatically, but standard ehci spec says, the resume
> > signal is controlled by software (clear portsc.PORT_RESUME).
> > 
> > This operation causes some remote wakeup problems for high speed
> > devices due to host controller does not send SOF in time since
> > software can't guarantee set run/stop bit in time (run/stop bit
> > was cleared at the ehci suspend routine).
> > 
> > When software sets run/stop bit, it needs 1 SoF time to make it effect.
> > If we close the PHY clock just after setting run/stop bit, it does
> > not be set in practice, so a software delay is needed.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/host.c |   51 +++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 51 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index 59e6020..283b385 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -33,6 +33,53 @@
> >  #include "host.h"
> >  
> >  static struct hc_driver __read_mostly ci_ehci_hc_driver;
> > +static int (*orig_bus_suspend)(struct usb_hcd *hcd);
> > +
> > +static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
> > +{
> > +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +	int port;
> > +	u32 tmp;
> > +
> > +	int ret = orig_bus_suspend(hcd);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	port = HCS_N_PORTS(ehci->hcs_params);
> > +	while (port--) {
> > +		u32 __iomem *reg = &ehci->regs->port_status[port];
> > +		u32 portsc = ehci_readl(ehci, reg);
> > +
> > +		if (portsc & PORT_CONNECT) {
> > +			/*
> > +			 * For chipidea, the resume signal will be ended
> > +			 * automatically, so for remote wakeup case, the
> > +			 * usbcmd.rs may not be set before the resume has
> > +			 * ended if other resume path consumes too much
> > +			 * time (~23ms-24ms), in that case, the SOF will not
> > +			 * send out within 3ms after resume ends, then the
> > +			 * device will enter suspend again.
> > +			 */
> > +			if (hcd->self.root_hub->do_remote_wakeup) {
> > +				ehci_dbg(ehci,
> > +					"Remote wakeup is enabled, "
> > +					"and device is on the port\n");
> >
> Please don't line wrap message texts, since it makes it harder to grep
> the kernel source for messages found in a logfile.
> 
> 

Thanks, will change.

-- 

Best Regards,
Peter Chen
