From: ccc.cwj@gmail.com (=?utf-8?B?Q2hlbiBXZW5qaWU=?=)
Date: Sun, 22 Aug 2010 03:31:50 +0800
Subject: =?utf-8?B?UmU6IFJlOiB1c2IgaG9zdCBwb3J0MyBvbiBweGEzMTA/?=
References: <loom.20100806T201947-76@post.gmane.org>,
	<201008080921466561614@gmail.com>
Message-ID: <201008220331449066056@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Igor and all,

	Thank you very much for giving me such valuable help.

	Now I have upgrade the ohci part (drivers/usb/host/ohci-pxa270.c ..)
to 2.6.29. (I am failed on upgrade the total branch from 2.6.27 to 2.6.29 :(  )

	But the problem still exist. 
 (the isp1105 was really assembled; and  the GPIO pins are initialized with 
 pxa3xx_mfp_config() ).

when I insert a usb-disk, it output 
-----------------------------------------------------------------------------------------
usb 1-3: new full speed USB device using pxa27x-ohci and address 2
usb 1-3: device descriptor read/64, error -62
usb 1-3: device descriptor read/64, error -62
usb 1-3: new full speed USB device using pxa27x-ohci and address 3
usb 1-3: device descriptor read/64, error -62
usb 1-3: device descriptor read/64, error -62
usb 1-3: new full speed USB device using pxa27x-ohci and address 4
usb 1-3: device not accepting address 4, error -62
usb 1-3: new full speed USB device using pxa27x-ohci and address 5
usb 1-3: device not accepting address 5, error -62
hub 1-0:1.0: unable to enumerate USB device on port 3
----------------------------------------------------------------------------------------


and dmesg shows this info continuesly.:
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
...
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000



a detailed log file is attached.


Is there any hardware problem?
maybe the connection of ISP1105 was wrong.

and I found the VCC voltage is only 3.0v, it is lower than 3.3v
(in the spec). Is this a fatal issue?

Thank you very much!


------------------				 
Chen Wenjie
2010-08-22

-------------------------------------------------------------
From?Igor Grinberg
Date?2010-08-08 14:03:02
To?Chen Wenjie
CC?linux-arm-kernel
Subject?Re: usb host port3 on pxa310?

On 08/08/10 04:21, Chen Wenjie wrote:
> Hi, Igor,
> Thank you very much for your warm and professional help!
> I will try to upgrade the codes for ohci-pxa27x first.
> > Do you really have sl811 and r8a66597 usb host controllers on your
> board?
> I think no real IC installed on my board, I just configure it on
> menuconfig by choose something
> seems related to USB (--blindly)

I'd rather remove the unused drivers from the configuration,
then have them built-in and do something with the missing hardware...

> Actually, my board use a ISP1105 as the PHY interface???the schematic is :
> http://picasaweb.google.com/114830881710721561783/Public#5502732460750351090
>

As far as I know DNP, stands for "Do Not Populate".
It states: "ISP1105BS(DNP)" - is it assembled at all?

> Do you think there is anything wrong?
> GPIO setting is :
> //file: mfp-pxa300.h
> /* USB P3 */
> #define GPIO77_USB_P3_1 MFP_CFG(GPIO77, AF2)
> #define GPIO78_USB_P3_2 MFP_CFG(GPIO78, AF2)
> #define GPIO79_USB_P3_3 MFP_CFG(GPIO79, AF2)
> #define GPIO80_USB_P3_4 MFP_CFG(GPIO80, AF2)
> #define GPIO81_USB_P3_5 MFP_CFG(GPIO81, AF2)
> #define GPIO82_USB_P3_6 MFP_CFG(GPIO82, AF2)
> #define GPIO126_USB_SPEED MFP_CFG_LPM(GPIO126, AF5, PULL_HIGH)

Indeed, those are the defines, but you need to do the actual configuration
for them, by calling pxa3xx_mfp_config() with appropriate parameters.

> I will upgrade the driver and test it again.
> Thank you very very much!
> 2010-08-08
> ------------------------------------------------------------------------
> Chen Wenjie
> ------------------------------------------------------------------------
> *????????????* Igor Grinberg
> *???????????????* 2010-08-07 21:42:57
> *????????????* Chen Wenjie
> *?????????* linux-arm-kernel
> *?????????* Re: usb host port3 on pxa310?
> On 08/06/10 21:43, Chen Wenjie wrote:
> > I want to use PXA310 to realize a USB HOST.
> >
> > (My kernel version: 2.6.27)
> >
> There was a relatively big change in ohci-pxa27x driver, I think
> around 2.6.28-rc1. May be you should consider upgrading...
> > Zylonite have implemented a USB host through USBH_N(USBH1_N)
> USBH_P(USBH1_P).
> > Unfortunatly, In PXA310, the pins of USBH1_N and USBH1_P does not exist.
> >
> > So I have to use "usb host port3 " described in the manual "Vol. IV:
> Monahans
> > L Processor and
> > Monahans LV Processor Developers Manual"
> >
> >
> >
> > GPIO
> > Alternate
> > Function
> > Port UP3OCR[CFG]
> > 0x0 0x2
> > USB_P3_1 UHC Rx Data (RCV - in) ??? UHC Rx Data (RCV -
> > out) ???
> > USB_P3_2 UHC OE (OE_n - out) ??? UHC OE (OE_n - in)
> > ???
> > USB_P3_3 UHC Rx D??? (VM - in) ??? UHC Rx D- (VM -
> > out) ???
> > USB_P3_4 UHC Tx D??? (VMO - out) ??? UHC Tx D- (VMO -
> > in) ???
> > USB_P3_5 UHC Rx D+ (VP - in) ??? UHC Rx D+ (VP -
> > out) ???
> > USB_P3_6 UHC Tx D+ (VPO - out) ??? UHC Tx D+ (VPO -
> > in) ???
> >
> > In the schematic, I have connected GPIO77~82 to USB_P3_1 ~ USB_P3_6.
> >
> You need also to configure those gpios to alternate function 2 in the
> MFPRs.
> If you use a transceiver mode, then may be you need USBHPEN signal
> connected to your PHY and configured accordingly in MFPR.
> Also, in pxa310 there is a U2DP3CR register, which controls output
> and serial mode selection of the usb port3.
> >
> >
> > However, The USB port 3 does not work.
> > Here is the log:
> >
> > ======================================
> > pxa27x-ohci pxa27x-ohci: PXA27x OHCI
> > pxa27x-ohci pxa27x-ohci: new USB bus registered, assigned bus number 1
> > pxa27x-ohci pxa27x-ohci: irq 3, io mem 0x4c000000
> > usb usb1: configuration #1 chosen from 1 choice
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 3 ports detected
> > usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> > usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > usb usb1: Product: PXA27x OHCI
> > usb usb1: Manufacturer: Linux 2.6.27-dirty ohci_hcd
> > usb usb1: SerialNumber: pxa27x
> > sl811: driver sl811-hcd, 19 May 2005
> > r8a66597_hcd: driver r8a66597_hcd, 10 Apr 2008
> >
> Do you really have sl811 and r8a66597 usb host controllers on your board?
> > usb 1-3: new full speed USB device using pxa27x-ohci and address 2
> > usb 1-3: device descriptor read/64, error -62
> > usb 1-3: device descriptor read/64, error -62
> > usb 1-3: new full speed USB device using pxa27x-ohci and address 3
> > usb 1-3: device descriptor read/64, error -62
> > usb 1-3: device descriptor read/64, error -62
> > usb 1-3: new full speed USB device using pxa27x-ohci and address 4
> > usb 1-3: device not accepting address 4, error -62
> > usb 1-3: new full speed USB device using pxa27x-ohci and address 5
> > usb 1-3: device not accepting address 5, error -62
> > hub 1-0:1.0: unable to enumerate USB device on port 3
> > ======================================
> >
> >
> > Then I found a bit in UP2OCR -- (VPMBlockEnbN).
> > It is quite strange (if not ugly:( ) the this bit is to control port 3
> > (In UP2OCR--a register for port 2, while there is too many unused
> bits in
> > UP3OCR)
> >
> > But I am not very sure how to use this bit.
> > I grep the source tree, but found nothing about VPMBlockEnbN.
> >
> >
> > Can anyone tell me that how to write a driver for USB-host-port-3?
> >
> As far as I know pxa310 usb port3 does not need any special driver
> to work in host mode, ohci-pxa27x is enough.
> Currently, the setup of registers, which are not related to UHC
> (UP2OCR, UP3OCR, etc.), is done in the board code, in the ohci
> callback.
> > High appreciation for your kind help!
> >
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> -- 
> Regards,
> Igor.

-- 
Regards,
Igor.

.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0822-0026-usb-insert-disk.log
Type: application/octet-stream
Size: 88752 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100822/ba7b9ea3/attachment-0001.obj>
