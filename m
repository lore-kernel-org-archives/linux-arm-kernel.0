From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 5 Oct 2016 13:18:05 +0530
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CAFp+6iE6aqvOKE4HVCeCokPk_oTHLduS6Gsv+CF4_p4JjkF2TQ@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com>
 <57C41582.1030604@linux.intel.com> <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
 <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
 <1475578687.1912.28.camel@mniewoehner.de>
 <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
 <CANAwSgQ2j+NtDwgn972-1UdY=j4DEsB+0d7VdhoC9i9WHRc9yQ@mail.gmail.com>
 <CAFp+6iE6aqvOKE4HVCeCokPk_oTHLduS6Gsv+CF4_p4JjkF2TQ@mail.gmail.com>
Message-ID: <CANAwSgRSwwWx2ADZZ2rk7555g4bY+MeFbysPOVs44POWRKyvaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 5 October 2016 at 10:15, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> Hi Anand,
>
>
> On Tue, Oct 4, 2016 at 8:39 PM, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Vivek,
>>
>
> [snip]
>
>>
>> What I feel is that their need to be some reset of usb phy so that
>> device are assigned to respective bus ports.
>
> The phy resets are what we do in the phy-exynos5-usbdrd driver. In
> addition to what we
> have currently in this phy driver, we just need the phy calibration
> patch [1] for phy configurations.
>
> [1] https://lkml.org/lkml/2015/2/2/259

Yes I am only using the above patch.
If you dont mind please resend this patch again.

>
>> odroid at odroid:~$ lsusb -t
>> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>>     |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
>
> This shows the ethernet device gets detected on the high-speed port of one
> of the controller.
> The lsusb output for kernel v4.7.x posted by Michael show that the
> ethernet device got detected on super-speed port of the controller.
> So, there seems to be a difference between the two.
> Or, is this how it is behaving ?

With other patches it miss behaves and the ethernet land onto another bus
port
.


> Is this lsusb output on 4.8 kernel with the patch [1] ?

Yes correct.

>
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
>>         |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>>         |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
>>     |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>>
>>
>> Bus 06.Port should register the Realtek Ethernet r8153 device.
>> But I am not able to trace out how it's should happen.
>
> If i understand, below is how the configuration looks like on the board?
>
>                 +-----------------------+
>         +------>|                       |
>         |       |       Bus 6           |-------+
> +-----------+   |    (super-speed)      |       |
> |           |   +-----------------------+       |
> |Controller |                                   | --------> Ethernet device
> |    2      |                                   |
> |           |   +-----------------------+       |
> +-----------+   |                       |       |
>         |       |       Bus 5           |-------+
>         +------>|   (high-speed)        |
>                 +-----------------------+
>
>
>                 +-----------------------+
>         +------>|                       |
>         |       |       Bus 4           |-------+
> +-----------+   |    (super-speed)      |       |
> |           |   +-----------------------+       |
> |Controller |                                   | --------> (On board
> hub ?? _OR_ external hub with downstream devices) ???
> |    1      |                                   |
> |           |   +-----------------------+       |
> +-----------+   |                       |       |
>         |       |       Bus 3           |-------+
>         +------>|   (high-speed)        |
>                 +-----------------------+
>
[snip]

Yes this is correct mapping of usb ports and ethernet on the board.

Below is the schematic of the board.

http://dn.odroid.com/5422/ODROID-XU4/Schematics/XU4_MAIN_REV0.1_20151202.pdf

I have couple of questions so if you can help me out.

1 > Their is no vbus pin connector to the usb ports ?

2 > I have also tried to configure usbdrd_dwc3_0/1 nodes with no luck
                        snps,usb3_lpm_capable;
                        snps,dis_u3_susphy_quirk;
                        snps,dis_u2_susphy_quirk;

3 > do you feel their could be way to reset the USB PHY (ethenet)
       either though the DTS using gpio and pincrt

4 > how should be the port mapping done to the usb hub.
      Odroid XU4 has 2 usb 3.0 and 1 ehci port.
      Odroid XU3 has 1 usb 3.0 and 1 usb 3.0 otg port and 4 ehci
port


I would like to know how to debug low level debug of USB connection.
so that we could solve the issue.

Thanks for you help in looking to this, please guide me.
Attach is the logs of lsusb -v and console output.

-Best Regards
Anand Moon
-------------- next part --------------
odroid at odroid:~$ lsusb -v

Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Couldn't open device, some information will be missing
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
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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

Bus 005 Device 002: ID 0bda:8153 Realtek Semiconductor Corp.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x8153
  bcdDevice           30.00
  iManufacturer           1
  iProduct                2
  iSerial                 6
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              180mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           80
    bNumInterfaces          2
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              180mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      6 Ethernet Networking
      bInterfaceProtocol      0
      iInterface              5
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1
      CDC Ethernet:
        iMacAddress                      3 (??)
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0

Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
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
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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

