From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 31 Oct 2016 11:31:30 +0800
Subject: [PATCH v7, 0/8] Add MediaTek USB3 DRD Driver
In-Reply-To: <28f6db69-88ca-4715-1e46-6d5e5efb949c@gmail.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
 <28f6db69-88ca-4715-1e46-6d5e5efb949c@gmail.com>
Message-ID: <1477884690.4516.35.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-28 at 12:37 +0200, Matthias Brugger wrote:
> Hi Chunfeng,
> 
> On 10/19/2016 04:28 AM, Chunfeng Yun wrote:
> > These patches introduce the MediaTek USB3 dual-role controller
> > driver.
> >
> > The driver can be configured as Dual-Role Device (DRD),
> > Peripheral Only and Host Only (xHCI) modes. It works well
> > with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
> > tested on MT8173 platform which only contains USB2.0 device IP,
> > and on MT6290 platform which contains USB3.0 device IP.
[...]
> >
> > Change in v2:
> > 1. modify binding docs according to suggestions
> > 2. modify some comments and remove some dummy blank lines
> > 3. fix memory leakage
> >
> >
> > Chunfeng Yun (8):
> >   dt-bindings: mt8173-xhci: support host side of dual-role mode
> >   dt-bindings: mt8173-mtu3: add devicetree bindings
> >   usb: xhci-mtk: make IPPC register optional
> >   usb: Add MediaTek USB3 DRD driver
> >   usb: mtu3: Super-Speed Peripheral mode support
> >   usb: mtu3: host only mode support
> >   usb: mtu3: dual-role mode support
> >   arm64: dts: mediatek: add USB3 DRD driver
> >
> 
> I tried the driver with my mt8173-evb, but wasn't able to get USB 
> working (no usb stick detected when adding to the usb port).
> 
Can you test it again by USB3.0 type-A port? If it works, then
regulators of vusb33 and vbus are got after PROBE_DEFER of
mt6397-regulator driver;

For OTG port, need cherry pick a patch:

https://patchwork.kernel.org/patch/9055261/

which is abandoned because GPIO driver owner wants to fix all pins with
the same problem.

Then device will be recognized well when connected to PC with OTG cable.

But it is a trouble for OTG host mode, due to vbus 5.5V of OTG port is
originally provided by charger driver which is not upstreamed on EVB
board, we need rework the board to control vbus by gpio.
There is a simple way, you can plug in a self-powered hub to test OTG
host mode.


> # dmesg |grep mtu
> [    0.428420] mtu3 11271000.usb: failed to get vusb33
> [    0.510570] mtu3 11271000.usb: failed to get vbus
> [    0.592103] mtu3 11271000.usb: failed to get vbus
> 
> 
> Relevant config options:
> CONFIG_USB_MTU3=y
> CONFIG_USB_MTU3_HOST=y
> CONFIG_USB_MTU3_DEBUG=y
> CONFIG_PHY_MT65XX_USB3=y
> 
> 
> Looks like an error in the device tree. I can see that the mt6397 
> regulater get's initialized *after* the mtu3 driver:
> [    0.505166] mt6397-regulator mt6397-regulator: Chip ID = 0x4097
> 
> Not sure if this is related.
> Any idea whats going wrong here?
> 
as above.

Sorry for inconvenience

> Cheers,
> Matthias
