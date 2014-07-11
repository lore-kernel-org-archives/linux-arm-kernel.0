From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Fri, 11 Jul 2014 08:47:44 +0200
Subject: [BUG] usb: gadget: rndis: atmel_usba_udc: probe of 500000.gadget
 failed with error -2
Message-ID: <53BF8890.9020409@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I discovered bug when I try to use RNDIS gadget driver on SAM9G25 with version 3.16.0-rc4. In version 3.14.0-rc4 it was OK.
If I plug pc to device port on my board I expect to establish ethernet connection, instead of this it looks like it 
behave like host port. If I look at all messages I found some problem during boot:
[    1.585937] atmel_usba_udc: probe of 500000.gadget failed with error -2

Here is dmesg | grep usb of 3.16:

[    0.187500] usbcore: registered new interface driver usbfs
[    0.187500] usbcore: registered new interface driver hub
[    0.187500] usbcore: registered new device driver usb
[    1.375000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.382812] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.390625] usb usb1: Product: EHCI Host Controller
[    1.394531] usb usb1: Manufacturer: Linux 3.16.0-rc4_cpm9g25 ehci_hcd
[    1.402343] usb usb1: SerialNumber: 700000.ehci
[    1.507812] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.511718] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.519531] usb usb2: Product: OHCI Host Controller
[    1.527343] usb usb2: Manufacturer: Linux 3.16.0-rc4_cpm9g25 ohci_hcd
[    1.531250] usb usb2: SerialNumber: at91
[    1.562500] usbcore: registered new interface driver cdc_acm
[    1.578125] usbcore: registered new interface driver usb-storage
[    1.585937] atmel_usba_udc: probe of 500000.gadget failed with error -2
[    2.375000] usb 2-3: new full-speed USB device number 3 using at91_ohci
[    2.574218] usb 2-3: not running at top speed; connect to a high speed hub
[    2.593750] usb 2-3: New USB device found, idVendor=04b4, idProduct=6570
[    2.609375] usb 2-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.621093] usb 2-3: Product: USB2.0 Hub
[    3.714843] usb 2-3.3: new full-speed USB device number 5 using at91_ohci
[    3.828125] usb 2-3.3: not running at top speed; connect to a high speed hub
[    3.851562] usb 2-3.3: New USB device found, idVendor=1005, idProduct=b155
[    3.867187] usb 2-3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.875000] usb 2-3.3: Product: USB DISK MODULE
[    3.882812] usb 2-3.3: Manufacturer:
[    3.890625] usb 2-3.3: SerialNumber: 19D30D00AB2E10B4
[    3.898437] usb-storage 2-3.3:1.0: USB Mass Storage device detected
[    3.914062] scsi0 : usb-storage 2-3.3:1.0
[  793.761718] usb 2-1: new full-speed USB device number 79 using at91_ohci
[  793.945312] usb 2-1: device descriptor read/64, error -62
[  794.601562] usb 2-1: new full-speed USB device number 80 using at91_ohci
[  794.785156] usb 2-1: device descriptor read/64, error -62
[  795.441406] usb 2-1: new full-speed USB device number 81 using at91_ohci
[  795.625000] usb 2-1: device descriptor read/64, error -62
[  796.281250] usb 2-1: new full-speed USB device number 82 using at91_ohci
[  796.464843] usb 2-1: device descriptor read/64, error -62
[  797.121093] usb 2-1: new full-speed USB device number 83 using at91_ohci

And here is dmesg | grep usb of 3.14:

[    0.199218] usbcore: registered new interface driver usbfs
[    0.199218] usbcore: registered new interface driver hub
[    0.199218] usbcore: registered new device driver usb
[    1.042968] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.046875] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.050781] usb usb1: Product: EHCI Host Controller
[    1.054687] usb usb1: Manufacturer: Linux 3.14.0-rc4_cpm9g25+ ehci_hcd
[    1.058593] usb usb1: SerialNumber: 700000.ehci
[    1.152343] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.156250] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.160156] usb usb2: Product: OHCI Host Controller
[    1.164062] usb usb2: Manufacturer: Linux 3.14.0-rc4_cpm9g25+ ohci_hcd
[    1.167968] usb usb2: SerialNumber: at91
[    1.195312] usbcore: registered new interface driver cdc_acm
[    1.207031] usbcore: registered new interface driver usb-storage
[    1.214843] usbcore: registered new interface driver usbserial
[    1.222656] atmel_usba_udc 500000.gadget: MMIO registers at 0xf803c000 mapped at c8880000
[    1.226562] atmel_usba_udc 500000.gadget: FIFO at 0x00500000 mapped at c8900000
[    1.238281] usb0: HOST MAC ee:b0:ac:4b:23:3e
[    1.242187] usb0: MAC a6:db:aa:b5:ef:4b
[    2.031250] usb 2-3: new full-speed USB device number 3 using at91_ohci
[    2.230468] usb 2-3: not running at top speed; connect to a high speed hub
[    2.246093] usb 2-3: New USB device found, idVendor=04b4, idProduct=6570
[    2.257812] usb 2-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.265625] usb 2-3: Product: USB2.0 Hub
[    8.890625] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[62918.265625] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready

So what is wrong?

Best regards
Jiri Prchal
