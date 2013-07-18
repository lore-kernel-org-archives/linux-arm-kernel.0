From: sr@denx.de (Stefan Roese)
Date: Thu, 18 Jul 2013 11:14:39 +0200
Subject: [PATCH] ARM: omap2: fix musb usage for n8x0
In-Reply-To: <1374000777-5626-1-git-send-email-zonque@gmail.com>
References: <1374000777-5626-1-git-send-email-zonque@gmail.com>
Message-ID: <51E7B1FF.6000301@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 08:52 PM, Daniel Mack wrote:
> Commit b7e2e75a8c ("usb: gadget: drop unused USB_GADGET_MUSB_HDRC")
> dropped a config symbol that was unused by the musb core, but it turns
> out that board support code had references to it.
> 
> As the core now has a fall-back to host-only mode if support for
> dual-role is not compiled in, so we can just pass MUSB_OTG as
> mode from board files.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Reported-and-tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I'm testing musb as OTG on beagleboard (old one, not Beagle-xm). And
using the latest kernel.org version with this patch applied I see the
following messages while booting (repeatedly):

[    4.998168] usb usb1: bus auto-suspend, wakeup 1
[    5.003112] musb_bus_suspend 2457: trying to suspend as b_idle while active
[    5.010498] usb usb1: bus suspend fail, err -16
[    5.015289] hub 1-0:1.0: hub_resume
[    5.019073] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[    5.024963] hub 1-0:1.0: hub_suspend
[    5.028778] usb usb1: bus auto-suspend, wakeup 1
...

This is without a cable connected to the OTG port.

Any ideas what might be missing here?

BTW: I enabled USB support for beagle in the dts this way:

+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};

Thanks,
Stefan
