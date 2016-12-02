From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Dec 2016 12:08:21 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <20161202104208.GA8736@kroah.com>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr> <20161202104208.GA8736@kroah.com>
Message-ID: <58415625.3020703@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 11:42, Greg KH wrote:

> On Fri, Dec 02, 2016 at 11:24:05AM +0100, Mason wrote:
> 
>> # lsusb -v
>> Bus 001 Device 001: ID 1d6b:0002
>> Bus 002 Device 001: ID 1d6b:0003
>>
>> Isn't lsusb verbose supposed to print much more than that?
> 
> Yes, if you are using the usbutils version of 'lsusb', odds are this is
> busybox, right?

Right. (You win a digital cookie.)

cd buildroot && make menuconfig
Drop BR2_PACKAGE_USBMOUNT (maybe it causes unexpected issues)
 Add BR2_PACKAGE_USBUTILS (I want the real deal)

> And these are just the root hubs, that the USB controller driver creates
> as "virtual" USB devices, they are not "real" USB devices on your bus.

# lsusb --version
lsusb (usbutils) 007
I see there's a 008 version.
Am I missing out on important diagnostics?

# lsusb -v

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         3 
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            4.07
  iManufacturer           3 Linux 4.7.0-rc6 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 30040000.usb3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           31
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             1
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.0 micro seconds
  wHubDelay             0 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           15
  bNumDeviceCaps          1
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x0008
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat           0 micro seconds
    bU2DevExitLat           0 micro seconds
Device Status:     0x0001
  Self Powered

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.07
  iManufacturer           3 Linux 4.7.0-rc6 xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 30040000.usb3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             1
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
Device Status:     0x0001
  Self Powered


Does everything look normal?
Or are there any investigation-worthy nuggets?

Regards.
