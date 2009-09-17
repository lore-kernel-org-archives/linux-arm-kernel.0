From: brian@walsh.ws (Brian Walsh)
Date: Thu, 17 Sep 2009 17:02:59 -0400
Subject: ixp4xx dmabounce
Message-ID: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am running into an issue with high speed USB devices running on an ixp4xx
processor.  It looks like a dmabounce related problem.  I am running on an
ixp425 with 128 MB of RAM.  I am attaching a Sierra Wireless USB phone module
which attaches as a high speed USB ethernet device.  I am running the 2.6.31
kernel version.

I found a patch which seems to be trying to address the same issue I am
having but it left the USB device unable to attach.

http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-ixp4xx-disable-dmabounce-2.6.30-rc2

The relevant kernel messages with and without the patch applied are below.
The warning stack dump continues to stream out leaving the system basically
unresponsive until the data transfer completes.  Removing that stack dump
warning from dma-mapping.c the device is usable but operates with transfer
rates below that when it is attached to the full speed controller.

Any ideas or suggestions?

Thanks
Brian

---------------------------------------
Without dmabounce disable patch:
---------------------------------------

usb 6-3: new high speed USB device using ehci_hcd and address 2
usb 6-3: config 1 has an invalid interface number: 7 but max is 4
usb 6-3: config 1 has no interface number 2
usb 6-3: configuration #1 chosen from 1 choice
usb0: register 'sierra_net' at usb-0000:00:0f.2-3, Sierra Wireless
USB-Ethernet Modem, 56:1f:34:de:01:07
usbcore: registered new interface driver sierra_net
udev: renamed network interface usb0 to phone0
usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial Driver core
USB Serial support registered for Sierra USB modem
sierra 6-3:1.0: Sierra USB modem converter detected
usb 6-3: Sierra USB modem converter now attached to ttyUSB0
sierra 6-3:1.1: Sierra USB modem converter detected
usb 6-3: Sierra USB modem converter now attached to ttyUSB1
sierra 6-3:1.3: Sierra USB modem converter detected
usb 6-3: Sierra USB modem converter now attached to ttyUSB2
sierra 6-3:1.4: Sierra USB modem converter detected
usb 6-3: Sierra USB modem converter now attached to ttyUSB3
usbcore: registered new interface driver sierra
sierra: v.1.7.12:USB Driver for Sierra Wireless USB modems



