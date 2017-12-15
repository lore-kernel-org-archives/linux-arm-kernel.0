From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 14:55:04 -0600
Subject: [PATCH 0/7] Add USB remote wakeup driver
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20171215205504.r6ol7fbbeyghb73w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 09, 2017 at 04:45:29PM +0800, Chunfeng Yun wrote:
>     These patches introduce the SSUSB and SPM glue layer driver which is
> used to support usb remote wakeup. Usually the glue layer is put into
> a system controller, such as PERICFG module.
>     The old way to support usb wakeup is put into SSUSB controller drivers,
> including xhci-mtk driver and mtu3 driver, but there are some problems:
>     1. can't disdinguish the relation between glue layer and SSUSB IP
>        when SoCs supports multi SSUSB IPs;
>     2. duplicated code for wakeup are put into both xhci-mtk and mtu3
>        drivers;
>     3. the glue layer may vary on different SoCs with SSUSB IP, and will
>        make SSUSB controller drivers complicated;
>     In order to resolve these problems, it's useful to make the glue layer
> transparent by extracting a seperated driver, meanwhile to reduce the
> duplicated code and simplify SSUSB controller drivers.

Both the driver and binding look overly complicated to me when it looks 
like you just have 2 versions of enable/disable functions which modify 
a single register. The complexity may be justified if this was a common 
binding and driver, but it is not.

You already have a phandle to the system controller. Can't you add cells 
to it to handle any differences between instances? That and SoC specific 
compatible strings should be enough to handle differences.

Rob
