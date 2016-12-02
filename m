From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Dec 2016 09:46:17 +0100
Subject: XHCI controller does not detect USB key insertion
Message-ID: <584134D9.5000404@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm trying out a SoC with a brand new USB controller, which is (supposedly)
a standard XHCI controller. In theory, I would just need to build the right
driver, and everything would auto-magically work, right?


So my defconfig contains:

CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y


And my device tree contains:

	usb3 at 30040000 {
		compatible = "generic-xhci";
		reg = <0x30040000 0x10000>;
		interrupts = <SIGMA_HWIRQ 67 IRQ_TYPE_LEVEL_HIGH>;
	};


The boot messages I get:

[    1.618214] xhci-hcd 30040000.usb3: xHCI Host Controller
[    1.623611] xhci-hcd 30040000.usb3: new USB bus registered, assigned bus number 1
[    1.631181] reset function is xhci_plat_setup
[    1.635588] xhci_plat_setup from usb_add_hcd
[    1.640109] xhci-hcd 30040000.usb3: hcc params 0x30003192 hci version 0x100 quirks 0x00010010
[    1.648766] xhci-hcd 30040000.usb3: irq 22, io mem 0x30040000
[    1.654572] xhci_plat_start from usb_add_hcd
[    1.659086] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.665943] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.673228] usb usb1: Product: xHCI Host Controller
[    1.678154] usb usb1: Manufacturer: Linux 4.7.0-rc6 xhci-hcd
[    1.683865] usb usb1: SerialNumber: 30040000.usb3
[    1.689391] hub 1-0:1.0: USB hub found
[    1.693227] hub 1-0:1.0: 1 port detected
[    1.697601] xhci-hcd 30040000.usb3: xHCI Host Controller
[    1.702983] xhci-hcd 30040000.usb3: new USB bus registered, assigned bus number 2
[    1.710545] reset function is xhci_plat_setup
[    1.714950] xhci_plat_setup from usb_add_hcd
[    1.719265] xhci_plat_start from usb_add_hcd
[    1.723653] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.731956] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.738814] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.746100] usb usb2: Product: xHCI Host Controller
[    1.751025] usb usb2: Manufacturer: Linux 4.7.0-rc6 xhci-hcd
[    1.756736] usb usb2: SerialNumber: 30040000.usb3
[    1.762195] hub 2-0:1.0: USB hub found
[    1.766027] hub 2-0:1.0: 1 port detected
[    1.770661] usbcore: registered new interface driver usb-storage
[    1.784584] usbcore: registered new interface driver usbhid
[    1.790213] usbhid: USB HID core driver

Which looks encouraging, right?


Am I supposed to have had USB interrupts at that point?

# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  20:        609        365        393        356     GIC-0  29 Edge      twd
  21:        101          0          0          0      INTC   1 Level     serial
  22:          0          0          0          0      INTC  67 Level     xhci-hcd:usb1
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:        794        620       1223       1045  Rescheduling interrupts
IPI3:          0         37         37         37  Function call interrupts
IPI4:          0          0          0          0  CPU stop interrupts
IPI5:          0          0          0          0  IRQ work interrupts
IPI6:          0          0          0          0  completion interrupts
 Err:          0


When I insert a USB key, nothing happens :-(

# lsusb -v
Bus 001 Device 001: ID 1d6b:0002
Bus 002 Device 001: ID 1d6b:0003


I'd like to hear suggestions about what I can tweak to fix the problem.

Regards.
