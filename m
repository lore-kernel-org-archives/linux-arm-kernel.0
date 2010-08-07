From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sat, 07 Aug 2010 16:42:44 +0300
Subject: usb host port3 on pxa310?
In-Reply-To: <loom.20100806T201947-76@post.gmane.org>
References: <loom.20100806T201947-76@post.gmane.org>
Message-ID: <4C5D62D4.3050500@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/10 21:43, Chen Wenjie wrote:
> I want to use PXA310 to realize a USB HOST.
>
> (My kernel version: 2.6.27)
>   

There was a relatively big change in ohci-pxa27x driver, I think
around 2.6.28-rc1. May be you should consider upgrading...
 
> Zylonite have implemented a USB host through USBH_N(USBH1_N) USBH_P(USBH1_P).
> Unfortunatly, In PXA310, the pins of USBH1_N and USBH1_P does not exist.
>
> So I have to use  "usb host port3 " described in the manual "Vol. IV: Monahans 
> L Processor and
> Monahans LV Processor Developers Manual"
>
>
>
> GPIO
> Alternate
> Function
> Port					UP3OCR[CFG]
> 			0x0 					   0x2 	
> USB_P3_1	UHC Rx Data	(RCV - in)	?	UHC Rx Data	(RCV - 
> out)	?
> USB_P3_2	UHC OE	(OE_n - out)	?	UHC OE		(OE_n - in)
> 	?
> USB_P3_3	UHC Rx D?	(VM - in)	?	UHC Rx D-	(VM - 
> out)	?
> USB_P3_4	UHC Tx D?	(VMO - out)	?	UHC Tx D-	(VMO - 
> in)	?
> USB_P3_5	UHC Rx D+	(VP - in)	?	UHC Rx D+	(VP - 
> out)	?
> USB_P3_6	UHC Tx D+	(VPO - out)	?	UHC Tx D+	(VPO - 
> in)	?
>
> In the schematic, I have connected GPIO77~82 to USB_P3_1 ~ USB_P3_6.
>   

You need also to configure those gpios to alternate function 2 in the MFPRs.
If you use a transceiver mode, then may be you need USBHPEN signal
connected to your PHY and configured accordingly in MFPR.
Also, in pxa310 there is a U2DP3CR register, which controls output
and serial mode selection of the usb port3.

>
>
> However, The USB port 3 does not work.
> Here is the log:
>
> ======================================
> pxa27x-ohci pxa27x-ohci: PXA27x OHCI
> pxa27x-ohci pxa27x-ohci: new USB bus registered, assigned bus number 1
> pxa27x-ohci pxa27x-ohci: irq 3, io mem 0x4c000000
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: PXA27x OHCI
> usb usb1: Manufacturer: Linux 2.6.27-dirty ohci_hcd
> usb usb1: SerialNumber: pxa27x
> sl811: driver sl811-hcd, 19 May 2005
> r8a66597_hcd: driver r8a66597_hcd, 10 Apr 2008
>   

Do you really have sl811 and r8a66597 usb host controllers on your board?

> usb 1-3: new full speed USB device using pxa27x-ohci and address 2
> usb 1-3: device descriptor read/64, error -62
> usb 1-3: device descriptor read/64, error -62
> usb 1-3: new full speed USB device using pxa27x-ohci and address 3
> usb 1-3: device descriptor read/64, error -62
> usb 1-3: device descriptor read/64, error -62
> usb 1-3: new full speed USB device using pxa27x-ohci and address 4
> usb 1-3: device not accepting address 4, error -62
> usb 1-3: new full speed USB device using pxa27x-ohci and address 5
> usb 1-3: device not accepting address 5, error -62
> hub 1-0:1.0: unable to enumerate USB device on port 3
> ======================================
>
>
> Then I found a bit in UP2OCR -- (VPMBlockEnbN).
> It is quite strange (if not ugly:( ) the this bit is to control port 3
> (In UP2OCR--a register for port 2, while there is too many unused bits in 
> UP3OCR)
>
> But I am not very sure how to use this bit.
> I grep the source tree, but found nothing about VPMBlockEnbN.
>
>
> Can anyone tell me that how to write a driver for USB-host-port-3?
>   

As far as I know pxa310 usb port3 does not need any special driver
to work in host mode, ohci-pxa27x is enough.
Currently, the setup of registers, which are not related to UHC
(UP2OCR, UP3OCR, etc.), is done in the board code, in the ohci
callback.

> High appreciation for your kind help!
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   

-- 
Regards,
Igor.