Bus 004 Device 003: ID 05e3:0735 Genesys Logic, Inc.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0735
  bcdDevice           10.03
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           44
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               24mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk-Only
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15

Bus 004 Device 002: ID 05e3:0616 Genesys Logic, Inc. hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         3
  bMaxPacketSize0         9
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0616 hub
  bcdDevice           92.22
  iManufacturer           1
  iProduct                2
  iSerial                 0
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
      iInterface              1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes           19
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
        bMaxBurst               0

Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Couldn't open device, some information will be missing
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
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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

Bus 003 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         2 TT per port
  bMaxPacketSize0        64
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0610 4-port hub
  bcdDevice           92.22
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      1 Single TT
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      2 TT per port
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12

Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
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
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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

Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            4.08
  iManufacturer           3
  iProduct                2
  iSerial                 1
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
odroid at odroid:~$

----------------------------------------------------------------------------------------
U-Boot 2012.07-00036-g4d29c46-dirty (Dec 04 2015 - 15:52:26) for Exynos5422

CPU: Exynos5422 Rev0.1 [Samsung SOC on SMP Platform Base on ARM CortexA7]
APLL = 800MHz, KPLL = 800MHz
MPLL = 532MHz, BPLL = 825MHz

Board: HardKernel ODROID
DRAM:  2 GiB
WARNING: Caches not enabled

TrustZone Enabled BSP
BL1 version: ?/???
VDD_KFC: 0x44
LDO19: 0xf2

Checking Boot Mode ... SDMMC
MMC:   S5P_MSHC2: 0, S5P_MSHC0: 1
MMC Device 0: 29 GiB
MMC Device 1: [ERROR] response timeout error : 00000104 cmd 1
Card did not respond to voltage select!
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Press quickly 'Enter' twice to stop autoboot:  0
there are pending interrupts 0x00000001
reading boot.ini

9183 bytes read
Loading boot.ini from FAT
Find boot.ini file from FAT/Ext4 Area!!
boot.ini command = setenv initrd_high "0xffffffff"
boot.ini command = setenv fdt_high "0xffffffff"
boot.ini command = setenv macaddr "00:1e:06:61:7a:39"
boot.ini command = setenv bootrootfs "console=tty1 console=ttySAC2,115200n8 root=UUID=e139ce78-9841-40fe-8823-96a304a09859 rootwait ro fsck.repair=yes net.ifnames=0"
boot.ini command = setenv vout "hdmi"
boot.ini command = setenv cecenable "false" # false or true
boot.ini command = setenv governor "performance"
boot.ini command = setenv HPD "true"
boot.ini command = setenv hdmi_tx_amp_lvl  "31"
boot.ini command = setenv hdmi_tx_lvl_ch0      "3"
boot.ini command = setenv hdmi_tx_lvl_ch1      "3"
boot.ini command = setenv hdmi_tx_lvl_ch2      "3"
boot.ini command = setenv hdmi_tx_emp_lvl      "6"
boot.ini command = setenv hdmi_clk_amp_lvl     "31"
boot.ini command = setenv hdmi_tx_res      "0"
boot.ini command = setenv hdmi_phy_control "hdmi_tx_amp_lvl=${hdmi_tx_amp_lvl} hdmi_tx_lvl_ch0=${hdmi_tx_lvl_ch0} hdmi_tx_lvl_ch1=${hdmi_tx_lvl_ch1} hdmi_tx_lvl_ch2=${hdmi_tx_lvl_ch2} hdmi_tx_emp_lvl=${hdmi_tx_emp_lvl} hdmi_clk_amp_lvl=${hdmi_clk_amp_lvl} hdmi_tx_res=${hdmi_tx_res} HPD=${HPD} vout=${vout}"
boot.ini command = fatload mmc 0:1 0x40008000 zImage
reading zImage

4942552 bytes read
boot.ini command = fatload mmc 0:1 0x42000000 uInitrd
reading uInitrd

8303688 bytes read
boot.ini command = fatload mmc 0:1 0x44000000 exynos5422-odroidxu3.dtb
reading exynos5422-odroidxu3.dtb

54647 bytes read
boot.ini command = fdt addr 0x44000000
boot.ini command = if test "${cecenable}" = "false"; then fdt rm /cec at 101B0000; fi
libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND
boot.ini command = setenv bootargs "${bootrootfs} ${videoconfig} smsc95xx.macaddr=${macaddr} governor=${governor} ${hdmi_phy_control}"
boot.ini command = bootz 0x40008000 0x42000000 0x44000000
## Loading init Ramdisk from Legacy Image at 42000000 ...
   Image Name:   uInitrd
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    8303624 Bytes = 7.9 MiB
   Load Address: 00000000
   Entry Point:  00000000
