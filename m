From: b-liu@ti.com (Bin Liu)
Date: Fri, 13 Jan 2017 15:00:13 -0600
Subject: [PATCH 4/4] ARM: dts: sun8i: add OTG function to Lichee Pi Zero
In-Reply-To: <20170112173938.5am5njwrbs6p62br@lukather>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
 <20170103152534.20118-5-icenowy@aosc.xyz>
 <20170110202443.GC2479@uda0271908>
 <2733831484164533@web1g.yandex.ru>
 <20170111200811.GA16865@uda0271908>
 <20170111210638.ppdnpzdd2l6x4lyo@lukather>
 <20170112145014.GC16865@uda0271908>
 <20170112173938.5am5njwrbs6p62br@lukather>
Message-ID: <20170113210013.GA28184@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 06:39:38PM +0100, Maxime Ripard wrote:
> Hi Bin,
> 
> On Thu, Jan 12, 2017 at 08:50:14AM -0600, Bin Liu wrote:
> > On Wed, Jan 11, 2017 at 10:06:38PM +0100, Maxime Ripard wrote:
> > > On Wed, Jan 11, 2017 at 02:08:11PM -0600, Bin Liu wrote:
> > > > On Thu, Jan 12, 2017 at 03:55:33AM +0800, Icenowy Zheng wrote:
> > > > > 
> > > > > 
> > > > > 11.01.2017, 04:24, "Bin Liu" <b-liu@ti.com>:
> > > > > > On Tue, Jan 03, 2017 at 11:25:34PM +0800, Icenowy Zheng wrote:
> > > > > >> ?Lichee Pi Zero features a USB OTG port.
> > > > > >>
> > > > > >> ?Add support for it.
> > > > > >>
> > > > > >> ?Note: in order to use the Host mode, the board must be powered via the
> > > > > >> ?+5V and GND pins.
> > > > > >>
> > > > > >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> > > > > >> ?---
> > > > > >> ??arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 10 ++++++++++
> > > > > >> ??1 file changed, 10 insertions(+)
> > > > > >>
> > > > > >> ?diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > > > > >> ?index 0099affc6ce3..3d9168cbaeca 100644
> > > > > >> ?--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > > > > >> ?+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > > > > >> ?@@ -71,3 +71,13 @@
> > > > > >> ??????????pinctrl-names = "default";
> > > > > >> ??????????status = "okay";
> > > > > >> ??};
> > > > > >> ?+
> > > > > >> ?+&usb_otg {
> > > > > >> ?+ dr_mode = "otg";
> > > > > >
> > > > > > Why not set this default mode in dtsi instead?
> > > > > >
> > > > > > Regards,
> > > > > > -Bin.
> > > > > 
> > > > > There's possibly boards which do not have OTG functions.
> > > > 
> > > > That is board specific.
> > > 
> > > Exactly, and this is why it should be done in the board DT.
> > 
> > I am just suggesting based on the common practice. If a .dtsi exists for
> > a family, the .dtsi describes the device and common properties for all
> > possible boards, and each board .dts adds or overrides its specific
> > implementation. Kernel has many devices/boards done in this way - define
> > the default dr_mode in .dtsi.
> > 
> > In this case, I suggest to set the common dr_mode in .dtsi, then each
> > board .dts only overrides it if the implementation is different. 
> > 
> > > 
> > > The controller in the Allwinner SoCs do not handle directly the ID pin
> > > and VBUS, but rather rely on a GPIO to do so.
> > > 
> > > So boards with OTG will need setup anyway, at least to tell which
> > > GPIOs are used. There's no point in enforcing a default if it doesn't
> > > work by default.
> > 
> > Then define a default which supposes to work for most boards.
> > 
> > Why I suggest this, is because defining a default dr_mode which works
> > for most cases in dtsi could prevent a little surprise in MUSB function.
> > If someone designs a new board but forgets to define dr_mode in the new
> > board DT, the MUSB driver will default to org mode, which might not be
> > intended.
> 
> The point is that there is no sensible default. Some boards don't have
> an ID pin and no VBUS (peripheral), some don't have an ID pin but VBUS
> (host), and some have an ID pin but no controllable VBUS, some have an
> ID pin and a controllable VBUS, but we have no idea which GPIOs are
> used.
> 
> There's no way we can have something that works on most cases.

Ok, understood.

Regards,
-Bin.
