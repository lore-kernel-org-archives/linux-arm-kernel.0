From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Jul 2011 18:43:40 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <Pine.LNX.4.44L0.1107131143360.2156-100000@iolanthe.rowland.org>
References: <20110713162818.76fd9f5e@skate>
	<Pine.LNX.4.44L0.1107131143360.2156-100000@iolanthe.rowland.org>
Message-ID: <20110713184340.2ce39d2a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 13 Jul 2011 11:54:15 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> a ?crit :

> > So, according to step 3), I would have expected the USB core to wait
> > for the over-currrent status to be cleared, that is, wait until I
> > release the button.
> 
> If there is no power to the port, the attached device can't draw any
> current.  Right?  Therefore the port's over-current status isn't
> meaningful until the power is restored.

Right, but as you highlighted below, as soon as you power on the port
again, if the same device is still plugged into the port, then you might
end up in the same over-current situation, and this will loop forever.

> > Below is the log of what happens between the moment I press the button
> > (message "overcurrent situation notified" from the GPIO interrupt
> > handler) and the moment I release the button (message "overcurrent
> > situation exited" from the GPIO interrupt handler).
> > 
> > [   41.750000] at91_ohci at91_ohci: overcurrent situation notified
> > [   41.790000] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0006
> > [   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
> > [   41.790000] at91_ohci at91_ohci: GetPortStatus(1)
> > [   41.790000] hub 1-0:1.0: over-current change on port 1
> > [   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0013,0x0001,c7861e70,0000)
> > [   41.790000] at91_ohci at91_ohci: ClearPortFeature: C_OVER_CURRENT
> > [   41.790000] at91_ohci at91_ohci: CTRL: TypeReq=0x2301 val=0x13 idx=0x1 len=0 ==> -22
> > [   41.900000] hub 1-0:1.0: enabling power on all ports
> > [   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0001,c7861e58,0000)
> > [   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
> > [   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x1 len=0 ==> -22
> > [   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0002,c7861e58,0000)
> > [   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
> > [   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x2 len=0 ==> -22
> > [   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
> > [   42.010000] at91_ohci at91_ohci: GetPortStatus(1)
> > [   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
> > [   42.010000] at91_ohci at91_ohci: GetStatus roothub.portstatus [1] = 0x00030301 PESC CSC LSDA PPS CCS
> 
> At this point the "over-current condition on port 1" error message
> should have appeared, and the power to port 1 should have been turned
> off again by the hardware.

I'm not sure to follow you here. If the message did not appear, it
indicates that the USB_PORT_STAT_OVERCURRENT flag wasn't set, for some
reason.

Regarding the power being turned off, it's already done by the GPIO
interrupt handler that notifies of the beginning of an over-current
situation :

static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
{
[...]
        val = gpio_get_value(gpio);

        /* When notified of an over-current situation, disable power
           on the corresponding port, and mark this port in
           over-current. */
        if (! val) {
                ohci_at91_usb_set_power(pdata, port, 0);
                pdata->overcurrent_status[port]  = 1;
                pdata->overcurrent_changed[port] = 1;
        }
[...]

Isn't this correct ?

> > Could you enlighten me on how this over-current mechanism is supposed
> > to work ?
> 
> We don't have any good way of waiting for the over-current status to
> clear, because the hub driver is single-threaded.  It wouldn't be able
> to respond to any other USB events while waiting.

Ok. I guess it would be possible to regularly poll for the over-current
flag and see whether things are improving (and between the polls,
handle all other USB events). But as you said above, as soon as you
power off the port, the over-current situation should have disappeared.
What worries me is that the over-current situation will likely take
place again as soon as you power on the port again.

In the end, is the behavior that I see the normal behavior of
over-current management as supported currently by the kernel?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