## Flattened Device Tree blob at 44000000
   Booting using the fdt blob at 0x44000000
   Using Device Tree in place at 44000000, end 44010576

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x100
[    0.000000] Linux version 4.8.0-xu4ml (root at odroid) (gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.2) ) #16 SMP PREEMPT Mon Oct 3 17:28:30 UTC 2016
[    0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Hardkernel Odroid XU4
[    0.000000] Reserved memory: created DMA memory pool at 0xbe200000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_right, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0xbd200000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node region_mfc_left, compatible id shared-dma-pool
[    0.000000] cma: Reserved 64 MiB at 0xb9000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe5422001
[    0.000000] Running under secure firmware.
[    0.000000] percpu: Embedded 366 pages/cpu @ee484000 s1470000 r8192 d20944 u1499136
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 510976
[    0.000000] Kernel command line: console=tty1 console=ttySAC2,115200n8 root=UUID=e139ce78-9841-40fe-8823-96a304a09859 rootwait ro fsck.repair=yes net.ifnames=0 smsc95xx.macaddr=00:1e:06:61:7a:39 governor=performance hdmi_tx_amp_lvl=31 hdmi_tx_lvl_ch0=3 hdmi_tx_lvl_ch1=3 hdmi_tx_lvl_ch2=3 hdmi_tx_emp_lvl=6 hdmi_clk_amp_lvl=31 hdmi_tx_res=0 HPD=true vout=hdmi
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1925660K/2050048K available (7168K kernel code, 327K rwdata, 2380K rodata, 2048K init, 9112K bss, 58852K reserved, 65536K cma-reserved, 1198080K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0b00000 - 0xc0d00000   (2048 kB)
[    0.000000]       .data : 0xc0d00000 - 0xc0d51fc0   ( 328 kB)
[    0.000000]        .bss : 0xc0d53000 - 0xc16392b4   (9113 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  RCU kthread priority: 1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000009] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.001989] Console: colour dummy device 80x30
[    0.014024] console [tty1] enabled
[    0.014064] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.014121] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.014157] ... MAX_LOCK_DEPTH:          48
[    0.014192] ... MAX_LOCKDEP_KEYS:        8191
[    0.014228] ... CLASSHASH_SIZE:          4096
[    0.014264] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.014300] ... MAX_LOCKDEP_CHAINS:      65536
[    0.014336] ... CHAINHASH_SIZE:          32768
[    0.014372]  memory used by lock dependency info: 5423 kB
[    0.014411]  per task-struct memory footprint: 2304 bytes
[    0.014450] ------------------------
[    0.014483] | Locking API testsuite:
[    0.014517] ----------------------------------------------------------------------------
[    0.014574]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.014631]   --------------------------------------------------------------------------
[    0.014708]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.025766]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.036982]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.048501]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.060095]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.071953]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.083788]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.095683]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.106444]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.117112]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.128173]   --------------------------------------------------------------------------
[    0.128234]               recursive read-lock:             |  ok  |             |  ok  |
[    0.131898]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.135563]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.139172]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.142868]   --------------------------------------------------------------------------
[    0.142927]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.148317]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.153736]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.159152]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.164566]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.170071]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.175479]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.180876]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.186296]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.191700]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.197120]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.202694]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.208265]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.213834]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.219405]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.225066]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.230650]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.236184]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.241731]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.247178]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.252645]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.258178]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.263731]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.269268]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.274831]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.280436]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.285997]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.291537]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.297103]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.302616]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.308158]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.313671]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.319238]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.324782]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.330420]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.335965]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.341541]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.347068]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.352649]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.358203]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.363786]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.369312]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.374877]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.380497]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.386083]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.391612]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.397179]       hard-irq read-recursion/123:  ok  |
[    0.399039]       soft-irq read-recursion/123:  ok  |
[    0.401000]       hard-irq read-recursion/132:  ok  |
[    0.402865]       soft-irq read-recursion/132:  ok  |
[    0.404739]       hard-irq read-recursion/213:  ok  |
[    0.406691]       soft-irq read-recursion/213:  ok  |
[    0.408567]       hard-irq read-recursion/231:  ok  |
[    0.410519]       soft-irq read-recursion/231:  ok  |
[    0.412395]       hard-irq read-recursion/312:  ok  |
[    0.414257]       soft-irq read-recursion/312:  ok  |
[    0.416219]       hard-irq read-recursion/321:  ok  |
[    0.418082]       soft-irq read-recursion/321:  ok  |
[    0.420043]   --------------------------------------------------------------------------
[    0.420103]   | Wound/wait tests |
[    0.420136]   ---------------------
[    0.420170]                   ww api failures:  ok  |  ok  |  ok  |
[    0.425739]                ww contexts mixing:  ok  |  ok  |
[    0.429342]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.436673]                locking mismatches:  ok  |  ok  |  ok  |
[    0.442165]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.460772]            spinlock nest unlocked:  ok  |
[    0.462567]   -----------------------------------------------------
[    0.462612]                                  |block | try  |context|
[    0.462653]   -----------------------------------------------------
[    0.462695]                           context:  ok  |  ok  |  ok  |
[    0.468263]                               try:  ok  |  ok  |  ok  |
[    0.473716]                             block:  ok  |  ok  |  ok  |
[    0.479164]                          spinlock:  ok  |  ok  |  ok  |
[    0.484832] -------------------------------------------------------
[    0.484877] Good, all 253 testcases passed! |
[    0.484913] ---------------------------------
[    0.487844] ODEBUG: selftest passed
[    0.487981] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=120000)
[    0.488065] pid_max: default: 32768 minimum: 301
[    0.488835] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.488898] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.494043] CPU: Testing write buffer coherency: ok
[    0.497000] CPU0: update cpu_capacity 448
[    0.497061] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.497432] Setting up static identity map for 0x40100000 - 0x40100058
[    0.498995] ARM CCI driver probed
[    0.499373] Exynos MCPM support installed
[    0.565666] CPU1: update cpu_capacity 448
[    0.565677] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.585574] CPU2: update cpu_capacity 448
[    0.585584] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.605569] CPU3: update cpu_capacity 448
[    0.605580] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.625596] CPU4: update cpu_capacity 1535
[    0.625606] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.645558] CPU5: update cpu_capacity 1535
[    0.645566] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.665565] CPU6: update cpu_capacity 1535
[    0.665574] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.685573] CPU7: update cpu_capacity 1535
[    0.685582] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.686297] Brought up 8 CPUs
[    0.686807] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.686856] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x1a)
[    0.686921] CPU: This may indicate a broken bootloader or firmware.
[    0.692572] devtmpfs: initialized
[    0.887025] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[    0.889761] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.894403] pinctrl core: initialized pinctrl subsystem
[    0.905716] random: fast init done
[    0.906048] NET: Registered protocol family 16
[    0.913914] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.935361] cpuidle: using governor menu
[    1.012107] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    1.012192] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    1.062219] iommu: Adding device 11000000.codec to group 0
[    1.201513] iommu: Adding device 14450000.mixer to group 1
[    1.203951] iommu: Adding device 11c00000.rotator to group 2
[    1.211482] iommu: Adding device 13e00000.video-scaler to group 3
[    1.213822] iommu: Adding device 13e10000.video-scaler to group 4
[    1.216276] iommu: Adding device 11f50000.jpeg to group 5
[    1.218608] iommu: Adding device 11f60000.jpeg to group 6
[    1.220528] EXYNOS5420 PMU initialized
[    1.394101] SCSI subsystem initialized
[    1.396405] usbcore: registered new interface driver usbfs
[    1.396937] usbcore: registered new interface driver hub
[    1.397930] usbcore: registered new device driver usb
[    1.401832] s3c-i2c 12c80000.i2c: slave address 0x00
[    1.401902] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    1.406177] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    1.413676] Advanced Linux Sound Architecture Driver Initialized.
[    1.425111] clocksource: Switched to clocksource mct-frc
[    1.538374] NET: Registered protocol family 2
[    1.543373] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.543799] TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
[    1.547768] TCP: Hash tables configured (established 8192 bind 8192)
[    1.548243] UDP hash table entries: 512 (order: 3, 49152 bytes)
[    1.548826] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes)
[    1.551253] NET: Registered protocol family 1
[    1.555460] RPC: Registered named UNIX socket transport module.
[    1.555530] RPC: Registered udp transport module.
[    1.555578] RPC: Registered tcp transport module.
[    1.555626] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.557953] Trying to unpack rootfs image as initramfs...
[    2.611882] Freeing initrd memory: 8112K (c2000000 - c27ec000)
[    2.630889] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.639384] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    2.740930] NFS: Registering the id_resolver key type
[    2.741405] Key type id_resolver registered
[    2.741460] Key type id_legacy registered
[    2.741779] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    2.751948] bounce: pool size: 64 pages
[    2.752041] io scheduler noop registered
[    2.752076] io scheduler deadline registered
[    2.754658] io scheduler cfq registered (default)
[    2.777976] 12130000.phy supply vbus not found, using dummy regulator
[    2.783590] 12100000.phy supply vbus not found, using dummy regulator
[    2.783991] 12100000.phy supply vbus-boost not found, using dummy regulator
[    2.786673] 12500000.phy supply vbus not found, using dummy regulator
[    2.787076] 12500000.phy supply vbus-boost not found, using dummy regulator
[    2.825399] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-241330
[    2.825440] dma-pl330 121a0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    2.853163] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-241330
[    2.853206] dma-pl330 121b0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    2.861305] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-241330
[    2.861346] dma-pl330 10800000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    3.434364] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.448226] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 76, base_baud = 0) is a S3C6400/10
[    3.451531] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 77, base_baud = 0) is a S3C6400/10
[    3.454276] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 78, base_baud = 0) is a S3C6400/10
[    4.961339] console [ttySAC2] enabled
[    4.967171] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 79, base_baud = 0) is a S3C6400/10
[    4.981564] [drm] Initialized drm 1.1.0 20060810
[    4.993954] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd': -517
[    5.103379] brd: module loaded
[    5.166067] loop: module loaded
[    5.175261] libphy: Fixed MDIO Bus: probed
[    5.179518] usbcore: registered new interface driver r8152
[    5.183986] usbcore: registered new interface driver asix
[    5.189229] usbcore: registered new interface driver ax88179_178a
[    5.195293] usbcore: registered new interface driver cdc_ether
[    5.201234] usbcore: registered new interface driver smsc75xx
[    5.206947] usbcore: registered new interface driver smsc95xx
[    5.212533] usbcore: registered new interface driver net1080
[    5.218166] usbcore: registered new interface driver cdc_subset
[    5.224058] usbcore: registered new interface driver zaurus
[    5.229749] usbcore: registered new interface driver cdc_ncm
[    5.236943] exynos-dwc3 soc:usb3-0: no suspend clk specified
[    5.241685] exynos-dwc3 soc:usb3-1: no suspend clk specified
[    5.250614] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.255725] ehci-exynos: EHCI EXYNOS driver
[    5.261306] exynos-ehci 12110000.usb: EHCI Host Controller
[    5.265898] exynos-ehci 12110000.usb: new USB bus registered, assigned bus number 1
[    5.274063] exynos-ehci 12110000.usb: irq 89, io mem 0x12110000
[    5.290248] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[    5.296528] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.301901] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.309094] usb usb1: Product: EHCI Host Controller
[    5.313938] usb usb1: Manufacturer: Linux 4.8.0-xu4ml ehci_hcd
[    5.319745] usb usb1: SerialNumber: 12110000.usb
[    5.331377] hub 1-0:1.0: USB hub found
[    5.334177] hub 1-0:1.0: 3 ports detected
[    5.346639] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.351465] ohci-exynos: OHCI EXYNOS driver
[    5.356554] exynos-ohci 12120000.usb: USB Host Controller
[    5.361060] exynos-ohci 12120000.usb: new USB bus registered, assigned bus number 2
[    5.369111] exynos-ohci 12120000.usb: irq 89, io mem 0x12120000
[    5.435215] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    5.440677] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.451036] usb usb2: Product: USB Host Controller
[    5.454368] usb usb2: Manufacturer: Linux 4.8.0-xu4ml ohci_hcd
[    5.460222] usb usb2: SerialNumber: 12120000.usb
[    5.470257] hub 2-0:1.0: USB hub found
[    5.472773] hub 2-0:1.0: 3 ports detected
[    5.484882] usbcore: registered new interface driver usb-storage
[    5.492112] udc-core: couldn't find an available UDC - added [g_ether] to list of pending drivers
[    5.502592] mousedev: PS/2 mouse device common for all mice
[    5.515535] i2c /dev entries driver
[    5.565161] vdd_ldo9: Bringing 3300000uV into 3000000-3000000uV
[    5.590207] vddq_mmc2: Bringing 3300000uV into 2800000-2800000uV
[    5.604597] vdd_ldo15: Bringing 3300000uV into 3100000-3100000uV
[    5.627972] vdd_sd: Bringing 3300000uV into 2800000-2800000uV
[    5.763205] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as rtc0
[    5.792698] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[    5.798784] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[    5.823322] s3c2410-wdt 101d0000.watchdog: watchdog inactive, reset disabled, irq disabled
[    5.834415] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel at redhat.com
[    5.906444] sdhci: Secure Digital Host Controller Interface driver
[    5.911179] sdhci: Copyright(c) Pierre Ossman
[    5.916313] Synopsys Designware Multimedia Card Interface Driver
[    5.923653] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address mode.
[    5.929186] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[    5.935496] dwmmc_exynos 12200000.mmc: Version ID is 250a
[    5.941022] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 91,64 bit host data width,64 deep fifo
[    5.951131] dwmmc_exynos 12200000.mmc: Got CD GPIO
[    5.955154] dwmmc_exynos 12200000.mmc: allocated mmc-pwrseq
[    5.987072] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[    6.016598] dwmmc_exynos 12200000.mmc: 1 slots initialized
[    6.021878] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address mode.
[    6.028621] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[    6.033898] dwmmc_exynos 12220000.mmc: Version ID is 250a
[    6.039421] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 92,64 bit host data width,64 deep fifo
[    6.074555] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[    6.100553] dwmmc_exynos 12220000.mmc: 1 slots initialized
[    6.124479] s5p-secss 10830000.sss: s5p-sss driver registered
[    6.130437] usbcore: registered new interface driver usbhid
[    6.134533] usbhid: USB HID core driver
[    6.144641] exynos-audss-clk 3810000.audss-clock-controller: setup completed
[    6.154414] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
[    6.164555] mmc1: new high speed SDHC card at address 0007
[    6.176291] mmcblk1: mmc1:0007 SL32G 29.0 GiB
[    6.189221]  mmcblk1: p1 p2
[    6.335992] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
[    6.342033] dma-pl330 3880000.adma:  DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
[    6.493694] exynos-nocp: new NoC Probe device registered: 10ca1000.nocp
[    6.501406] exynos-nocp: new NoC Probe device registered: 10ca1400.nocp
[    6.507705] exynos-nocp: new NoC Probe device registered: 10ca1800.nocp
[    6.514305] exynos-nocp: new NoC Probe device registered: 10ca1c00.nocp
[    6.543455] NET: Registered protocol family 10
[    6.551803] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    6.560630] NET: Registered protocol family 17
[    6.563701] NET: Registered protocol family 15
[    6.568461] Key type dns_resolver registered
[    6.572963] Registering SWP/SWPB emulation handler
[    6.581222] registered taskstats version 1
[    6.609635] [drm] Exynos DRM: using 14450000.mixer device for DMA mapping operations
[    6.621991] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
[    6.631014] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
[    6.636979] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    6.643508] [drm] No driver support for vblank timestamp query.
[    6.649557] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[    6.657109] exynos-dwc3 soc:usb3-0: no suspend clk specified
[    6.677069] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    6.681666] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 3
[    6.690853] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[    6.698706] xhci-hcd xhci-hcd.2.auto: irq 135, io mem 0x12000000
[    6.706038] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    6.711446] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.718639] usb usb3: Product: xHCI Host Controller
[    6.723471] usb usb3: Manufacturer: Linux 4.8.0-xu4ml xhci-hcd
[    6.729279] usb usb3: SerialNumber: xhci-hcd.2.auto
[    6.745775] hub 3-0:1.0: USB hub found
[    6.749150] hub 3-0:1.0: 1 port detected
[    6.756985] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    6.761158] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 4
[    6.769304] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.777554] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    6.783496] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.790699] usb usb4: Product: xHCI Host Controller
[    6.795531] usb usb4: Manufacturer: Linux 4.8.0-xu4ml xhci-hcd
[    6.801338] usb usb4: SerialNumber: xhci-hcd.2.auto
[    6.817156] hub 4-0:1.0: USB hub found
[    6.820680] hub 4-0:1.0: 1 port detected
[    6.837850] exynos-dwc3 soc:usb3-1: no suspend clk specified
[    6.864294] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[    6.868803] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 5
[    6.878997] xhci-hcd xhci-hcd.5.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[    6.887128] xhci-hcd xhci-hcd.5.auto: irq 136, io mem 0x12400000
[    6.898523] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    6.904701] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.912027] usb usb5: Product: xHCI Host Controller
[    6.916297] usb usb5: Manufacturer: Linux 4.8.0-xu4ml xhci-hcd
[    6.922091] usb usb5: SerialNumber: xhci-hcd.5.auto
[    6.933692] hub 5-0:1.0: USB hub found
[    6.936536] hub 5-0:1.0: 1 port detected
[    6.945285] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[    6.949453] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 6
[    6.957908] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.966716] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[    6.972150] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.979339] usb usb6: Product: xHCI Host Controller
[    6.984158] usb usb6: Manufacturer: Linux 4.8.0-xu4ml xhci-hcd
[    6.989975] usb usb6: SerialNumber: xhci-hcd.5.auto
[    7.001938] hub 6-0:1.0: USB hub found
[    7.004559] hub 6-0:1.0: 1 port detected
[    7.019004] rtc rtc1: invalid alarm value: 1900-1-2 0:0:0
[    7.025764] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[    7.047933] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
[    7.061924] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
[    7.072543] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
[    7.082157] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
[    7.090228] usb 3-1: new high-speed USB device number 2 using xhci-hcd
[    7.093504] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
[    7.099508] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
[    7.105157] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
[    7.108593] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
[    7.114826] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
[    7.120974] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
[    7.126826] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
[    7.132557] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
[    7.136811] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[    7.141702] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
[    7.146580] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[    7.153005] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)
[    7.163772] Power domain power-domain at 10044120 disable failed
[    7.202630] devfreq soc:bus_wcore: Couldn't update frequency transition information.
[    7.209025] s5m-rtc s2mps14-rtc: setting system clock to 2016-10-05 07:13:35 UTC (1475651615)
[    7.275209] usb 5-1: new high-speed USB device number 2 using xhci-hcd
[    7.345114] usb 3-1: New USB device found, idVendor=05e3, idProduct=0610
[    7.350416] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    7.357510] usb 3-1: Product: USB2.0 Hub
[    7.361404] usb 3-1: Manufacturer: GenesysLogic
[    7.415145] hub 3-1:1.0: USB hub found
[    7.419174] hub 3-1:1.0: 2 ports detected
[    7.428489] usb 5-1: New USB device found, idVendor=0bda, idProduct=8153
[    7.430628] ALSA device list:
[    7.430632]   No soundcards found.
[    7.440214] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    7.440233] usb 5-1: Product: USB 10/100/1000 LAN
[    7.440250] usb 5-1: Manufacturer: Realtek
[    7.440266] usb 5-1: SerialNumber: 000001000000
[    7.469431] Freeing unused kernel memory: 2048K (c0b00000 - c0d00000)
Loading, please wait...
[    7.662635] usb 5-1: reset high-speed USB device number 2 using xhci-hcd
starting version 229
[    7.942419] r8152 5-1:1.0 eth0: v1.08.6
[   14.520569] random: crng init done
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
Begin: Will now check root file system ... fsck from util-linux 2.27.1
[/sbin/fsck.ext4 (1) -- /dev/mmcblk1p2] fsck.ext4 -y -C0 /dev/mmcblk1p2
e2fsck 1.42.13 (17-May-2015)
rootfs: clean, 478044/1892352 files, 4932280/7560832 blocks
done.
[   21.986013] EXT4-fs (mmcblk1p2): mounted filesystem without journal. Opts: (null)
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
[   23.500468] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   23.524853] systemd[1]: Detected architecture arm.

