From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 12:37:39 +0200
Subject: [PATCH v7, 0/8] Add MediaTek USB3 DRD Driver
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <28f6db69-88ca-4715-1e46-6d5e5efb949c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunfeng,

On 10/19/2016 04:28 AM, Chunfeng Yun wrote:
> These patches introduce the MediaTek USB3 dual-role controller
> driver.
>
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only (xHCI) modes. It works well
> with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
> tested on MT8173 platform which only contains USB2.0 device IP,
> and on MT6290 platform which contains USB3.0 device IP.
>
> Change in v7:
> 1. split dual-role driver into four patchs
> 2. remove QMU done tasklet
> 3. add a bool in xhci_hcd_mtk to signal absence of IPPC
>
> Change in v6:
> 1. handle endianness of GPD and SETUP data
> 2. remove dummy error log and return suitable error number
> 3. cancel delay work when deregiseter driver
>
> Change in v5:
> 1. modify some comments
> 2. rename some unsuitable variables
> 3. add reg-names property for host node
> 4. add USB_MTU3_DEBUG to control debug messages
>
> Change in v4:
> 1. fix build errors on non-mediatek platforms
> 2. provide manual dual-role switch via debugfs instead of sysfs
>
> Change in v3:
> 1. fix some typo error
> 2. rename mtu3.txt to mt8173-mtu3.txt
>
> Change in v2:
> 1. modify binding docs according to suggestions
> 2. modify some comments and remove some dummy blank lines
> 3. fix memory leakage
>
>
> Chunfeng Yun (8):
>   dt-bindings: mt8173-xhci: support host side of dual-role mode
>   dt-bindings: mt8173-mtu3: add devicetree bindings
>   usb: xhci-mtk: make IPPC register optional
>   usb: Add MediaTek USB3 DRD driver
>   usb: mtu3: Super-Speed Peripheral mode support
>   usb: mtu3: host only mode support
>   usb: mtu3: dual-role mode support
>   arm64: dts: mediatek: add USB3 DRD driver
>

I tried the driver with my mt8173-evb, but wasn't able to get USB 
working (no usb stick detected when adding to the usb port).

# dmesg |grep mtu
[    0.428420] mtu3 11271000.usb: failed to get vusb33
[    0.510570] mtu3 11271000.usb: failed to get vbus
[    0.592103] mtu3 11271000.usb: failed to get vbus


Relevant config options:
CONFIG_USB_MTU3=y
CONFIG_USB_MTU3_HOST=y
CONFIG_USB_MTU3_DEBUG=y
CONFIG_PHY_MT65XX_USB3=y


Looks like an error in the device tree. I can see that the mt6397 
regulater get's initialized *after* the mtu3 driver:
[    0.505166] mt6397-regulator mt6397-regulator: Chip ID = 0x4097

Not sure if this is related.
Any idea whats going wrong here?

Cheers,
Matthias
