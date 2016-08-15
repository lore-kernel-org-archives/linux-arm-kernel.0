From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Aug 2016 21:21:25 +0200
Subject: [PATCH v2 0/7] musb: sunxi: Add support for run-time changing dr-mode
 through sysfs
Message-ID: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a patch series which implements run-time changing the dr-mode
of sunxi musb controllers through the (already existing) musb "mode"
sysfs attribute.

This is useful on boards where there is no id pin, e.g. some tv-boxes
use the musb controller to get an extra usb A port without needing
a hub chip. Except for the missing id pin when using a usb A<->A cable
these ports can do peripheral mode just fine. This series makes it
possible to do e.g. this by doing echo "peripheral" > mode before
plugging in the usb A<->A cable.

This series has both sun4i-usb-phy driver and sunxi-musb-glue changes,
both are necessary for the run-time changing to work, but they can be
merged independently without breaking anything.

Changed in v2:

After sleeping on it a night I realized that always passing port_mode =
DUAL_ROLE to the musb-core was wrong. There is a distintion between
the id-pin not working properly which we can work around with software
mode switching (and we want to register both the host and udc driver
in this case) vs cases where we really only want to register a host
(wifi module connected to musb soldered onto the PCB).

So v2 of this series drops the
"musb: sunxi: Always register both host and udc when build with dual-role support"
patch.

Instead systems which are dual-role capable, but lack an id-pin should use
dr_mode = "otg" in the dts file. There is one problem with this, some
systems are dual-role capable but use a female USB-A connector connected
to the musb controller. These should come up in host mode by default,
rather then peripheral mode which is the default for systems which lack an
id-pin. This patch set introduces:

"phy-sun4i-usb: Add "allwinner,usb0-usb-a-connector" dt property"

Which allows specifying the use of a female USB-A connector for the
musb controller in the phy dt node, the presence of this dt property
changes the default to host mode.

Please review (and if no issues are found merge).

Thanks & Regards,

Hans