Welcome to Ubuntu 16.04.1 LTS!

[   23.572858] systemd[1]: Set hostname to <odroid>.
[   25.172926] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[   25.202947] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[   25.227532] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[   25.256654] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   25.282055] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[   25.306151] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   25.331323] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Listening on Journal Socket.
[  OK  ] Started Read required files in advance.
         Starting Uncomplicated firewall...
         Starting Create list of required st... nodes for the current kernel...
         Mounting Debug File System...
         Starting Journal Service...
[  OK  ] Listening on fsck to fsckd communication Socket.
         Starting Load Kernel Modules...
         Starting Nameserver information manager...
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on udev Control Socket.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Reached target User and Group Name Lookups.
[  OK  ] Started Braille Device Support.
[  OK  ] Reached target Swap.
         Starting Set console keymap...
[   26.211220] EXT4-fs (mmcblk1p2): re-mounted. Opts: errors=remount-ro
[  OK  ] Mounted Debug File System.
[  OK  ] Started Uncomplicated firewall.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[FAILED] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Set console keymap.
[  OK  ] Started Nameserver information manager.
         Starting udev Coldplug all Devices...
         Starting Load/Save Random Seed...
         Starting Apply Kernel Variables...
         Mounting Configuration File System...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Mounted Configuration File System.
