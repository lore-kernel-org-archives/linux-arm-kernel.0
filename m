From: b-liu@ti.com (Bin Liu)
Date: Fri, 19 Aug 2016 16:25:40 -0500
Subject: [PATCH v2 0/7] musb: sunxi: Add support for run-time changing
 dr-mode through sysfs
In-Reply-To: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160819212540.GB1853@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 15, 2016 at 09:21:25PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a patch series which implements run-time changing the dr-mode
> of sunxi musb controllers through the (already existing) musb "mode"
> sysfs attribute.
> 
> This is useful on boards where there is no id pin, e.g. some tv-boxes
> use the musb controller to get an extra usb A port without needing
> a hub chip. Except for the missing id pin when using a usb A<->A cable
> these ports can do peripheral mode just fine. This series makes it
> possible to do e.g. this by doing echo "peripheral" > mode before
> plugging in the usb A<->A cable.

Well, this is an illegal usecase. A-A cable is invalid by USB Spec.
With type-A receptacle the controller should be in host-only mode,
switching to peripheral mode should not be allowed.

> 
> This series has both sun4i-usb-phy driver and sunxi-musb-glue changes,
> both are necessary for the run-time changing to work, but they can be
> merged independently without breaking anything.
> 
> Changed in v2:
> 
> After sleeping on it a night I realized that always passing port_mode =
> DUAL_ROLE to the musb-core was wrong. There is a distintion between
> the id-pin not working properly which we can work around with software
> mode switching (and we want to register both the host and udc driver
> in this case) vs cases where we really only want to register a host
> (wifi module connected to musb soldered onto the PCB).
> 
> So v2 of this series drops the
> "musb: sunxi: Always register both host and udc when build with dual-role support"
> patch.
> 
> Instead systems which are dual-role capable, but lack an id-pin should use
> dr_mode = "otg" in the dts file. There is one problem with this, some
> systems are dual-role capable but use a female USB-A connector connected
> to the musb controller. These should come up in host mode by default,

This is not a problem. With a type-A connector, the dual-role controller
should work in host-only mode.

Role switching should only be allowed if an AB connector is used.

Using the sysfs entry to switch roles for generic purpose is really a
bad idea, it opens up ton of problems.

For systems which lack of id-pin should use a discrete circuit (for
example GPIO) to detect the id pin in the AB receptacle, then the USB
driver will handle the role switching transparently.

> rather then peripheral mode which is the default for systems which lack an
> id-pin. This patch set introduces:
> 
> "phy-sun4i-usb: Add "allwinner,usb0-usb-a-connector" dt property"
> 
> Which allows specifying the use of a female USB-A connector for the
> musb controller in the phy dt node, the presence of this dt property
> changes the default to host mode.

This is unnecessary, if using a type-A connector, dr_mode should be
"host" in DT.

> 
> Please review (and if no issues are found merge).
> 
> Thanks & Regards,
> 
> Hans

Regards,
-Bin.
