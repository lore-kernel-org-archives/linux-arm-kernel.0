From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Jul 2011 16:28:18 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <1310549358-13330-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1310549358-13330-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1310549358-13330-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20110713162818.76fd9f5e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Wed, 13 Jul 2011 11:29:17 +0200,
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :

> Several USB power switches (AIC1526 or MIC2026) have a digital output
> that is used to notify that an overcurrent situation is taking
> place. This digital outputs are typically connected to GPIO inputs of
> the processor and can be used to be notified of those overcurrent
> situations.
> 
> Therefore, we add a new overcurrent_pin[] array in the at91_usbh_data
> structure so that boards can tell the AT91 OHCI driver which pins are
> used for the overcurrent notification, and an overcurrent_supported
> boolean to tell the driver whether overcurrent is supported or not.
> 
> The code has been largely borrowed from ohci-da8xx.c and
> ohci-s3c2410.c.

Now, I have a question about the behavior I observe with this code in
place. In order to easily trigger the over-current situation, I have
told in my board code that a button is the GPIO for the overcurrent_pin.

When I push the button, I enter the over-current situation, when I
release the button, I exit the over-current situation.

With the code above in place, when I push the button, the power is shut
off on the corresponding USB port and the device goes away. But
immediately after that, the power is switched on at the USB port by the
USB core, and the device is detected again. Is this normal behaviour ?
I would have expected the USB core to wait for the over-current
situation to disappear (i.e from me releasing the button). Maybe I am
misunderstanding how over-current management works ?

Apparently, the behaviour I observe is implemented by the following
piece of code in drivers/usb/core/hub.c :

                        if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
                                u16 status = 0;
                                u16 unused;

                                dev_dbg(hub_dev, "over-current change on port "
                                        "%d\n", i);
                                clear_port_feature(hdev, i,
                                        USB_PORT_FEAT_C_OVER_CURRENT);
                                msleep(100);    /* Cool down */
                                hub_power_on(hub, true);
                                hub_port_status(hub, i, &status, &unused);
                                if (status & USB_PORT_STAT_OVERCURRENT)
                                        dev_err(hub_dev, "over-current "
                                                "condition on port %d\n", i);
                        }

So I don't see where it would wait for the over-current situation to be
cleared. However, the USB 2.0 specification says, in section 11.12.5 :

"""
Host recovery actions for an over-current event should include the
following:
1. Host gets change notification from hub with over-current
   event.
2. Host extracts appropriate hub or port change information
   (depending on the information in the change bitmap).
3. Host waits for over-current status bit to be cleared to 0.
4. Host cycles power on to all of the necessary ports (e.g., issues a
   SetPortFeature(PORT_POWER) request for each port).
5. Host re-enumerates all affected ports
"""

So, according to step 3), I would have expected the USB core to wait
for the over-currrent status to be cleared, that is, wait until I
release the button.

Below is the log of what happens between the moment I press the button
(message "overcurrent situation notified" from the GPIO interrupt
handler) and the moment I release the button (message "overcurrent
situation exited" from the GPIO interrupt handler).

[   41.750000] at91_ohci at91_ohci: overcurrent situation notified
[   41.790000] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0006
[   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
[   41.790000] at91_ohci at91_ohci: GetPortStatus(1)
[   41.790000] hub 1-0:1.0: over-current change on port 1
[   41.790000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0013,0x0001,c7861e70,0000)
[   41.790000] at91_ohci at91_ohci: ClearPortFeature: C_OVER_CURRENT
[   41.790000] at91_ohci at91_ohci: CTRL: TypeReq=0x2301 val=0x13 idx=0x1 len=0 ==> -22
[   41.900000] hub 1-0:1.0: enabling power on all ports
[   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0001,c7861e58,0000)
[   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
[   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x1 len=0 ==> -22
[   41.900000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0008,0x0002,c7861e58,0000)
[   41.900000] at91_ohci at91_ohci: SetPortFeat: POWER
[   41.900000] at91_ohci at91_ohci: CTRL: TypeReq=0x2303 val=0x8 idx=0x2 len=0 ==> -22
[   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0001,c7861e48,0004)
[   42.010000] at91_ohci at91_ohci: GetPortStatus(1)
[   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.010000] at91_ohci at91_ohci: GetStatus roothub.portstatus [1] = 0x00030301 PESC CSC LSDA PPS CCS
[   42.010000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0010,0x0002,c7861e70,0000)
[   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0011,0x0002,c7861e70,0000)
[   42.010000] hub 1-0:1.0: port 2, status 0301, change 0003, 1.5 Mb/s
[   42.010000] usb 1-2: USB disconnect, device number 2
[   42.010000] usb 1-2: unregistering device
[   42.010000] usb 1-2: unregistering interface 1-2:1.0
[   42.010000] usb 1-2: usb_disable_device nuking all URBs
[   42.010000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.010000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.050000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.050000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.090000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.090000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.130000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.130000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.170000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.170000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.170000] hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
[   42.170000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0004,0x0002,c7861de0,0000)
[   42.290000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861db8,0004)
[   42.290000] at91_ohci at91_ohci: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
[   42.290000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.350000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0014,0x0002,c7861de0,0000)
[   42.350000] usb 1-2: new low speed USB device number 3 using at91_ohci
[   42.350000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2303,0x0004,0x0002,c7861de0,0000)
[   42.470000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861db8,0004)
[   42.470000] at91_ohci at91_ohci: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
[   42.470000] at91_ohci at91_ohci: GetPortStatus(2)
[   42.530000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0x2301,0x0014,0x0002,c7861de0,0000)
[   42.560000] usb 1-2: skipped 1 descriptor after interface
[   42.560000] usb 1-2: default language 0x0409
[   42.570000] usb 1-2: udev 3, busnum 1, minor = 2
[   42.570000] usb 1-2: New USB device found, idVendor=0a81, idProduct=0701
[   42.570000] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   42.580000] usb 1-2: Product: USB Missile Launcher v1.0
[   42.590000] usb 1-2: Manufacturer: Dream Link
[   42.590000] usb 1-2: usb_probe_device
[   42.590000] usb 1-2: configuration #1 chosen from 1 choice
[   42.590000] usb 1-2: adding 1-2:1.0 (config #1, interface 0)
[   42.600000] usbhid 1-2:1.0: usb_probe_interface
[   42.600000] usbhid 1-2:1.0: usb_probe_interface - got id
[   42.610000] generic-usb 0003:0A81:0701.0002: claimed by neither input, hiddev nor hidraw
[   42.610000] /home/thomas/projets/linux-2.6/drivers/usb/core/inode.c: creating file '003'
[   42.610000] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
[   42.610000] at91_ohci at91_ohci: ohci_at91_hub_control(c79ccc00,0xa300,0x0000,0x0002,c7861e48,0004)
[   42.610000] at91_ohci at91_ohci: GetPortStatus(2)
[   43.850000] at91_ohci at91_ohci: overcurrent situation exited

Could you enlighten me on how this over-current mechanism is supposed
to work ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
