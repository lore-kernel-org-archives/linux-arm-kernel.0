From: jiangyanpin77@gmail.com (jiangyanpin77)
Date: Tue, 18 Oct 2016 09:12:43 +0800
Subject: Can s3c2416 use two usb host?
Message-ID: <ED961CC5932C48DEA8389141BFFFD396@jyp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on samsung s3c2416 ARM based Soc on
 linux 3.1.8 kernel. By default, the Soc has one
 USB host and one USB device/host. My USB host is
 working fine. Since I need to use two USB host on my system,
  I need to enable the USB device/host as a USB host.
 I am using ARM9 based s3c2416 processor. The SoC has one USB host
controller and one USB host/device controller. What are the
register settings that should be done to enable both USB
interfaces as USB host controller. ? There is a register PHYCTRL
with address 0x4C00_0080. Its bit[0] says something on USB host
mode and USB device mode. Is it this register which I should
work on or any more register configurations are required ?





 The following are the changes I have made for the same:

 Register  Address        value
  -----------------------------
  PHYPWR    0x4C00_0084    0x0
  PWRCFG    0x4C00_0060    (1<<4)
  URSTCON   0x4C00_0088    (0<<2)|(1<<1)|(1<<0)
  URSTCON   0x4C00_0088    (0<<2)|(0<<1)|(0<<0)
  PHYCTRL   0x4C00_0080    (0<<3)|(0<<2)|(1<<1)|(1<<0)
  UCLKCON   0x4C00_008C    0<<31)|(0<<2)|(1<<1)|(1<<0)
 
  Once I try to plug in a  USB mass storage device (whose driver is present in
  kernel), I get the following error:
 
  usb 1-2: new full speed USB device using s3c2410-ohci and address 10
  usb 1-2: device descriptor read/64, error -62
  usb 1-2: device descriptor read/64, error -62
  usb 1-2: new full speed USB device using s3c2410-ohci and address 11
  usb 1-2: device descriptor read/64, error -62
  usb 1-2: device descriptor read/64, error -62
  usb 1-2: new full speed USB device using s3c2410-ohci and address 12
  usb 1-2: device not accepting address 12, error -62
  usb 1-2: new full speed USB device using s3c2410-ohci and address 13
  usb 1-2: device not accepting address 13, error -62
 
 
  Why is it throwing this error ? Is there any driver for USB hub missing in
   linux 3.1.8 kernel, or do I need to modify more on register settings.
 
  Please help.
 
  Thank You
  YanpinJiang
