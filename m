From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jan 2012 14:21:39 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F1897@HQMAIL01.nvidia.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885077F82@039-SN2MPN1-013.039d.mgd.msft.net>
 <20111229024647.GA11309@S2100-06.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1897@HQMAIL01.nvidia.com>
Message-ID: <20120106062137.GB4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 03:45:56PM -0800, Stephen Warren wrote:
> Shawn Guo wrote at Wednesday, December 28, 2011 7:47 PM:
> > On Tue, Dec 27, 2011 at 02:41:25PM +0000, Dong Aisheng-B29396 wrote:
> ...
> > > I was ever thought putting a phandle of pinmux function in each device,
> > > Then pinmux mapping table seems not need anymore. Like:
> > >
> > > usdhc4: usdhc at 0219c000 { /* uSDHC4 */
> > >         compatible = "fsl,imx6q-usdhc";
> > > 	....
> > >         pinmux = <&pinmux-sd4>;
> > > };
> > >
> > > iomuxc at 020e0000 {
> > >         pinmux-sd4 : sd4 {
> > >                 func-name = "sd4";
> > >                 grp-name = "sd4grp";
> > >                 grp-pins = <170 171 180 181 182 183 184 185 186 187>;
> > >                 num-pins = <10>;
> > >                 grp-mux = <0 0 1 1 1 1 1 1 1 1>;
> > >                 num-mux = <10>;
> > >         };
> > >
> > > It is a pure hw point of view to define node.
> > 
> > That's the way we should go for.  This is exactly the same thing that
> > clk and regulator DT support is doing.  And right, in that way, we do
> > not need pinmux mapping for DT at all.
> 
> Well, we'd probably want to have at least a semi-standardized notion of
> how the per-device "pinmux" property worked, much like interrupts and
> GPIOs work in the same way everywhere, albeit perhaps with different
> property names (for GPIOs) and controller-specific flags arguments etc.
> 
Agreed.

> One other thing to note: The per-device data can't be a single phandle
> reference, unless the referenced node is some kind of table,

Just like gpio and clock, it could reasonably be a phandle array
instead of a single phandle for some cases.

> and then
> we do need a pinmux mapping for DT to define the format of that table.
> Reasons being:
> 
> * Devices most likely need to configure more than one pin or group of
> pins, and may need to configure them to different functions, so we at
> least need an array of (pin_group, selected_function) values somewhere.
> 
> * We need to represent both mux function selection and arbitrary other
> per-pin/group configuration parameters.
> 
> * We need to represent pinmux configuration for multiple device/driver
> states; suspend, active, idle, ...?
> 
> ...
> > To make the pinmux api generic for both dt and non-dt users, the pinmux
> > client driver should still see/call pinmux_get, something like
> > of_pinmux_get should be sorted out behind pinmux_get.
> > 
> > > But what about the pin maps without device associated?
> >
> > Do we have such cases?
> 
> I think so.
> 
> At least early on, not all drivers will be pinmux-aware, and we'll still
> need to set up the pinmux for them. A system wide "pinmux initial
> configuration table" or similar would be needed to do this, I think.
> This may be transitional.

Ok.  But on imx, we usually have those early pinmux setting done in
bootloader.

Regards,
Shawn

> 
> I can easily see cases where we don't have an explicit driver for HW,
> but still need to set up random pinmux configuration as part of basic
> system initialization. Perhaps ideally we'd always tie pinmux usage to
> some specific device, but the flexibility of not having to do so seems
> useful.
> 
