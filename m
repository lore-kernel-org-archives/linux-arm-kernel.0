From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Mar 2013 11:50:54 +0200
Subject: [PATCH v11 4/9] usb: chipidea: udc: add pullup/pulldown dp at
 hw_device_state
In-Reply-To: <20130307023612.GC20470@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-5-git-send-email-peter.chen@freescale.com>
 <20130306112633.GS28587@arwen.pp.htv.fi>
 <20130307023612.GC20470@nchen-desktop>
Message-ID: <20130307095054.GK9171@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 07, 2013 at 10:36:13AM +0800, Peter Chen wrote:
> > > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > > index e82dae4..70f9f2d 100644
> > > --- a/drivers/usb/chipidea/udc.c
> > > +++ b/drivers/usb/chipidea/udc.c
> > > @@ -91,8 +91,10 @@ static int hw_device_state(struct ci13xxx *ci, u32 dma)
> > >  		/* interrupt, error, port change, reset, sleep/suspend */
> > >  		hw_write(ci, OP_USBINTR, ~0,
> > >  			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
> > > +		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
> > >  	} else {
> > >  		hw_write(ci, OP_USBINTR, ~0, 0);
> > > +		hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
> > 
> > this patch doesn't make sense to me. What will happen is that you will
> > be enabling pullups when vbus_session() gets called and this might not
> > be what gadget driver wants.
> > 
> > You don't want to fiddle with that yourself since I'm changing the
> > framework so that gadget driver will always request pullups to be
> > enabled.
> 
> Hi Felipe,
> 
> Do you think pullup dp without vbus is a valid operation?

why not ? What I want to connect pullups first and only then issue SRP ?

> Current udc core code makes that possible.

so ?

> But I think current your udc core code (add pullup after loading
> gadget) make benefit for udc driver who has not vbus operation.
> 
> For chipidea driver:
> 
> - If vbus is there before load gadget module, the pullup dp is done by
> udc core code.
> - If vbus is not there before load gadget module, the pullup will be
> done when the vbus is there.

This isn't legal. If you want to make sure vbus is alive before
connecting pullups, then do it generically. Modify udc-core.c to make
those checks for you. Bypassing the framework is dangerous because
whenever I wanna change something, I might miss your private details and
end up causing regressions.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/89379368/attachment.sig>