------------[ cut here ]------------
WARNING: at arch/arm/mm/dma-mapping.c:369 dma_free_coherent+0x2c/0x218()
Modules linked in: af_packet ipv6 sierra usbserial pxa25x_udc
ixp4xx_eth ixp4xx_npe ixp4xx_qmgr libphy ehci_hcd sierra_net usbnetmii
ohci_hcd usb_storage usbcore sg scsi_mod
Backtrace:
[<c0021018>] (dump_backtrace+0x0/0x100) from [<c0021130>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:c0022c68 r5:c0216a00 r4:00000171
[<c0021118>] (dump_stack+0x0/0x1c) from [<c002ee28>]
(warn_slowpath_common+0x4c/0x64)
[<c002eddc>] (warn_slowpath_common+0x0/0x64) from [<c002ee58>]
(warn_slowpath_null+0x18/0x1c)
 r7:00002000 r6:00002000 r5:ffc43000 r4:c7812c58
[<c002ee40>] (warn_slowpath_null+0x0/0x1c) from [<c0022c68>]
(dma_free_coherent+0x2c/0x218)
[<c0022c3c>] (dma_free_coherent+0x0/0x218) from [<c0025e18>]
(dma_unmap_single+0xec/0x110)
[<c0025d2c>] (dma_unmap_single+0x0/0x110) from [<bf06cb64>]
(unmap_urb_for_dma+0xd8/0x10c [usbcore])
 r8:c68f7e00 r7:ffc0d120 r6:c7a04a00 r5:c7a04a00 r4:c68f7d80
[<bf06ca8c>] (unmap_urb_for_dma+0x0/0x10c [usbcore]) from [<bf06cc04>]
(usb_hcd_giveback_urb+0x6c/0xf4 [usbcore])
 r5:00000000 r4:c68f7d80
[<bf06cb98>] (usb_hcd_giveback_urb+0x0/0xf4 [usbcore]) from
[<bf0c700c>] (ehci_urb_done+0xa0/0xa4 [ehci_hcd])
 r6:c68f7d80 r5:00000000 r4:c7a04a00
[<bf0c6f6c>] (ehci_urb_done+0x0/0xa4 [ehci_hcd]) from [<bf0c88ac>]
(qh_completions+0xb8/0x534 [ehci_hcd])
 r6:c7a04ad8 r5:ffc0c300 r4:00000000
[<bf0c87f4>] (qh_completions+0x0/0x534 [ehci_hcd]) from [<bf0c9ee4>]
(ehci_work+0x12c/0xa84 [ehci_hcd])
[<bf0c9db8>] (ehci_work+0x0/0xa84 [ehci_hcd]) from [<bf0cb66c>]
(ehci_irq+0x32c/0x354 [ehci_hcd])
[<bf0cb340>] (ehci_irq+0x0/0x354 [ehci_hcd]) from [<bf06dca8>]
(usb_hcd_irq+0x4c/0x9c [usbcore])
[<bf06dc5c>] (usb_hcd_irq+0x0/0x9c [usbcore]) from [<c005d938>]
(handle_IRQ_event+0x7c/0x188)
 r5:c7bc66c0 r4:c0252234
[<c005d8bc>] (handle_IRQ_event+0x0/0x188) from [<c005f2f0>]
(handle_level_irq+0x94/0xe4)
[<c005f25c>] (handle_level_irq+0x0/0xe4) from [<c001d06c>] (_text+0x6c/0x84)
 r5:c0254fac r4:00000017
[<c001d000>] (_text+0x0/0x84) from [<c01b5bc4>] (__irq_svc+0x24/0x60)
Exception stack(0xc024bf58 to 0xc024bfa0)
bf40:                                                       c0215a88 000000ab
bf60: 00000000 60000013 c024a000 c025d99c c001be08 c024e23c 0001a23c 690541c1
bf80: 0001a138 c024bfac c024bfb0 c024bfa0 c001e514 c001e4ac 60000013 ffffffff
 r6:00800000 r5:0000001f r4:ffffffff
[<c001e484>] (default_idle+0x0/0x2c) from [<c001e514>] (cpu_idle+0x64/0x9c)
[<c001e4b0>] (cpu_idle+0x0/0x9c) from [<c01af5b4>] (rest_init+0x58/0x6c)
 r4:c028dbf4
[<c01af55c>] (rest_init+0x0/0x6c) from [<c0008930>] (start_kernel+0x268/0x2d4)
[<c00086c8>] (start_kernel+0x0/0x2d4) from [<00008034>] (0x8034)
 r6:c001be04 r5:c025d9f8 r4:000039fd
---[ end trace fe6886bfb3a3248e ]---



---------------------------------------
With dmabounce disable patch:
---------------------------------------

usb 6-3: new high speed USB device using ehci_hcd and address 2
ehci_hcd 0000:00:0f.2: fatal error
ehci_hcd 0000:00:0f.2: HC died; cleaning up
hub 6-0:1.0: cannot reset port 3 (err = -19)
hub 6-0:1.0: cannot disable port 3 (err = -19)
hub 6-0:1.0: cannot reset port 3 (err = -19)
hub 6-0:1.0: cannot disable port 3 (err = -19)
hub 6-0:1.0: cannot reset port 3 (err = -19)
hub 6-0:1.0: cannot disable port 3 (err = -19)
hub 6-0:1.0: cannot reset port 3 (err = -19)
hub 6-0:1.0: cannot disable port 3 (err = -19)
hub 6-0:1.0: cannot disable port 3 (err = -19)
usb 3-2: new full speed USB device using ohci_hcd and address 2
usb 3-2: device descriptor read/64, error -62
usb 3-2: device descriptor read/64, error -62
usb 3-2: new full speed USB device using ohci_hcd and address 3
usb 3-2: device descriptor read/64, error -62
usb 3-2: device descriptor read/64, error -62
usb 3-2: new full speed USB device using ohci_hcd and address 4
usb 3-2: device not accepting address 4, error -62
usb 3-2: new full speed USB device using ohci_hcd and address 5
usb 3-2: device not accepting address 5, error -62
hub 3-0:1.0: unable to enumerate USB device on port 2
