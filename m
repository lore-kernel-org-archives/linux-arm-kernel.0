From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 13 Jul 2011 13:17:12 -0400 (EDT)
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <20110713184340.2ce39d2a@skate>
Message-ID: <Pine.LNX.4.44L0.1107131304550.2156-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2011, Thomas Petazzoni wrote:

> Le Wed, 13 Jul 2011 11:54:15 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> a ?crit :
> 
> > > So, according to step 3), I would have expected the USB core to wait
> > > for the over-currrent status to be cleared, that is, wait until I
> > > release the button.
> > 
> > If there is no power to the port, the attached device can't draw any
> > current.  Right?  Therefore the port's over-current status isn't
> > meaningful until the power is restored.
> 
> Right, but as you highlighted below, as soon as you power on the port
> again, if the same device is still plugged into the port, then you might
> end up in the same over-current situation, and this will loop forever.

Potentially yes, that could happen.  Nobody has ever complained about 
seeing it, though.

In general our handling of this situation probably is not adequate.  
However it has never received proper testing.  You can review the git
history of the hub.c file; there have been some recent changes to this
code.

> > > Below is the log of what happens between the moment I press the button
> > > (message "overcurrent situation notified" from the GPIO interrupt
> > > handler) and the moment I release the button (message "overcurrent
> > > situation exited" from the GPIO interrupt handler).
> > > 
> > > [   41.750000] at91_ohci at91_ohci: overcurrent situation notified
> > > [   41.790000] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0006
> > > [   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
> > > [   41.790000] at91_ohci at91_ohci: GetPortStatus(1)
> > > [   41.790000] hub 1-0:1.0: over-current change on port 1
> > > [   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0013,0x0001,c7861e70,0000)
> > > [   41.790000] at91_ohci at91_ohci: ClearPortFeature: C_OVER_CURRENT
> > > [   41.790000] at91_ohci at91_ohci: CTRL: TypeReq=0x2301 val=0x13 idx=0x1 len=0 ==> -22
> > > [   41.900000] hub 1-0:1.0: enabling power on all ports
> > > [   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0001,c7861e58,0000)
> > > [   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
> > > [   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x1 len=0 ==> -22
> > > [   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0002,c7861e58,0000)
> > > [   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
> > > [   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x2 len=0 ==> -22
> > > [   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
> > > [   42.010000] at91_ohci at91_ohci: GetPortStatus(1)
> > > [   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
> > > [   42.010000] at91_ohci at91_ohci: GetStatus roothub.portstatus [1] = 0x00030301 PESC CSC LSDA PPS CCS
> > 
> > At this point the "over-current condition on port 1" error message
> > should have appeared, and the power to port 1 should have been turned
> > off again by the hardware.
> 
> I'm not sure to follow you here. If the message did not appear, it
> indicates that the USB_PORT_STAT_OVERCURRENT flag wasn't set, for some
> reason.

Right.  Why wasn't the flag set?  Was it because the port power had
already been turned back off?  That's not what the log indicates.

> Regarding the power being turned off, it's already done by the GPIO
> interrupt handler that notifies of the beginning of an over-current
> situation :
> 
> static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
> {
> [...]
>         val = gpio_get_value(gpio);
> 
>         /* When notified of an over-current situation, disable power
>            on the corresponding port, and mark this port in
>            over-current. */
>         if (! val) {
>                 ohci_at91_usb_set_power(pdata, port, 0);
>                 pdata->overcurrent_status[port]  = 1;
>                 pdata->overcurrent_changed[port] = 1;
>         }
> [...]
> 
> Isn't this correct ?

I have no idea; I don't know how the AT91 works.  When does the 
overcurrent_status value get cleared?  Under what conditions does that 
IRQ fire?

> > > Could you enlighten me on how this over-current mechanism is supposed
> > > to work ?
> > 
> > We don't have any good way of waiting for the over-current status to
> > clear, because the hub driver is single-threaded.  It wouldn't be able
> > to respond to any other USB events while waiting.
> 
> Ok. I guess it would be possible to regularly poll for the over-current
> flag and see whether things are improving (and between the polls,
> handle all other USB events). But as you said above, as soon as you
> power off the port, the over-current situation should have disappeared.
> What worries me is that the over-current situation will likely take
> place again as soon as you power on the port again.
> 
> In the end, is the behavior that I see the normal behavior of
> over-current management as supported currently by the kernel?

More or less, yes.  We are always willing to consider suggestions for
improvements, especially when accompanied by patches.

Alan Stern