[  OK  ] Started Journal Service.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Found device /dev/ttySAC2.
[  OK  ] Found device /dev/disk/by-label/boot.
         Starting File System Check on /dev/disk/by-label/boot...
[  OK  ] Started File System Check Daemon to report status.
[  OK  ] Started File System Check on /dev/disk/by-label/boot.
         Mounting /media/boot...
[  OK  ] Mounted /media/boot.
[  OK  ] Reached target Local File Systems.
         Starting Run snappy firstboot setup...
         Starting Set console font and keymap...
         Starting Create Volatile Files and Directories...
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting LSB: AppArmor initialization...
[  OK  ] Started Create Volatile Files and Directories.
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started Run snappy firstboot setup.
[  OK  ] Started LSB: AppArmor initialization.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
         Starting Raise network interfaces...
[  OK  ] Reached target System Time Synchronized.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Raise network interfaces.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Timer to automatically refresh installed snaps.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on CUPS Scheduler.
[  OK  ] Started Trigger resolvconf update for networkd DNS.
[  OK  ] Started Daily Cleanup of Temporary Directories.
         Starting Socket activation for snappy daemon.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Started Daily apt activities.
[  OK  ] Reached target Timers.
[  OK  ] Started CUPS Scheduler.
[  OK  ] Reached target Paths.
[  OK  ] Listening on Socket activation for snappy daemon.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Avahi mDNS/DNS-SD Stack...
         Starting LSB: Load kernel modules needed to enable cpufreq scaling...
         Starting LSB: automatic crash report generation...
[  OK  ] Started Self Monitoring and Reporting Technology (SMART) Daemon.
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started crash report submission daemon.
         Starting Initialize hardware monitoring sensors...
         Starting Login Service...
         Starting LSB: Execute the kexec -e command to reboot system...
         Starting System Logging Service...
[  OK  ] Started Run anacron jobs.
         Starting Restore /etc/resolv.conf i...re the ppp link was shut down...
         Starting Modem Manager...
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
         Starting Network Manager...
         Starting Accounts Service...
         Starting LSB: Speech Dispatcher...
         Starting Permit User Sessions...
         Starting LSB: Set the CPU Frequency Scaling governor to "ondemand"...
[  OK  ] Started CUPS Scheduler.
[  OK  ] Started Make remote CUPS printers available locally.
[  OK  ] Started Avahi DNS Configuration Daemon.
[  OK  ] Started Snappy daemon.
[  OK  ] Started System Logging Service.
[  OK  ] Started Restore /etc/resolv.conf if...fore the ppp link was shut down.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Initialize hardware monitoring sensors.
[   45.216172] scsi host0: runtime PM trying to activate child device host0 but parent (4-1.1:1.0) is not active
[  OK  ] Started LSB: automatic crash report generation.
[  OK  ] Started LSB: Execute the kexec -e command to reboot system.
[  OK  ] Started LSB: Speech Dispatcher.
[  OK  ] Started LSB: Set the CPU Frequency Scaling governor to "ondemand".
[  OK  ] Started Login Service.
         Starting Authenticate and Authorize Users to Run Privileged Tasks...
         Starting LSB: Load kernel image with kexec...
         Starting Light Display Manager...
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
         Starting OpenBSD Secure Shell server...
         Starting Network Manager Wait Online...
[  OK  ] Started Authenticate and Authorize Users to Run Privileged Tasks.
[  OK  ] Started LSB: Load kernel image with kexec.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Started Accounts Service.
         Starting Network Manager Script Dispatcher Service...
[  OK  ] Started Modem Manager.
[  OK  ] Started LSB: Load kernel modules needed to enable cpufreq scaling.
         Starting LSB: set CPUFreq kernel parameters...
[  OK  ] Started Light Display Manager.
[  OK  ] Started Network Manager Script Dispatcher Service.
         Starting Hostname Service...
[  OK  ] Started LSB: set CPUFreq kernel parameters.
[FAILED] Failed to start Hostname Service.
See 'systemctl status systemd-hostnamed.service' for details.
[  OK  ] Created slice User Slice of lightdm.
         Starting User Manager for UID 110...
[  OK  ] Started Session c1 of user lightdm.
[  OK  ] Started User Manager for UID 110.
[  OK  ] Stopped Braille Device Support.
[  OK  ] Started Braille Device Support.
[FAILED] Failed to start Network Manager Wait Online.
See 'systemctl status NetworkManager-wait-online.service' for details.
[  OK  ] Reached target Network is Online.
         Starting LSB: disk temperature monitoring daemon...
         Starting /etc/rc.local Compatibility...
         Starting LSB: Start NTP daemon...
[  OK  ] Started /etc/rc.local Compatibility.
         Starting Hold until boot process finishes up...
[  OK  ] Started LSB: disk temperature monitoring daemon.
[  OK  ] Started Hold until boot process finishes up.
[  OK  ] Started Serial Getty on ttySAC2.
         Starting Set console scheme...
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started LSB: Start NTP daemon.
[  OK  ] Started Set console scheme.
[  OK  ] Reached target Multi-User System.
         Starting Notify bootloader that boot was successful...
[  OK  ] Started TLP system startup/shutdown.
[  OK  ] Reached target Graphical Interface.
[  OK  ] Started Stop ureadahead data collection 45s after completed startup.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Notify bootloader that boot was successful.
[  OK  ] Started Update UTMP about System Runlevel Changes.

Ubuntu 16.04.1 LTS odroid ttySAC2

odroid login: odroid
Password:

Login incorrect
odroid login: odroid
Password:
Last login: Wed Oct  5 06:52:49 UTC 2016 from 10.0.0.104 on pts/0
Welcome to Ubuntu 16.04.1 LTS (GNU/Linux 4.8.0-xu4ml armv7l)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

9 packages can be updated.
0 updates are security updates.

odroid at odroid:~$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
odroid at odroid:~$
